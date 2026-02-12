# 🗡️ Glass Dagger

**High-performance Automatic Differentiation at the LLVM level.**

Glass Dagger demonstrates how to achieve **compile-time AD** for complex C simulations using [Enzyme](https://enzyme.mit.edu/). By differentiating the LLVM Intermediate Representation (IR), we generate gradients that are as fast as the forward pass, outperforming runtime autograd frameworks like PyTorch for simulation-heavy workloads.

---

## ⚡ Quickstart

### 1. Build and Verify (Requires WSL2/Linux + LLVM 18)
```bash
make verify  # Runs smoke tests and M2 chaotic optimization
```

### 2. Try the Benchmark
Explore the speed gap between Compiler-AD and Runtime-Autograd:
```bash
python python/bench_demo.py
```

---

## The Core Concept

Traditional AD frameworks (PyTorch, JAX) build computation graphs at runtime. Glass Dagger leverages **Enzyme** to perform AD during compilation.

1. **Write C**: Native code, no special macros.
2. **Compile to IR**: `clang -emit-llvm`
3. **Differentiate**: Enzyme LLVM pass transforms your logic into a gradient function.
4. **Optimize**: `opt -O3` optimizes the *differentiated* code.
5. **Run**: Pure machine code performance.

---

## Benchmarks: Enzyme vs. PyTorch

For a double pendulum simulation with 1000 RK4 integration steps:

| Metric | Glass Dagger (Enzyme/C) | PyTorch (CPU Baseline) |
|--------|--------------------------|-------------------------|
| **Latency** | **~6ms** / iter | ~74ms / iter |
| **Throughput** | **11x faster** | 1.0x |
| **Footprint** | **~12MB** RAM | ~850MB RAM |

Detailed methodology and reproduction steps in [**BENCHMARK.md**](BENCHMARK.md).

---

## Features

- **Chaotic Physics**: Double Pendulum simulation using UMD equations.
- **RK4 Integrator**: Fully differentiable 4th-order Runge-Kutta.
- **IR Artifacts**: See exactly how your code changes from `loss_original.ll` to `loss_optimized.ll`.
- **Minimalist**: Pure C and Python orchestrators.

## Installation

See [**INSTALL_WSL2.md**](INSTALL_WSL2.md) for a step-by-step toolchain setup (LLVM 18 + Enzyme).

## License
MIT

