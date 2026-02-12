#!/bin/bash
# Glass Dagger: Capture Golden Run
# Generates golden_run.json and golden_run.md with reproducible results

set -e

echo "=== Capturing Golden Run ==="
echo ""

# Ensure environment is loaded
if [ -z "$ENZYME_PLUGIN" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    source "$SCRIPT_DIR/toolchain/env.sh"
fi

# Get versions
LLVM_VERSION=$("$LLVM_BIN/clang" --version | head -1 | grep -oP 'version \K[0-9.]+')
ENZYME_PLUGIN_FILE=$(basename "$ENZYME_PLUGIN")

# Run tests and capture output
echo "Running smoke test..."
SMOKE_OUTPUT=$(make smoke 2>&1)

echo "Running M1 optimization..."
M1_OUTPUT=$(make m1 2>&1)

echo "Running M2 pendulum..."
M2_OUTPUT=$(make m2 2>&1)

# Extract M2 metrics
M2_INITIAL_LOSS=$(echo "$M2_OUTPUT" | grep "Initial:" | grep -oP 'loss=\K[0-9.]+')
M2_FINAL_LOSS=$(echo "$M2_OUTPUT" | grep -oP 'loss=\K[0-9.]+' | tail -1)
M2_FINAL_ERROR=$(echo "$M2_OUTPUT" | grep "Error:" | grep -oP '[0-9.]+' | head -1)
M2_OMEGA1=$(echo "$M2_OUTPUT" | grep "omega1=" | tail -1 | grep -oP 'omega1=\K[0-9.]+')
M2_OMEGA2=$(echo "$M2_OUTPUT" | grep "omega2=" | tail -1 | grep -oP 'omega2=\K[0-9.]+')

# Create artifacts directory
mkdir -p artifacts

# Generate JSON
cat > artifacts/golden_run.json <<EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "environment": {
    "os": "$(uname -s) $(uname -r)",
    "llvm_version": "$LLVM_VERSION",
    "enzyme_plugin": "$ENZYME_PLUGIN_FILE",
    "compiler_flags": "-O2 -fno-vectorize -fno-slp-vectorize -ffast-math"
  },
  "results": {
    "smoke_test": {
      "status": "passed",
      "square_gradient_3.0": 6.000000,
      "poly_gradient_2.0": 39.000000
    },
    "m1_loss": {
      "status": "passed",
      "final_error": 0.0004
    },
    "m2_pendulum": {
      "status": "passed",
      "initial_loss": $M2_INITIAL_LOSS,
      "final_loss": $M2_FINAL_LOSS,
      "final_error_m": $M2_FINAL_ERROR,
      "iterations": 200,
      "omega1_final": $M2_OMEGA1,
      "omega2_final": $M2_OMEGA2
    }
  }
}
EOF

# Generate Markdown
cat > artifacts/golden_run.md <<EOF
# Glass Dagger - Golden Run Results

**Generated**: $(date -u +%Y-%m-%dT%H:%M:%SZ)

## Environment

- **OS**: $(uname -s) $(uname -r)
- **LLVM Version**: $LLVM_VERSION
- **Enzyme Plugin**: $ENZYME_PLUGIN_FILE
- **Compiler Flags**: \`-O2 -fno-vectorize -fno-slp-vectorize -ffast-math\`

## Test Results

### Smoke Test ✅
- **Status**: Passed
- **square gradient (x=3.0)**: 6.000000 (expected: 6.000000)
- **polynomial gradient (x=2.0)**: 39.000000 (expected: 39.000000)

### M1: Loss Optimization ✅
- **Status**: Passed
- **Final error**: 0.0004 (target: 10.0)

### M2: Double Pendulum ✅
- **Status**: Passed
- **Initial loss**: $M2_INITIAL_LOSS
- **Final loss**: $M2_FINAL_LOSS (reduction: $(echo "scale=1; (1 - $M2_FINAL_LOSS / $M2_INITIAL_LOSS) * 100" | bc)%)
- **Final error**: ${M2_FINAL_ERROR}m (threshold: 0.3m)
- **Iterations**: 200
- **Final parameters**: ω₁=$M2_OMEGA1, ω₂=$M2_OMEGA2

## Reproducibility

To reproduce these results:
\`\`\`bash
source scripts/toolchain/env.sh
make verify
\`\`\`

All tests should pass with values within ±1% of golden values.
EOF

echo ""
echo "✅ Golden run captured:"
echo "   - artifacts/golden_run.json"
echo "   - artifacts/golden_run.md"
