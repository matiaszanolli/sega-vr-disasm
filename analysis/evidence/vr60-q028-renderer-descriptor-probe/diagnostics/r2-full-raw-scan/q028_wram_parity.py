"""Standalone diagnostic: exact observer WRAM transitions and host-byte comparison."""
import ctypes
import hashlib
import json
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT=Path('/mnt/data/src/32x-playground')
sys.path.insert(0,str(ROOT/'tools/libretro-profiling'))
import q028_image_domains as domains
from q028_image_state import WramState, ImageStateError

observer=(ROOT/'tools/libretro-profiling/q028_all_access_observer.inc').read_text()
start=observer.index('static void vrd_q028_wram_access(')
opening=observer.index('{',start)
depth=1; end=opening+1
while depth:
    depth += (observer[end]=='{')-(observer[end]=='}')
    end+=1
function=observer[start:end]
check_start=observer.index('            if (!cpu && pc>=0xff0000u && pc<0xff0020u && context->view) {')
check_opening=observer.index('{',check_start)
depth=1; check_end=check_opening+1
while depth:
    depth += (observer[check_end]=='{')-(observer[check_end]=='}')
    check_end+=1
host_check=observer[check_start:check_end]
rows,manifest,generated=domains.auxiliary_rows((ROOT/'build/vr_rebuild.32x').read_bytes())
prefix='''#include <string.h>
struct vrd_q028_sram_state { unsigned int active, installing, offset, pending; };
static struct vrd_q028_sram_state vrd_q028_wram_state;
static unsigned char vrd_q028_wram_bytes[32];
static unsigned long long vrd_q028_errors;
static struct { unsigned char ram[64]; } PicoMem;
struct test_context { unsigned int view; };
'''
suffix='''
void reset_state(void) { memset(&vrd_q028_wram_state,0,sizeof(vrd_q028_wram_state)); memset(vrd_q028_wram_bytes,0,32); vrd_q028_errors=0; }
void access_state(unsigned pc,unsigned raw,unsigned width,unsigned value,unsigned write) { vrd_q028_wram_access(pc,raw,width,value,write); }
unsigned active_state(void) { return vrd_q028_wram_state.active; }
unsigned byte_state(unsigned offset) { return vrd_q028_wram_bytes[offset]; }
unsigned errors_state(void) { return (unsigned)vrd_q028_errors; }
void sync_host(void) { unsigned i; memset(PicoMem.ram,0xA5,sizeof(PicoMem.ram)); for (i=0;i<32;i++) PicoMem.ram[i^1]=vrd_q028_wram_bytes[i]; }
void flip_host(unsigned offset) { PicoMem.ram[offset^1]^=1; }
unsigned host_byte(unsigned offset) { return PicoMem.ram[offset^1]; }
'''
suffix+='\nvoid check_host(unsigned cpu,unsigned pc,unsigned view) { struct test_context value={view}; struct test_context *context=&value;\n'+host_check+'\n}\n'
with tempfile.TemporaryDirectory(prefix='q028-wram-parity-') as directory:
    path=Path(directory)
    (path/'observer-wram.c').write_text(prefix+generated+'\n'+function+suffix)
    subprocess.run(['cc','-shared','-fPIC','-O2','-o',str(path/'observer-wram.so'),str(path/'observer-wram.c')],check=True)
    lib=ctypes.CDLL(str(path/'observer-wram.so'))
    lib.access_state.argtypes=[ctypes.c_uint]*5
    lib.check_host.argtypes=[ctypes.c_uint]*3
    count=0
    def reset():
        lib.reset_state()
        return WramState(manifest)
    def access(state,pc,raw,width,value,write):
        global count
        state.data(0,pc,raw,width,value,write)
        lib.access_state(pc,raw,width,value,int(write))
        assert lib.errors_state()==0
        assert lib.active_state()==state.active
        assert bytes(lib.byte_state(i) for i in range(32))==bytes(state.bytes)
        count+=1
    def install(state,view):
        item=state.copies[view]; width=item['copy_width']
        for offset in range(0,item['copy_size'],width):
            pc=item['copy_pcs'][offset//width] if view==5 else item['copy_pcs'][0]
            value=int.from_bytes(item['data'][offset:offset+width],'big')
            access(state,pc,item['source']+offset,width,value,False)
            access(state,pc,0xff0000+offset,width,value,True)
        assert state.active==view
    for view in (5,6,7):
        state=reset(); install(state,view)
        if view in (6,7):
            for raw,width,value in ((0xff0002,4,0x00884cbc),(0xff0003,1,0x89),(0xffff0004,2,0x4262)):
                access(state,0x889000,raw,width,value,True)
            if view==6:
                access(state,0x889000,0xff0008,2,0x54,True)
                access(state,0x889000,0xff0009,1,0x60,True)
        access(state,0x889000,0xff0030,4,0x11223344,True)
        access(state,0x889000,0xff0000,2,0x4e75,True)
        assert state.active==0
        install(state,view)
    state=reset()
    for view in (5,6,7,6): install(state,view)
    failures=0
    for field,bad in ((0,0x880fe0),(1,0xff0002),(2,1),(3,0xdead),(4,False)):
        state=reset(); item=state.copies[6]
        value=int.from_bytes(item['data'][:2],'big')
        access(state,0x880fde,item['source'],2,value,False)
        event=[0x880fde,0xff0000,2,value,True]; event[field]=bad
        try: state.data(0,*event)
        except ImageStateError: pass
        else: raise AssertionError('Python accepted malformed copy')
        lib.access_state(*event)
        assert lib.errors_state()==1 and lib.active_state()==0
        failures+=1
    host_controls=host_mutations=0
    for view in (5,6,7):
        state=reset(); install(state,view); image=state.copies[view]
        lib.sync_host()
        def snapshot():
            return (bytes(lib.host_byte(i) for i in range(64)),
                    bytes(lib.byte_state(i) for i in range(32)),lib.active_state())
        for offset in image['starts']:
            before=snapshot(); error_count=lib.errors_state()
            lib.check_host(0,0xff0000+offset,view)
            assert lib.errors_state()==error_count and snapshot()==before
            host_controls+=1
            for changed in range(image['copy_size']):
                lib.flip_host(changed)
                before=snapshot(); error_count=lib.errors_state()
                lib.check_host(0,0xff0000+offset,view)
                assert lib.errors_state()==error_count+1 and snapshot()==before
                lib.flip_host(changed)
                host_mutations+=1
        # Host bytes outside the installed image are unrelated to this comparison.
        lib.flip_host(image['copy_size'])
        before=snapshot(); error_count=lib.errors_state()
        lib.check_host(0,0xff0000,view)
        assert lib.errors_state()==error_count and snapshot()==before
        host_controls+=1
        # Wrong CPU, absent view and out-of-range PC must not inspect host WRAM.
        lib.flip_host(0)
        for cpu,pc,selected in ((1,0xff0000,view),(0,0xff0000,0),(0,0xff0020,view)):
            before=snapshot(); error_count=lib.errors_state()
            lib.check_host(cpu,pc,selected)
            assert lib.errors_state()==error_count and snapshot()==before
            host_controls+=1
    print(json.dumps({'observer_function_sha256':hashlib.sha256(function.encode()).hexdigest(),
        'host_comparison_block_sha256':hashlib.sha256(host_check.encode()).hexdigest(),
        'observer_file_sha256':hashlib.sha256(observer.encode()).hexdigest(),
        'valid_transitions':count,'rejected_copy_mutations':failures,
        'host_comparison_controls':host_controls,'host_byte_mismatches_rejected':host_mutations,
        'result':'PASS_STANDALONE_NOT_REAL_CORE'},sort_keys=True))
