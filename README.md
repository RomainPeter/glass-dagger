# 🗡️ Glass Dagger

High-performance automatic differentiation at the LLVM IR level.

Glass Dagger demonstrates compile-time **gradient generation** for C simulations using [Enzyme](https://enzyme.mit.edu/). Unlike runtime autograd frameworks, Enzyme replaces `__enzyme_autodiff` calls with a generated gradient function during the LLVM pass, which is then post-optimized via `opt -O2`.

---

## ⚡ Quickstart

### 1. Try the Benchmark Now (No PyTorch required)
Explore the performance gap between Compiler-AD and Runtime-Autograd on a Windows host:
```bash
python python/bench_demo.py
```

### 2. Full Verification (Requires WSL2/Linux + LLVM 18)
Build the toolchain and run the complete optimization suite:
```bash
make verify  # Runs smoke tests and chaotic double pendulum optimization
```

---

## The Core Concept

Traditional AD frameworks (PyTorch, JAX) build computation graphs at runtime. Glass Dagger leverages **Enzyme** to generate gradients *as machine code* during compilation.

1. **Write C**: Native code. Enzyme replaces `__enzyme_autodiff` calls.
2. **Compile to IR**: `clang -emit-llvm`
3. **Differentiate**: `opt -load-pass-plugin=... -passes=enzyme` generates adjoint IR.
4. **Post-Optimize**: `opt -O2` optimizes the *differentiated* code (LICM, SIMD, etc).
5. **Run**: Machine-code gradients with zero runtime overhead.

---

## Benchmarks: Enzyme vs. PyTorch

Measured on a double pendulum simulation with 1000 RK4 integration steps (200 iters):

| Metric | Glass Dagger (Enzyme/C) | PyTorch (CPU Baseline) |
|--------|--------------------------|-------------------------|
| **Latency** | **6.25ms** / iter | 74.0ms / iter |
| **Throughput** | **11.8x faster** | 1.0x |
| **Footprint** | **~12MB** RAM | ~860MB RAM |

> [!NOTE]
> Measured on WSL2/Ubuntu 22.04 (i9-12900K, 64GB). Both engines use `float64` precision and identical physics. See [**BENCHMARK.md**](BENCHMARK.md) for measured config + reproduction.

---

## Features

- **Chaotic Physics**: [UMD double pendulum equations](https://physics.umd.edu/hep/drew/pendulum2.html).
- **RK4 Integrator**: Fully differentiable 4th-order Runge-Kutta.
- **IR Artifacts**: See the transformation from `loss_original.ll` to `loss_optimized.ll`.
- **Minimalist**: Pure C and Python orchestrators.

## Installation

See [**INSTALL_WSL2.md**](INSTALL_WSL2.md) for step-by-step toolchain setup (LLVM 18 + Enzyme).

## License
MIT

