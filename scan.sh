#!/bin/bash
# Supply Chain Risk Filter
# J3sh | 24BCE5540

# check directory?
if [ -z "$1" ] || [ ! -d "$1" ]; then
  echo "ERR: Missing or invalid target dir." >&2
  echo "Usage: $0 /path/to/project/root" >&2
  exit 1
fi

TARGET=$1
echo "--- SCA Scan  ---"
echo "Target: $TARGET"
echo "Filter: HIGH/CRIT severity only."
echo "------------------------------"

# run grype on the input dir, catch the OP
RAW_OUTPUT=$(grype dir:$TARGET)

# filter high/crit RISKS, ignore grep exit code if none found.
ALERT_OUTPUT=$(echo "$RAW_OUTPUT" | grep -E '(\s(High|Critical))' || true)

if [ -n "$ALERT_OUTPUT" ]; then
  echo ""
  echo "[ URGENT ] High-RISK Dependencies Found!!!"
  echo "------------------------------------------"
  
  # testing header
  echo "NAME        INSTALLED  FIXED IN   VULNERABILITY      SEVERITY"
  echo "----------- -------- ---------- ----------------- ------------"
  echo "$ALERT_OUTPUT"

  echo ""
  echo "[ ACTION ] Address these risks ASAP."
  
else
  echo ""
  echo "[ SCAN OK ] No HIGH or CRITICAL risks identified."
fi

echo "------------------------------"

