#!/bin/bash
# Glass Dagger M2: Double Pendulum Optimization Runner

set -e

echo "=== Glass Dagger M2: Double Pendulum Optimization ==="
echo ""

# Source environment
if [ -z "$ENZYME_PLUGIN" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    source "$SCRIPT_DIR/toolchain/env.sh"
fi

mkdir -p build
cd build

echo "Step 1: Compiling physics engine..."
"$LLVM_BIN/clang" -c -O2 ../c/double_pendulum.c -o double_pendulum.o

echo "Step 2: Compiling optimization to LLVM IR..."
"$LLVM_BIN/clang" -S -emit-llvm -O2 -fno-vectorize -fno-slp-vectorize -ffast-math \
    ../c/pendulum_opt.c -o pendulum_opt.ll

echo "Step 3: Applying Enzyme AD pass..."
"$LLVM_BIN/opt" pendulum_opt.ll --load-pass-plugin="$ENZYME_PLUGIN" \
    -passes=enzyme -o pendulum_opt_enzyme.ll -S

echo "Step 4: Re-optimizing gradient code..."
"$LLVM_BIN/opt" pendulum_opt_enzyme.ll -O2 -o pendulum_opt_opt.ll -S

echo "Step 5: Compiling to binary..."
"$LLVM_BIN/clang" pendulum_opt_opt.ll double_pendulum.o -O3 -lm -o pendulum_opt

echo "Step 6: Running optimization..."
echo "---"
./pendulum_opt
echo "---"
