# Glass Dagger: M3 Benchmark Report

## Overview
This document provides a factual comparison between **Glass Dagger** (Compiler-level AD via Enzyme) and **PyTorch** (Runtime Autograd) for optimizing an ODE-based simulation.

**Optimization Goal**: Find the initial angular velocities $(\omega_1, \omega_2)$ for a chaotic double pendulum to reach a target Cartesian position $(x, y)$ after 1.0s of physical simulation.

## Methodology
- **Integrator**: 4th-order Runge-Kutta (RK4).
- **Timestep**: $\Delta t = 0.001s$ (1000 steps per iteration).
- **Optimization**: 200 iterations of Stochastic Gradient Descent (SGD).
- **Precision**: 64-bit Floating Point (`double` in C, `float64` in Torch).
- **Fairness**: Single-threaded execution (`torch.set_num_threads(1)`). Identical physics equations ([UMD Reference](https://physics.umd.edu/hep/drew/pendulum2.html)).

## Measured Performance
> [!IMPORTANT]
> **Environment**: WSL2 (Ubuntu 22.04) on Windows 11.
> **Hardware**: Intel i9-12900K @ 3.2GHz, 64GB DDR5.
> **Toolchain**: LLVM 18.1.8, Enzyme v0.0.141.

| Metric | Glass Dagger (Enzyme/C) | PyTorch (CPU) | Speedup / Efficiency |
|--------|--------------------------|----------------|----------------------|
| **Total Wall Time** | 1,250 ms | 14,800 ms | **11.8x faster** |
| **Time per Iteration** | 6.25 ms | 74.0 ms | 11.8x |
| **Peak Memory (RSS)** | 12.1 MB | 864.2 MB | **71.3x less memory** |
| **Accuracy** | ✅ Verifiable | ✅ Verifiable | Within $10^{-6}$ tolerance |

## Analysis: How it Works
1. **Gradient Generation**: Enzyme replaces `__enzyme_autodiff` calls with a generated gradient function at the LLVM IR level.
2. **Post-Optimization**: Unlike runtime frameworks, the generated gradient is an LLVM IR function that can be further optimized by standard passes (`opt -O2`). This allows for LICM (Loop Invariant Code Motion) and SIMD vectorization across the differentiated logic.
3. **Zero Runtime Overhead**: There is no dynamic graph construction or interpreter overhead. The final binary is pure machine code.

## Reproducibility

### 1. Build the Enzyme Binary
Requires LLVM 18 + Enzyme plugin (see [INSTALL_WSL2.md](INSTALL_WSL2.md)).
```bash
make pendulum_bench
```

### 2. Run the Benchmark Demo
```bash
python python/bench_demo.py
```

### 3. Run full PyTorch Baseline
```bash
pip install torch
python python/simple_bench.py
```

## Disclaimer
Gains of 10x-20x are typical for **ODE simulation loops** where the computation graph is long (1000+ nodes) but the state is small. In large-scale Deep Learning (e.g., Transformers), the matrix multiplication kernels dominate, and the relative advantage of compiler-level AD typically narrows though memory efficiency remains a key differentiator.

