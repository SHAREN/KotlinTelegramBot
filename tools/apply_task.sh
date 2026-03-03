#!/usr/bin/env bash
set -euo pipefail

SPEC_FILE=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --spec) SPEC_FILE="$2"; shift 2 ;;
    *) echo "Unknown arg: $1"; exit 2 ;;
  esac
done

if [[ -z "${SPEC_FILE}" ]]; then
  echo "Usage: $0 --spec <spec-file>" >&2
  exit 2
fi

if [[ ! -f "$SPEC_FILE" ]]; then
  echo "Spec file not found: $SPEC_FILE" >&2
  exit 1
fi

echo "[apply_task] spec: $SPEC_FILE"

# Minimal deterministic executor for KTB-26 bootstrap:
# 1) keep canonical task copy (idempotent)
if [[ "$SPEC_FILE" != "KTB-26-LOBSTER-TASK.md" ]]; then
  cp "$SPEC_FILE" KTB-26-LOBSTER-TASK.md
fi

# 2) create implementation checklist (idempotent)
cat > KTB-26-IMPLEMENTATION-CHECKLIST.md <<'EOF'
# KTB-26 Implementation Checklist

- [ ] Make Message.text nullable
- [ ] Add Document model + Message.document
- [ ] Add getFile(fileId)
- [ ] Add GetFileResponse + TelegramFile models
- [ ] Add downloadFile(filePath, fileName)
- [ ] Handle document in update flow
- [ ] Import dictionary from downloaded file
- [ ] Add/adjust tests and make `./gradlew test` green
EOF

# 3) emit fast scan hints for operator/next step
{
  echo "[apply_task] Kotlin entry points:";
  grep -R "data class Message\|class TelegramBotService\|fun getUpdates\|handleUpdate\|callback_query" -n src/main/kotlin || true;
} > KTB-26-SCAN.txt

echo "[apply_task] prepared artifacts:"
echo "- KTB-26-LOBSTER-TASK.md"
echo "- KTB-26-IMPLEMENTATION-CHECKLIST.md"
echo "- KTB-26-SCAN.txt"
