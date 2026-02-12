# Glass Dagger - Makefile with Toolchain Target
# Single entry point for all build and test operations

.PHONY: all toolchain demo smoke clean help

# Default target
all: demo

# Build complete toolchain (LLVM + Enzyme)
toolchain:
	@echo "=== Building Glass Dagger Toolchain ==="
	@echo "This will take 1-3 hours. Get some coffee ☕"
	@echo ""
	@bash scripts/toolchain/build_llvm.sh
	@bash scripts/toolchain/build_enzyme.sh
	@echo ""
	@echo "🎉 Toolchain build complete!"
	@echo ""
	@echo "Next step: Run the smoke test to validate everything works:"
	@echo "  source scripts/toolchain/env.sh"
	@echo "  make smoke"

# Run full demonstration (smoke test + benchmark)
demo: smoke
	@echo ""
	@echo "✅ Demo complete!"
	@echo ""
	@echo "Next steps:"
	@echo "  - Implement double pendulum simulation (c/double_pendulum.c)"
	@echo "  - Add PyTorch baseline (python/baseline_pytorch.py)"
	@echo "  - Run full benchmark (make benchmark)"

# Run smoke test to validate Enzyme toolchain
smoke:
	@echo "Running Enzyme smoke test..."
	@bash scripts/smoke.sh

# Run M1: Simple loss function and optimization
m1:
	@echo "Running M1: Loss and Optimization..."
	@bash scripts/m1_loss.sh

# Run M2: Double pendulum optimization
m2:
	@echo "Running M2: Double Pendulum Optimization..."
	@bash scripts/m2_pendulum.sh

# Run verification suite (all tests with threshold checks)
verify:
	@bash scripts/verify.sh

# Capture golden run (versions + results)
golden:
	@bash scripts/capture_golden.sh

# Capture IR artifacts (LLVM pipeline stages)
ir:
	@bash scripts/capture_ir.sh

# Run full benchmark suite (not yet implemented)
benchmark:
	@echo "❌ Benchmark not yet implemented"
	@echo "TODO: Implement M2-M4 (double pendulum + PyTorch baseline)"
	@exit 1

# Clean all build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf build/
	@rm -rf artifacts/*.json artifacts/*.md
	@rm -rf c/*.o c/*.ll
	@echo "✅ Clean complete"

# Show help
help:
	@echo "Glass Dagger Enzyme - Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make toolchain  - Build LLVM 18 + Enzyme from source (1-3 hours)"
	@echo "  make demo       - Run smoke test (validates Enzyme toolchain)"
	@echo "  make smoke      - Run smoke test only"
	@echo "  make benchmark  - Run full benchmark suite (TODO)"
	@echo "  make clean      - Remove all build artifacts"
	@echo "  make help       - Show this help message"
	@echo ""
	@echo "Requirements:"
	@echo "  - WSL2 with Ubuntu 22.04"
	@echo "  - 20GB+ free disk space"
	@echo "  - 8GB+ RAM"
	@echo ""
	@echo "First time setup:"
	@echo "  1. make toolchain     # Build LLVM + Enzyme"
	@echo "  2. source scripts/toolchain/env.sh"
	@echo "  3. make smoke         # Validate"
