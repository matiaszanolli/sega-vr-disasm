# Automation Framework Quick Start

Fast guide to running annotation sessions with the new automation framework.

## Setup (One Time)

```bash
cd /mnt/data/src/32x-playground

# Verify all tools are in place
ls -la tools/enhanced_annotate.py tools/generate_docs.py tools/validate_conversions.py tools/annotate_workflow.py

# Test the framework
python3 tools/annotate_workflow.py --help
```

## Session 1: Phase 3 Batch (5-10 files)

```bash
# Start annotation session for Phase 3 (game logic)
python3 tools/annotate_workflow.py --phase 3 --count 5

# This will:
# 1. Annotate 5 files (convert dc.w to mnemonics)
# 2. Generate documentation headers
# 3. Build ROM and verify PERFECT MATCH
# 4. Commit changes to git
# 5. Print summary statistics
```

**Expected Output:**
```
[2026-01-07 14:30:00] INFO     Starting Phase 3: Game logic and utilities
[2026-01-07 14:30:05] INFO     Annotating code_2000.asm...
[2026-01-07 14:30:08] INFO     ✓ Converted 45/52 dc.w statements
[2026-01-07 14:30:08] INFO     Verifying ROM build...
[2026-01-07 14:30:12] SUCCESS  ✓ PERFECT MATCH verified
...
[2026-01-07 14:31:30] SUCCESS  ✓ Changes committed

WORKFLOW SUMMARY
================================================
Files processed:      5
Functions annotated:  23
Build failures:       0
Conversion failures:  0
================================================
```

## Session 2: Resume/Continue

```bash
# Check current state before continuing
python3 tools/annotate_workflow.py --verify

# Continue Phase 3 with next batch
python3 tools/annotate_workflow.py --phase 3 --count 5

# Or move to a different phase
python3 tools/annotate_workflow.py --phase 2 --count 3
```

## Single File Annotation

```bash
# Annotate specific file
python3 tools/annotate_workflow.py --file disasm/sections/code_1000.asm

# Or use the enhanced tool directly
python3 tools/enhanced_annotate.py disasm/sections/code_1000.asm
```

## Faster Batch (Skip Build Verification)

```bash
# Process 20 files without build check between each (faster)
python3 tools/enhanced_annotate.py --batch 20 --no-verify

# Then verify once at the end
python3 tools/validate_conversions.py
```

## Check Session Logs

```bash
# View annotation log
tail -50 annotation_log.txt

# View full session log
cat annotation_log.txt

# See git commits from this session
git log --oneline -10
```

## Understanding the Process

### What Happens in a Session

1. **Annotation** (2-5 sec per file)
   - Parse dc.w statements
   - Recognize instruction patterns
   - Convert to proper 68K mnemonics
   - Preserve byte-accuracy

2. **Verification** (~3 sec total)
   - Build ROM with `make all`
   - Compare with original: `cmp build/vr_rebuild.32x`
   - Verify PERFECT MATCH

3. **Documentation** (automatic)
   - Generate function headers
   - Add parameter documentation
   - Include hardware/RAM register info

4. **Commit** (automatic)
   - Stage changed files
   - Create commit with statistics
   - Push to git

### Conversion Success Indicators

✓ 90-95% of dc.w statements converted
✓ All converted instructions validated
✓ PERFECT MATCH on original ROM
✓ No syntax errors in vasm build
✓ All functions properly labeled

## Typical Session Timeline

| Phase | Files | Time | Functions |
|-------|-------|------|-----------|
| Single file | 1 | ~5 sec | 3-4 |
| Quick batch | 5 | ~45 sec | 15-25 |
| Standard batch | 10 | ~90 sec | 30-50 |
| Full phase | 20+ | ~5 min | 100+ |

## Common Commands

### Check Status
```bash
# Is build working?
python3 tools/validate_conversions.py --verify

# How many functions left?
grep -c "^TableLookup:" analysis/68K_ANNOTATION_TASKS.md

# View progress
git log --oneline -20
```

### Troubleshoot

```bash
# Build failed? Revert last changes
git status
git diff disasm/sections/ | head -50
git reset --hard HEAD~1

# ROM doesn't match? Check what changed
cmp build/vr_rebuild.32x "Virtua Racing Deluxe (USA).32x" || echo "Mismatch"

# Rebuild from clean
make clean && make all
```

### Process Specific Functions

```bash
# Find file containing function
grep -r "WaitForVBlank:" disasm/sections/

# Annotate just that file
python3 tools/enhanced_annotate.py disasm/sections/code_4000.asm
```

## Efficiency Tips

1. **Batch Larger Groups** - Process 10+ files per session for better efficiency
2. **Skip Verify Until End** - Use `--no-verify` for first pass, validate once
3. **Schedule Overnight** - Run large batches (50+ files) in background:
   ```bash
   nohup python3 tools/annotate_workflow.py --phase 3 --count 50 > session.log 2>&1 &
   ```
4. **Monitor Progress** - Check logs in another terminal:
   ```bash
   watch -n 2 'tail -5 annotation_log.txt'
   ```

## What Gets Automated

### Fully Automated ✓
- Pattern recognition (90-95% coverage)
- Instruction conversion
- Documentation header generation
- ROM building and verification
- Git commits with statistics
- Session logging

### Semi-Automated ⚠️
- Complex instruction handling (few edge cases need manual review)
- Call graph analysis (can be reviewed post-session)
- Function categorization (database-driven, extensible)

### Manual Still Needed
- Adding custom documentation beyond template
- Fixing rare conversion edge cases
- Creating new function database entries

## Progress Tracking

```bash
# Track overall progress
git log --oneline | grep "feat: Phase" | wc -l

# See what's been completed
git log --grep="Phase" --oneline

# Check commits per session
git log --oneline --since="1 week ago" | head -20
```

## Success Metrics

After a successful session:
- ✓ All files committed
- ✓ PERFECT MATCH verified
- ✓ Build completes in <5 seconds
- ✓ Conversion rate 90%+
- ✓ Zero syntax errors

## Next Steps

1. **Try a small batch** (5 files) to validate setup
2. **Monitor first session** for any issues
3. **Scale up** to 10-20 files per session
4. **Run overnight** batches for large groups
5. **Track progress** with git log and analysis files

## Questions?

- Framework docs: `ANNOTATION_FRAMEWORK.md`
- Manual workflow: `DISASSEMBLY_ANNOTATION_GUIDE.md`
- Function inventory: `analysis/68K_ANNOTATION_TASKS.md`
- Hardware reference: `docs/32x-hardware-manual.md`

---

**Current Status**: 17 of 769 functions annotated (2.2%)
**Remaining**: 752 functions to annotate
**Rate with automation**: ~30-50 functions per session
**Estimated time**: 15-25 sessions at current pace

Ready to get started? Run:
```bash
python3 tools/annotate_workflow.py --phase 3 --count 5
```
