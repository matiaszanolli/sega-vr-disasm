"""Exact observer C/Python SRAM phase parity; standalone, not raw acceptance."""
import ctypes
import hashlib
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[5]
sys.path.insert(0, str(ROOT / "tools/libretro-profiling"))
import q028_image_domains as domains
from q028_image_state import ImageState, ImageStateError


def main():
    source = (ROOT / "tools/libretro-profiling/q028_all_access_observer.inc").read_text()
    start = source.index("static void vrd_q028_sram_access(")
    end = source.index("\nstatic void vrd_q028_wram_access(", start)
    function = source[start:end]
    _, manifest, tables = domains.auxiliary_rows((ROOT / "build/vr_rebuild.32x").read_bytes())
    harness = tables + '''
#include <string.h>
struct vrd_q028_sram_state { unsigned int active, installing, offset, pending; };
static struct vrd_q028_sram_state vrd_q028_sram_state[3];
static unsigned int vrd_q028_errors;
''' + function + '''
void clear_state(void) { memset(vrd_q028_sram_state,0,sizeof(vrd_q028_sram_state)); vrd_q028_errors=0; }
void access_event(unsigned int cpu,unsigned int pc,unsigned int raw,unsigned int width,unsigned int value,unsigned int write) {
    vrd_q028_sram_access(cpu,pc,raw,width,value,write);
}
unsigned int field(unsigned int cpu,unsigned int index) {
    struct vrd_q028_sram_state *s=&vrd_q028_sram_state[cpu];
    switch(index) { case 0:return s->active; case 1:return s->installing; case 2:return s->offset; case 3:return s->pending; default:return vrd_q028_errors; }
}
'''
    with tempfile.TemporaryDirectory(prefix="q028-sram-phase-parity-") as temp:
        path = Path(temp)
        (path / "parity.c").write_text(harness)
        subprocess.run(["cc", "-shared", "-fPIC", "-O2", "-Wall", "-Werror", "-Wno-unused-const-variable",
                        str(path / "parity.c"), "-o", str(path / "parity.so")], check=True)
        lib = ctypes.CDLL(str(path / "parity.so"))
        lib.access_event.argtypes = [ctypes.c_uint] * 6
        lib.field.argtypes = [ctypes.c_uint] * 2
        lib.field.restype = ctypes.c_uint
        transitions = mutations = 0

        def fresh():
            lib.clear_state()
            return ImageState(manifest)

        def apply(state, event, bad=False):
            nonlocal transitions, mutations
            before = lib.field(1, 4)
            lib.access_event(*event)
            rejected = False
            try:
                state.data(*event)
            except ImageStateError:
                rejected = True
            assert rejected == bad, (event, rejected, bad)
            assert lib.field(1, 4) == before + int(bad), event
            if bad:
                mutations += 1
                return
            transitions += 1
            for cpu in (1, 2):
                assert lib.field(cpu, 0) == state.active[cpu]
                phase = state.installing[cpu]
                assert lib.field(cpu, 1) == (phase[0]-1 if phase else 0)
                if phase:
                    assert [lib.field(cpu, 2), lib.field(cpu, 3)] == phase[1:]

        def events(image, cpu):
            data = bytes.fromhex(image["bytes"])
            result = []
            for offset in range(0, image["size"], 4):
                value = int.from_bytes(data[offset:offset+4], "big")
                result.extend([(cpu,image["read_pc"],image["source"]+offset,4,value,False),
                               (cpu,image["write_pc"],image["destination"]+offset,4,value,True),
                               (cpu,image["dt_pc"],image["dt_pc"]&image["dt_address_mask"],2,image["dt_opcode"],False)])
            return result

        for image in manifest["sram_copies"]:
            state = fresh()
            originals = {view: row["data"] for view, row in state.copies.items()}
            streams = [events(image,cpu) for cpu in (1,2)]
            for index, pair in enumerate(zip(*streams)):
                for event in pair:
                    apply(state,event)
                if index < len(streams[0])-1:
                    assert state.active[1:] == [0,0]
                    try:
                        state.finish()
                        raise AssertionError("open install accepted at EOF")
                    except ImageStateError:
                        pass
            state.finish()
            assert originals == {view: row["data"] for view,row in state.copies.items()}
            for cpu in (1,2):
                stream=events(image,cpu)
                # DT field, position, omission, duplicate and copy-pair mutations.
                cases=[]
                for field, value in ((0,3-cpu),(1,image["dt_pc"]+2),(2,image["dt_pc"]+2),
                                     (3,4),(4,image["dt_opcode"]^1),(5,True)):
                    bad=list(stream[2]); bad[field]=value
                    cases.append((stream[:2],tuple(bad)))
                cases += [([],stream[2]), (stream[:1],stream[2]), (stream[:2],stream[3]),
                          (stream[:3],stream[2]), (stream,stream[-1]),
                          (stream[:1],stream[0]), (stream[:2],stream[1])]
                bad=list(stream[1]); bad[4]^=1
                cases.append((stream[:1],tuple(bad)))
                for prefix,event in cases:
                    state=fresh()
                    for valid in prefix: apply(state,valid)
                    apply(state,event,bad=True)
        print(f"PASS {transitions} exact C/Python transitions; {mutations} malformed phases; function SHA256 {hashlib.sha256(function.encode()).hexdigest()}")


if __name__ == "__main__":
    main()
