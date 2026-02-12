#!/bin/bash
# Glass Dagger: M1 Loss Test Runner

set -e

echo "=== Glass Dagger M1: Loss Function & Optimization ==="
echo ""

# Source environment
if [ -z "$ENZYME_PLUGIN" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    source "$SCRIPT_DIR/toolchain/env.sh"
fi

mkdir -p build
cd build

echo "Step 1: Compiling M1 to LLVM IR..."
"$LLVM_BIN/clang" -S -emit-llvm -O2 -fno-vectorize -fno-slp-vectorize -ffast-math \
    ../c/loss_test.c -o loss_test.ll

echo "Step 2: Applying Enzyme AD pass..."
"$LLVM_BIN/opt" loss_test.ll --load-pass-plugin="$ENZYME_PLUGIN" \
    -passes=enzyme -o loss_test_enzyme.ll -S

echo "Step 3: Re-optimizing gradient code..."
"$LLVM_BIN/opt" loss_test_enzyme.ll -O2 -o loss_test_opt.ll -S

echo "Step 4: Compiling to binary..."
"$LLVM_BIN/clang" loss_test_opt.ll -O3 -lm -o loss_test

echo "Step 5: Running optimization test..."
echo "---"
./loss_test
echo "---"

