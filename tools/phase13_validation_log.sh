#!/bin/bash
# Create a reproducible validation log for a ROM run.
# Usage: tools/phase13_validation_log.sh --rom <path> [--duration <seconds>] [--emulator <name>] [--notes <text>]

set -euo pipefail

ROM_PATH=""
DURATION="60"
EMULATOR="PicoDrive (stock)"
NOTES=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --rom)
      ROM_PATH="$2"
      shift 2
      ;;
    --duration)
      DURATION="$2"
      shift 2
      ;;
    --emulator)
      EMULATOR="$2"
      shift 2
      ;;
    --notes)
      NOTES="$2"
      shift 2
      ;;
    -h|--help)
      echo "Usage: $0 --rom <path> [--duration <seconds>] [--emulator <name>] [--notes <text>]"
      exit 0
      ;;
    *)
      echo "Unknown arg: $1" >&2
      exit 1
      ;;
  esac
done

if [[ -z "$ROM_PATH" ]]; then
  echo "Error: --rom is required" >&2
  exit 1
fi

if [[ ! -f "$ROM_PATH" ]]; then
  echo "Error: ROM not found: $ROM_PATH" >&2
  exit 1
fi

TS="$(date +"%Y%m%d_%H%M%S")"
OUT_DIR="test_results/phase13_validation_${TS}"
mkdir -p "$OUT_DIR"

ROM_ABS="$(cd "$(dirname "$ROM_PATH")" && pwd)/$(basename "$ROM_PATH")"
ROM_SIZE="$(stat -c "%s" "$ROM_PATH" 2>/dev/null || stat -f "%z" "$ROM_PATH")"

MD5=""
if command -v md5sum >/dev/null 2>&1; then
  MD5="$(md5sum "$ROM_PATH" | awk '{print $1}')"
elif command -v md5 >/dev/null 2>&1; then
  MD5="$(md5 -q "$ROM_PATH")"
fi

SHA256=""
if command -v sha256sum >/dev/null 2>&1; then
  SHA256="$(sha256sum "$ROM_PATH" | awk '{print $1}')"
elif command -v shasum >/dev/null 2>&1; then
  SHA256="$(shasum -a 256 "$ROM_PATH" | awk '{print $1}')"
fi

GIT_DESC=""
if command -v git >/dev/null 2>&1; then
  if git -C . rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    GIT_DESC="$(git -C . describe --tags --always --dirty 2>/dev/null || true)"
  fi
fi

LOG_FILE="${OUT_DIR}/validation_log.txt"

cat > "$LOG_FILE" <<EOF
PHASE 13 VALIDATION LOG
========================

Timestamp: $(date -u +"%Y-%m-%d %H:%M:%S UTC")
Host: $(uname -a)
Emulator: ${EMULATOR}
ROM Path: ${ROM_ABS}
ROM Size: ${ROM_SIZE} bytes
ROM MD5: ${MD5}
ROM SHA256: ${SHA256}
Git Describe: ${GIT_DESC}
Planned Duration: ${DURATION} seconds
Notes: ${NOTES}

RUN OBSERVATIONS (fill in after run)
------------------------------------
Start Time (UTC):
End Time (UTC):
Run Duration (seconds):
ROM Booted: YES/NO
Graphics OK: YES/NO
Audio OK: YES/NO
Input OK: YES/NO
Crashes/Errors: YES/NO

COMM REGISTERS (optional)
-------------------------
COMM4 Final Value:
COMM6 Final Value:
COMM4 Monotonic: YES/NO/UNKNOWN

COMMENTS
--------

EOF

echo "Validation log created: $LOG_FILE"
echo "Next: run emulator for ~${DURATION}s, then fill in the log."
