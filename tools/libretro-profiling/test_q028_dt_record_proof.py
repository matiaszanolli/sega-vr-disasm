"""Small synthetic tests of the mutation proof, not actual-stream acceptance."""
from pathlib import Path
import json
import tempfile
import unittest

import q028_access_v8 as access
from test_q028_actual_dt import metadata_fields, verify_tail


class RecordProofTests(unittest.TestCase):
    def test_replacement_metadata_canonical_roundtrip(self):
        fields={3:0xC0000000,4:2,5:0xC0000000,6:0xC0000000,7:0x4F22,8:2,9:0xFFFF,12:25,13:2}
        value={"explicit_replacement_fields":metadata_fields(fields)}
        raw=access.canonical(value)
        self.assertEqual(access.canonical(json.loads(raw)),raw)
        self.assertTrue(all(isinstance(key,str) for key in value["explicit_replacement_fields"]))
        self.assertTrue(all(isinstance(key,int) for key in fields))
        self.assertIsNone(metadata_fields(None))

    def test_inverse_mapping_and_undeclared_field_rejection(self):
        rows=[(i,0,i,0x6002536,1,0x6002536,0x6002536,0x4710,1,0,1,0,26,2,0,0)
              for i in range(6)]
        original=b"".join(access.RECORD.pack(*row) for row in rows)
        header=(access.MAGIC,8,48,1,6,0,b"r"*8,b"t"*8,b"s"*8,b"\0"*8)
        tests=(
            ("wrong-value",[0,1,2,3,4,5],None,None,None,{3:{7:0x4711}}),
            ("wrong-address",[0,1,2,3,4,5],None,None,None,{3:{5:0x6002538,6:0x6002538}}),
            ("duplicate",[0,1,2,3,3,4,5],4,None,None,{4:{9:1}}),
            ("missing",[0,1,2,4,5],None,3,None,{}),
            ("reordered",[0,3,1,2,4,5],1,3,None,{}),
            ("premature-fetch",[0,1,2,3,4,5],None,None,None,
             {3:{3:0xC0000000,4:2,5:0xC0000000,6:0xC0000000,7:0x4F22,8:2,9:0xFFFF,12:25,13:2}}),
            ("eof-before-final-dt",[0,1,2],None,None,3,{}))
        for operation,mapping,insert,remove,stop,patches in tests:
            with self.subTest(operation=operation), tempfile.TemporaryDirectory(prefix="q028-dt-proof-") as temp:
                root=Path(temp); changed=[]
                for i,index in enumerate(mapping):
                    row=list(rows[index]); row[0]=row[2]=i
                    for field,value in patches.get(i,{}).items(): row[field]=value
                    changed.append(row)
                target_header=list(header); target_header[4]=len(changed)
                path=root/"access-events-v8-0001.bin"
                path.write_bytes(access.HEADER.pack(*target_header)+b"".join(access.RECORD.pack(*row) for row in changed))
                replacement=patches[3] if operation=="premature-fetch" else None
                result=verify_tail(root,original,header,None,operation,3,insert,remove,stop,replacement)
                self.assertTrue(result["verified"])
                self.assertEqual(result["target_tail_records"],len(mapping))
                # These are proof-corruption controls, not real-stream mutations.
                for corruption in ("pc","sequence","order","multiplicity"):
                    with self.subTest(corruption=corruption):
                        bad=[list(row) for row in changed]
                        if corruption=="multiplicity": bad.pop()
                        else: bad[0][{"pc":3,"sequence":0,"order":2}[corruption]]^=1
                        bad_header=list(target_header); bad_header[4]=len(bad)
                        path.write_bytes(access.HEADER.pack(*bad_header)+b"".join(access.RECORD.pack(*row) for row in bad))
                        with self.assertRaises(AssertionError):
                            verify_tail(root,original,header,None,operation,3,insert,remove,stop,replacement)


if __name__=="__main__": unittest.main()
