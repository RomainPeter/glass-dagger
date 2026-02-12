#!/bin/bash
# Glass Dagger: Enzyme Smoke Test Build Script
# This script validates the entire Enzyme toolchain by compiling a simple test

set -e  # Exit on any error

echo "=== Glass Dagger Enzyme Smoke Test ==="
echo ""

# Source environment if not already set
if [ -z "$ENZYME_PLUGIN" ] || [ -z "$LLVM_BIN" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "⚠️  Environment not configured, sourcing env.sh..."
    source "$SCRIPT_DIR/toolchain/env.sh"
    if [ $? -ne 0 ]; then
        echo "❌ ERROR: Failed to source environment"
        echo "Please build LLVM and Enzyme first:"
        echo "  bash scripts/toolchain/build_llvm.sh"
        echo "  bash scripts/toolchain/build_enzyme.sh"
        exit 1
    fi
fi

# Verify Enzyme plugin exists
if [ ! -f "$ENZYME_PLUGIN" ]; then
    echo "❌ ERROR: Enzyme plugin not found at: $ENZYME_PLUGIN"
    echo "Please build Enzyme: bash scripts/toolchain/build_enzyme.sh"
    exit 1
fi

# Verify LLVM binaries exist
if [ ! -x "$LLVM_BIN/clang" ]; then
    echo "❌ ERROR: clang not found at $LLVM_BIN/clang"
    echo "LLVM may not be built correctly"
    exit 1
fi

if [ ! -x "$LLVM_BIN/opt" ]; then
    echo "❌ ERROR: opt not found at $LLVM_BIN/opt"
    echo "LLVM may not be built correctly"
    exit 1
fi

echo "✅ Enzyme plugin found: $ENZYME_PLUGIN"
echo "✅ Using LLVM from: $LLVM_BIN"
echo ""

# Print versions for debugging (critical for GitHub issues)
echo "Toolchain versions:"
"$LLVM_BIN/clang" --version | head -n 1
"$LLVM_BIN/opt" --version | head -n 1
echo ""

# Create build directory
mkdir -p build
cd build

echo "Step 1/5: Compiling C to LLVM IR..."
"$LLVM_BIN/clang" -S -emit-llvm -O2 -fno-vectorize -fno-slp-vectorize -ffast-math \
      ../c/smoke_test.c -o smoke.ll

echo "✅ Generated smoke.ll"
echo ""

echo "Step 2/5: Applying Enzyme AD pass..."
"$LLVM_BIN/opt" smoke.ll --load-pass-plugin="$ENZYME_PLUGIN" \
    -passes=enzyme -o smoke_enzyme.ll -S

echo "✅ Enzyme pass complete (smoke_enzyme.ll)"
echo ""

echo "Step 3/5: Re-optimizing gradient code..."
"$LLVM_BIN/opt" smoke_enzyme.ll -O2 -o smoke_opt.ll -S

echo "✅ Post-optimization complete (smoke_opt.ll)"
echo ""

echo "Step 4/5: Compiling to binary..."
"$LLVM_BIN/clang" smoke_opt.ll -O3 -lm -o smoke_test

echo "✅ Binary created (smoke_test)"
echo ""

echo "Step 5/5: Running smoke test..."
echo "---"
./smoke_test
TEST_RESULT=$?
echo "---"
echo ""

if [ $TEST_RESULT -eq 0 ]; then
    echo "🎉 SUCCESS: Enzyme toolchain is fully operational!"
    echo ""
    echo "You can inspect the generated LLVM IR:"
    echo "  - Original:        build/smoke.ll"
    echo "  - After Enzyme:    build/smoke_enzyme.ll"
    echo "  - After O2:        build/smoke_opt.ll"
    exit 0
else
    echo "❌ FAILURE: Smoke test failed with exit code $TEST_RESULT"
    echo "Check the gradients or Enzyme configuration"
    exit 1
fi
