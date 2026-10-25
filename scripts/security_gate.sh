#!/usr/bin/env bash
set -euo pipefail

echo "=========================================================="
echo "🛡️  Enterprise DevSecOps Shift-Left Security Gate Validator"
echo "=========================================================="

SCAN_DIR="${1:-sample-workload}"
FAILED=0

echo "[*] Step 1: Validating Terraform syntax in $SCAN_DIR..."
if ! terraform -chdir="$SCAN_DIR" fmt -check; then
  echo "[-] FAILED: Code is not properly formatted. Run 'terraform fmt'."
  FAILED=1
else
  echo "[+] Terraform format passed."
fi

echo "[*] Step 2: Checking for unencrypted secrets and tokens..."
if grep -rnEi "(password|secret|access_key).*=.*\"[A-Za-z0-9+/=]{16,}\"" "$SCAN_DIR"; then
  echo "[-] FAILED: Hardcoded credentials detected!"
  FAILED=1
else
  echo "[+] No hardcoded credentials detected."
fi

if [ $FAILED -ne 0 ]; then
  echo "=========================================================="
  echo "❌ Security Gate Check FAILED. Deployment blocked."
  echo "=========================================================="
  exit 1
fi

echo "=========================================================="
echo "✅ Security Gate PASSED. All baseline compliance met."
echo "=========================================================="
exit 0
