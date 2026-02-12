# Glass Dagger 🗡️

**Compiler-level automatic differentiation through RK4 on a chaotic system, in pure C.**

Gradients generated at LLVM IR level via [Enzyme](https://github.com/EnzymeAD/Enzyme), then re-optimized with LLVM's `-O2` pass.

## Why This Matters

Most AD frameworks (PyTorch, JAX) generate gradients at runtime or via Python tracing. **Enzyme operates at the LLVM level:**

1. You write C code with `__enzyme_autodiff` placeholders
2. Enzyme's LLVM pass generates adjoint code (reverse-mode AD) as LLVM IR
3. LLVM's optimizer (`opt -O2`) optimizes the gradient code
4. Result: **native machine code with zero runtime overhead**

This demo proves Enzyme can differentiate through:
- **1000 iterations** of 4th-order Runge-Kutta integration
- **Chaotic double pendulum** dynamics (coupled Lagrangian equations)
- Trigonometric functions, divisions, and numerical instabilities

## Quick Start

```bash
# 1. Build toolchain (LLVM 18 + Enzyme) - one-time setup
bash scripts/toolchain/build_llvm.sh    # ~30 min
bash scripts/toolchain/build_enzyme.sh  # ~5 min

# 2. Run verification suite
source scripts/toolchain/env.sh
make verify

# 3. Run double pendulum demo
make m2
```

## Results

| Test | Metric | Value |
|------|--------|-------|
| Smoke (x²) | Gradient error | 0.00e+00 |
| Smoke (poly) | Gradient error | 0.00e+00 |
| M1 Loss | Final error | 0.0004 |
| **M2 Pendulum** | **Loss reduction** | **0.98 → 0.053 (95%)** |
| **M2 Pendulum** | **Final error** | **22.4 cm** |
| **M2 Pendulum** | **Iterations** | **200** |

## How It Works

### Pipeline
```
C source → clang -emit-llvm → LLVM IR
         ↓
    opt -passes=enzyme → LLVM IR (with gradients)
         ↓
    opt -O2 → Optimized gradient IR
         ↓
    clang → Native binary
```

### Key Files
- [`c/pendulum_opt.c`](c/pendulum_opt.c): Loss function with inlined RK4 (1000 steps)
- `build/pendulum_opt_enzyme.ll`: Generated gradient code (view with `-S`)
- `build/pendulum_opt_opt.ll`: Optimized gradient code

### Why Inline Everything?
Enzyme requires scalar operations to trace through. Struct returns and pointer outputs break the AD chain, so we inline the entire RK4 loop into the loss function.

## Project Structure

```
glass-dagger/
├── c/                      # C source files
│   ├── smoke_test.c       # Scalar gradient validation
│   ├── loss_test.c        # M1: Multi-parameter loss
│   ├── double_pendulum.c  # Physics engine (UMD equations)
│   └── pendulum_opt.c     # M2: Chaotic optimization
├── scripts/
│   ├── toolchain/         # LLVM + Enzyme build scripts
│   ├── smoke.sh           # Smoke test runner
│   ├── m1_loss.sh         # M1 runner
│   ├── m2_pendulum.sh     # M2 runner
│   ├── verify.sh          # Verification suite
│   └── capture_golden.sh  # Golden run capture
├── artifacts/             # Golden runs and benchmarks
└── Makefile              # Build targets
```

## Technical Details

- **LLVM**: 18.1.8
- **Enzyme**: Built from source (plugin: `LLVMEnzyme-18.so`)
- **Physics**: [UMD double pendulum equations](https://physics.umd.edu/hep/drew/pendulum2.html)
- **Integration**: Fixed-step RK4 (dt=1ms, T=1s)
- **Optimization**: Gradient descent (lr=0.02, 200 iterations)

## Verification

```bash
make verify  # Runs smoke + M1 + M2 with threshold checks
make golden  # Captures reproducible golden run
```

See [`artifacts/golden_run.md`](artifacts/golden_run.md) for latest verified results.

## References

- [Enzyme GitHub](https://github.com/EnzymeAD/Enzyme) - LLVM plugin for automatic differentiation
- [Enzyme Documentation](https://enzyme.mit.edu/) - Getting started guide
- [UMD Double Pendulum](https://physics.umd.edu/hep/drew/pendulum2.html) - Physics equations
- [LLVM Optimization Passes](https://llvm.org/docs/Passes.html) - Understanding `-O2`

## License

MIT
