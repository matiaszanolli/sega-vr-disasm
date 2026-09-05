/* Diagnostic only: compare execution records across a passive attribution repair. */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#pragma pack(push,1)
typedef struct {
    uint64_t seq;
    uint32_t frame, order, pc, opcode_hash, raw, normalized, value, site;
    uint16_t slot;
    uint8_t cpu, agent, flags, width, irq, reserved;
} Record;
#pragma pack(pop)

int main(int argc, char **argv)
{
    if (argc != 4 || sizeof(Record) != 48) return 2;
    unsigned chunks = (unsigned)strtoul(argv[3], NULL, 10);
    uint64_t total = 0, resolved[3] = {0,0,0};
    for (unsigned chunk=1; chunk<=chunks; chunk++) {
        FILE *files[2];
        unsigned char headers[2][64];
        for (unsigned arm=0; arm<2; arm++) {
            char path[2048];
            if (snprintf(path,sizeof(path),"%s/access-events-v8-%04u.bin",argv[arm+1],chunk)>=(int)sizeof(path)) return 2;
            files[arm]=fopen(path,"rb");
            if (!files[arm]) { perror(path); return 2; }
            if (fread(headers[arm],1,64,files[arm])!=64) return 2;
        }
        /* Only the site-map identity prefix may differ in these chunk headers. */
        if (memcmp(headers[0],headers[1],48) || memcmp(headers[0]+56,headers[1]+56,8)) {
            fprintf(stderr,"unexpected header difference: chunk %u\n",chunk); return 1;
        }
        Record old[4096], fresh[4096];
        size_t n, m;
        do {
            n=fread(old,sizeof(Record),4096,files[0]);
            m=fread(fresh,sizeof(Record),4096,files[1]);
            if (n!=m) { fprintf(stderr,"record cardinality difference\n"); return 1; }
            for (size_t i=0; i<n; i++,total++) {
                if (old[i].seq!=total || fresh[i].seq!=total) return 1;
                Record normalized=fresh[i];
                if (!(old[i].flags&16)) {
                    if ((old[i].cpu!=1 && old[i].cpu!=2) || old[i].pc<0xc0000000u || old[i].pc>=0xc0001000u ||
                        old[i].site || old[i].opcode_hash || !fresh[i].site || !fresh[i].opcode_hash ||
                        fresh[i].flags!=(old[i].flags|16)) {
                        fprintf(stderr,"unexpected attribution transition at %"PRIu64"\n",total); return 1;
                    }
                    normalized.site=old[i].site;
                    normalized.opcode_hash=old[i].opcode_hash;
                    normalized.flags=old[i].flags;
                    resolved[old[i].cpu]++;
                }
                if (memcmp(&old[i],&normalized,sizeof(Record))) {
                    fprintf(stderr,"execution-field difference at %"PRIu64"\n",total); return 1;
                }
            }
        } while(n);
        for (unsigned arm=0; arm<2; arm++) {
            if (ferror(files[arm])) return 2;
            if (fclose(files[arm])) return 2;
        }
    }
    printf("{\"status\":\"PASS_DIAGNOSTIC_EXECUTION_FIELDS_UNCHANGED\",\"records\":%"PRIu64
           ",\"resolved_master\":%"PRIu64",\"resolved_slave\":%"PRIu64"}\n",total,resolved[1],resolved[2]);
    return 0;
}
