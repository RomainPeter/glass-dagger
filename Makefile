CC = clang
CLANG = clang
OPT = opt

# Enzyme Plugin Detection
ENZYME_PLUGIN = /home/romain/glass-dagger/toolchain/enzyme/LLVMEnzyme-18.so

# Flags
OPT_FLAGS = -load-pass-plugin=$(ENZYME_PLUGIN)

all: smoke

# Create artifacts directory
artifacts-dir:
	@mkdir -p artifacts

smoke: artifacts-dir
	@echo "Running Smoke Test..."
	@bash scripts/smoke.sh

m1: artifacts-dir
	@echo "Running M1: Loss and Optimization..."
	@bash scripts/m1_loss.sh

m2: artifacts-dir
	@echo "Running M2: Double Pendulum Optimization..."
	@bash scripts/m2_pendulum.sh

# M3 Benchmark Targets
bench: bench-demo

bench-demo: pendulum_bench
	@echo "Running M3 Benchmark Demo..."
	@python3 python/bench_demo.py --strict

bench-full: pendulum_bench
	@echo "Running M3 Full Benchmark (PyTorch)..."
	@python3 python/simple_bench.py

pendulum_bench: artifacts-dir
	@mkdir -p build
	@echo "Step 1: Compiling physics engine..."
	@$(CLANG) -O3 -Ic -c c/double_pendulum.c -o build/double_pendulum.o
	@echo "Step 2: Compiling benchmark to LLVM IR..."
	@$(CLANG) -I. -Ic -S -emit-llvm -O2 c/pendulum_bench.c -o build/pendulum_bench_raw.ll
	@echo "Step 3: Applying Enzyme AD pass..."
	@$(OPT) -load-pass-plugin=$(ENZYME_PLUGIN) -passes=enzyme build/pendulum_bench_raw.ll -S -o build/pendulum_bench_enzyme.ll
	@echo "Step 4: Final optimization..."
	@$(OPT) -O3 build/pendulum_bench_enzyme.ll -S -o build/pendulum_bench_opt.ll
	@echo "Step 5: Generating machine code..."
	@$(CLANG) build/pendulum_bench_opt.ll build/double_pendulum.o -lm -o build/pendulum_bench
	@echo "✅ Build complete: ./build/pendulum_bench"

verify: artifacts-dir
	@bash scripts/verify.sh

ir: artifacts-dir
	@bash scripts/capture_ir.sh

clean:
	@rm -rf build artifacts/*.json artifacts/ir/*.ll

