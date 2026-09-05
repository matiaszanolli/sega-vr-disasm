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
typedef struct {
  uint64_t count, first_seq;
  uint32_t pc, opcode_hash, first_frame, last_frame, sample_raw, sample_value;
  uint16_t min_slot, max_slot;
  uint8_t cpu, flags, width, used;
} Group;
#define CAP 262144
static Group groups[CAP];
static uint64_t bad_fetch[3], context_bad[3], resets[3], total, unattributed;
static uint32_t pc[3];
static uint16_t slot[3];
static int live[3];
static void group(const Record *r) {
  uint32_t h = (r->pc * 2654435761u ^ r->opcode_hash ^ (r->cpu << 24) ^ (r->flags << 12) ^ r->width) & (CAP-1);
  for (unsigned i=0;i<CAP;i++,h=(h+1)&(CAP-1)) {
    Group *g=&groups[h];
    if (!g->used) {
      *g=(Group){.used=1,.pc=r->pc,.opcode_hash=r->opcode_hash,.cpu=r->cpu,.flags=r->flags,.width=r->width,
        .first_seq=r->seq,.first_frame=r->frame,.sample_raw=r->raw,.sample_value=r->value,.min_slot=r->slot};
    }
    if (g->pc==r->pc && g->opcode_hash==r->opcode_hash && g->cpu==r->cpu && g->flags==r->flags && g->width==r->width) {
      g->count++;g->last_frame=r->frame;
      if(r->slot<g->min_slot)g->min_slot=r->slot;
      if(r->slot>g->max_slot)g->max_slot=r->slot;
      return;
    }
  }
  fprintf(stderr,"group capacity exceeded\n");exit(3);
}
int main(int argc,char **argv) {
  if(argc!=3 || sizeof(Record)!=48) return 2;
  unsigned chunks=(unsigned)strtoul(argv[2],NULL,10);
  for(unsigned c=1;c<=chunks;c++) {
    char path[1024];snprintf(path,sizeof(path),"%s/access-events-v8-%04u.bin",argv[1],c);
    FILE *f=fopen(path,"rb"); if(!f){perror(path);return 2;}
    unsigned char header[64];if(fread(header,1,64,f)!=64)return 2;
    Record rows[8192]; size_t n;
    while((n=fread(rows,sizeof(Record),8192,f))) for(size_t i=0;i<n;i++) {
      Record *r=&rows[i]; if(r->seq!=total){fprintf(stderr,"sequence mismatch\n");return 2;}total++;
      if(!(r->flags&16)){unattributed++;group(r);}
      if(r->cpu<3) {
        unsigned cpu=r->cpu;
        if(r->flags&1) {if(r->slot!=65535)bad_fetch[cpu]++;live[cpu]=1;pc[cpu]=r->pc;slot[cpu]=0;}
        else {
          if(!live[cpu] || pc[cpu]!=r->pc || slot[cpu]!=r->slot) {
            context_bad[cpu]++;
            if(r->pc==0)resets[cpu]++;
            if(context_bad[cpu]<=8)fprintf(stderr,"context cpu=%u seq=%"PRIu64" frame=%u pc=%08x priorpc=%08x slot=%u expected=%u raw=%08x flags=%u irq=%u\n",cpu,r->seq,r->frame,r->pc,pc[cpu],r->slot,slot[cpu],r->raw,r->flags,r->irq);
          }
          slot[cpu]++;
        }
      }
    }
    if(ferror(f)){perror(path);return 2;}fclose(f);
    if(c%250==0)fprintf(stderr,"scanned chunks=%u events=%"PRIu64"\n",c,total);
  }
  fprintf(stderr,"TOTAL events=%"PRIu64" unattributed=%"PRIu64"\n",total,unattributed);
  for(int cpu=0;cpu<3;cpu++)fprintf(stderr,"CPU%d bad_fetch=%"PRIu64" context_bad=%"PRIu64" reset_pc0=%"PRIu64"\n",cpu,bad_fetch[cpu],context_bad[cpu],resets[cpu]);
  puts("cpu,pc,opcode_hash,flags,width,count,first_sequence,first_frame,last_frame,sample_raw,sample_value,min_slot,max_slot");
  for(unsigned i=0;i<CAP;i++){Group *g=&groups[i];if(g->used)printf("%u,0x%08x,0x%08x,%u,%u,%"PRIu64",%"PRIu64",%u,%u,0x%08x,0x%08x,%u,%u\n",g->cpu,g->pc,g->opcode_hash,g->flags,g->width,g->count,g->first_seq,g->first_frame,g->last_frame,g->sample_raw,g->sample_value,g->min_slot,g->max_slot);}
  return 0;
}
