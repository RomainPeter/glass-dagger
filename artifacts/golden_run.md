# Glass Dagger - Golden Run Results

**Generated**: 2026-02-12T14:16:07Z

## Environment

- **OS**: Linux 6.6.87.2-microsoft-standard-WSL2
- **LLVM Version**: 18.1.8
- **Enzyme Plugin**: LLVMEnzyme.so
- **Compiler Flags**: `-O2 -fno-vectorize -fno-slp-vectorize -ffast-math`

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
- **Initial loss**: 0.977403
- **Final loss**: 0.053269 (reduction: 100.0%)
- **Final error**: 0.224129m (threshold: 0.3m)
- **Iterations**: 200
- **Final parameters**: ω₁=1.422795, ω₂=1.005506

## Reproducibility

To reproduce these results:
```bash
source scripts/toolchain/env.sh
make verify
```

All tests should pass with values within ±1% of golden values.
