#!/bin/bash
# Glass Dagger: Verification Suite
# Runs all tests and validates against expected thresholds

set -e

echo "=== Glass Dagger Verification Suite ==="
echo ""

# Ensure environment is loaded
if [ -z "$ENZYME_PLUGIN" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    source "$SCRIPT_DIR/toolchain/env.sh"
fi

FAILED=0

# Test 1: Smoke test (scalar gradients)
echo "[1/3] Running smoke test..."
SMOKE_OUTPUT=$(make smoke 2>&1)

if echo "$SMOKE_OUTPUT" | grep -q "✅ All tests passed"; then
    echo "✅ Smoke test passed"
else
    echo "❌ Smoke test failed"
    FAILED=1
fi

# Test 2: M1 loss optimization
echo "[2/3] Running M1 loss optimization..."
M1_OUTPUT=$(make m1 2>&1)

if echo "$M1_OUTPUT" | grep -q "✅ M1 SUCCESS"; then
    echo "✅ M1 optimization passed"
else
    echo "❌ M1 optimization failed"
    FAILED=1
fi

# Test 3: M2 pendulum optimization
echo "[3/3] Running M2 pendulum optimization..."
M2_OUTPUT=$(make m2 2>&1)

# Extract final loss and error
FINAL_LOSS=$(echo "$M2_OUTPUT" | grep -oP 'loss=\K[0-9.]+' | tail -1)
FINAL_ERROR=$(echo "$M2_OUTPUT" | grep "Error:" | grep -oP '[0-9.]+' | head -1)

# Validate thresholds
LOSS_OK=0
ERROR_OK=0

if [ ! -z "$FINAL_LOSS" ]; then
    if (( $(echo "$FINAL_LOSS < 0.06" | bc -l) )); then
        LOSS_OK=1
    fi
fi

if [ ! -z "$FINAL_ERROR" ]; then
    if (( $(echo "$FINAL_ERROR < 0.3" | bc -l) )); then
        ERROR_OK=1
    fi
fi

if [ $LOSS_OK -eq 1 ] && [ $ERROR_OK -eq 1 ]; then
    echo "✅ M2 pendulum passed (loss=$FINAL_LOSS, error=${FINAL_ERROR}m)"
else
    echo "❌ M2 pendulum failed (loss=$FINAL_LOSS, error=${FINAL_ERROR}m)"
    FAILED=1
fi

echo ""
if [ $FAILED -eq 0 ]; then
    echo "=== ✅ All Verifications Passed ==="
    exit 0
else
    echo "=== ❌ Some Verifications Failed ==="
    exit 1
fi
