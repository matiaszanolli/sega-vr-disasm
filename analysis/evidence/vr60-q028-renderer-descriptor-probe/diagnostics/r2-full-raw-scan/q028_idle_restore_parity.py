"""Compile exact pre/post SekFinishIdleDet; standalone callback-order diagnostic."""
import argparse
import ctypes
import hashlib
import json
import subprocess
import sys
import tarfile
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[5]
TOOLS = ROOT / 'tools/libretro-profiling'
sys.path.insert(0, str(TOOLS))
import prepare_q028_picodrive as prepare

parser = argparse.ArgumentParser()
parser.add_argument('--source-root', type=Path, required=True)
args = parser.parse_args()
pack = TOOLS / 'q028_picodrive_source_pack_v9.tar.gz'
assert hashlib.sha256(pack.read_bytes()).hexdigest() == '745cfa19aaca095412fa33e3b402bc471ba70fbe7185328a322325dd06b85c18'
closure = json.loads((TOOLS / 'q028_picodrive_git_closure_v9.json').read_text())
leaf = next(x for x in closure['leaves'] if x['final_relative_path'] == 'pico/sek.c')
with tarfile.open(pack, 'r:gz') as archive:
    original = archive.extractfile('picodrive-source/pico/sek.c').read()
patched = (args.source_root / 'pico/sek.c').read_bytes()
assert hashlib.sha256(original).hexdigest() == leaf['sha256']
assert hashlib.sha256(patched).hexdigest() == prepare.SOURCE_SHA256['pico/sek.c']

def function(data):
    text = data.decode().replace('\r\n', '\n')
    start = text.index('void SekFinishIdleDet(void)')
    end = text.index('{', start)+1
    depth = 1
    while depth:
        depth += (text[end] == '{')-(text[end] == '}')
        end += 1
    return text[start:end]

prefix = '''#include <stdlib.h>
#include <string.h>
#define EMU_F68K 1
#define __LIBRETRO__ 1
#define EL_STATUS 1
#define EL_IDLE 2
#define elprintf(...) (unmatched++)
static unsigned short words[64], initial[64], **idledet_ptrs;
static int idledet_count, removes, unmatched, callbacks, callback_bad;
static unsigned trace[64][3];
static void fm68k_idle_remove(void) { removes++; }
void vrd_q028_idle_restore(unsigned short *p,unsigned old,unsigned replacement) {
  unsigned index=p-words;
  if (*p!=replacement || old!=initial[index]) callback_bad++;
  trace[callbacks][0]=index; trace[callbacks][1]=old; trace[callbacks][2]=replacement;
  callbacks++;
}
'''
suffix = '''
void setup(unsigned short *input,unsigned count) {
  unsigned i; memset(trace,0,sizeof(trace));
  memcpy(words,input,count*2); memcpy(initial,input,count*2);
  idledet_ptrs=malloc(count*sizeof(*idledet_ptrs));
  for(i=0;i<count;i++) idledet_ptrs[i]=&words[i];
  idledet_count=count; removes=unmatched=callbacks=callback_bad=0;
}
unsigned word_at(unsigned i) { return words[i]; }
unsigned trace_at(unsigned i,unsigned field) { return trace[i][field]; }
int metric(unsigned i) {
  switch(i) { case 0:return removes; case 1:return unmatched; case 2:return callbacks;
    case 3:return callback_bad; case 4:return idledet_count; default:return idledet_ptrs==NULL; }
}
'''
real_words = (0x66FA,0x66F8,0x66F6,0x66F2,0x67FA,0x67F8,0x67F6,0x67F2,0x60FE,0x60FC)
pairs = []
for real in real_words:
    branch = 0x400 if real >> 8 == 0x67 else (0xC00 if real >> 8 == 0x60 else 0)
    for handler in (0, 0x200):
        pairs.append(((real & 0xFE) | 0x7100 | branch | handler, real))
input_words = [fake for fake, real in pairs] + [0x4E71, 0x9900]
expected = [real for fake, real in pairs] + input_words[-2:]
array = (ctypes.c_ushort * len(input_words))(*input_words)
functions = [function(original), function(patched)]
with tempfile.TemporaryDirectory(prefix='q028-restore-parity-') as directory:
    directory = Path(directory)
    results = []
    for index, body in enumerate(functions):
        source = directory / f'restore-{index}.c'
        library = directory / f'restore-{index}.so'
        source.write_text(prefix+body+suffix)
        subprocess.run(['cc','-shared','-fPIC','-O2','-o',str(library),str(source)], check=True)
        lib = ctypes.CDLL(str(library))
        lib.setup.argtypes = [ctypes.POINTER(ctypes.c_ushort), ctypes.c_uint]
        lib.setup(array, len(array))
        lib.SekFinishIdleDet()
        assert [lib.word_at(i) for i in range(len(array))] == expected
        assert [lib.metric(i) for i in (0,1,3,4,5)] == [1,2,0,-1,1]
        assert lib.metric(2) == (20 if index else 0)
        if index:
            for ordinal, word_index in enumerate(reversed(range(20))):
                assert [lib.trace_at(ordinal, field) for field in range(3)] == [word_index,input_words[word_index],expected[word_index]]
        before = [lib.metric(i) for i in range(6)]
        lib.SekFinishIdleDet()
        assert [lib.metric(i) for i in range(6)] == before
        results.append([lib.word_at(i) for i in range(len(array))])
    assert results[0] == results[1]
print(json.dumps(dict(status='PASS_STANDALONE_RESTORE_ORDER_ONLY', valid_aliases=20,
                      unmatched_controls=2, repeated_teardown_noop=True,
                      original_source_sha256=leaf['sha256'],
                      patched_source_sha256=hashlib.sha256(patched).hexdigest(),
                      function_sha256=[hashlib.sha256(f.encode()).hexdigest() for f in functions]), sort_keys=True))
