# Glass Dagger - Common Failure Modes & Solutions

This document covers the most common issues when building and using Enzyme for automatic differentiation.

---

## 1. Plugin Loading Failures

### Symptom
```
opt: error loading plugin 'LLVMEnzyme-18.so':
  <path>/LLVMEnzyme-18.so: undefined symbol: ...
```

### Root Cause
**LLVM version mismatch** between the `opt` binary and the Enzyme plugin. The Enzyme plugin is tightly coupled to the LLVM version it was built against.

### Solution
Ensure `opt` and Enzyme come from the **same LLVM build**:

```bash
# Check your opt version
$LLVM_BIN/opt --version

# Check where Enzyme was built
# Should point to the same LLVM installation
grep "LLVM_DIR" toolchain/enzyme-src/enzyme/build/CMakeCache.txt
```

**Fix**: Rebuild Enzyme pointing to your custom LLVM:
```bash
cd ~/glass-dagger
rm -rf toolchain/enzyme-src/enzyme/build
bash scripts/toolchain/build_enzyme.sh
```

**Reference**: Enzyme docs explicitly warn about this: https://enzyme.mit.edu/getting_started/UsingEnzyme/

---

## 2. Bitcode vs LLVM Assembly Confusion

### Symptom  
- `.ll` files appear binary/unreadable
- `opt` output is not human-readable
- Errors about "invalid bitcode" when trying to inspect IR

### Root Cause
LLVM `opt` outputs **bitcode** (binary format) by default, not LLVM assembly (text format).

### Solution
**Always use `-S` flag** when writing `.ll` files:

```bash
# ❌ WRONG: Produces bitcode in a .ll file
opt input.ll -passes=enzyme -o output.ll

# ✅ CORRECT: Produces LLVM assembly
opt input.ll -passes=enzyme -o output.ll -S
```

This is documented in LLVM opt manual: https://llvm.org/docs/CommandGuide/opt.html

**Why it matters**: You can't inspect bitcode with `cat` or text editors. The `-S` flag ensures you get readable IR for debugging.

---

## 3. Enzyme Plugin Not Found

### Symptom
```
⚠️ WARNING: Enzyme plugin not found at .../LLVMEnzyme-*.so
Please run: bash scripts/toolchain/build_enzyme.sh
```

### Root Cause
Enzyme plugin has a **versioned filename** (e.g., `LLVMEnzyme-18.so`), but the environment script looks for a fixed name.

### Solution
Our `env.sh` now uses robust detection:

```bash
# Finds LLVMEnzyme-18.so, LLVMEnzyme-19.so, etc.
ENZYME_PLUGIN=$(find "$ENZYME_DIR" -name "LLVMEnzyme-*.so" | head -n 1)
```

If still failing:
```bash
# Manually locate the plugin
find ~/glass-dagger/toolchain -name "LLVMEnzyme*.so"

# Set manually
export ENZYME_PLUGIN="/path/to/actual/LLVMEnzyme-18.so"
```

**Reference**: Enzyme installation docs mention this: https://enzyme.mit.edu/Installation/

---

## 4. Gradients Appear Correct but Non-Reproducible

### Symptom
- Smoke test passes
- Gradient values seem reasonable
- But results change slightly between runs

### Root Cause
- **Uninitialized variables** in C code
- **Floating-point flags**: `-ffast-math` can produce non-deterministic results
- **LLVM optimizations** reordering operations

### Solution
For reproducibility:

```bash
# Remove -ffast-math for deterministic builds
clang -S -emit-llvm -O2 source.c -o output.ll
# (no -ffast-math)
```

Add finite-difference validation:
```c
// In your test code
double numerical_grad = (f(x + eps) - f(x - eps)) / (2 * eps);
assert(fabs(enzyme_grad - numerical_grad) < 1e-4);
```

---

## 5. Build Fails: "Virtual Memory Exhausted"

### Symptom
```
c++: fatal error: Killed signal terminated program cc1plus
virtual memory exhausted: Cannot allocate memory
```

### Root Cause
LLVM build requires significant RAM (8GB+ recommended). WSL2 default memory limit is 50% of system RAM.

### Solution (Windows 11)
Create `C:\Users\<username>\.wslconfig`:

```ini
[wsl2]
memory=12GB
processors=6
swap=4GB
```

Restart WSL2:
```powershell
wsl --shutdown
wsl
```

Check available memory in WSL2:
```bash
free -h
```

**Alternative**: Use `ninja -j2` to limit parallel jobs:
```bash
cd toolchain/llvm-project/build
ninja -j2  # Use only 2 parallel jobs
```

---

## 6. WSL2 Filesystem Performance Issues

### Symptom
- LLVM build takes >4 hours
- File operations are very slow
- High disk I/O wait times

### Root Cause
Working on Windows filesystem (`/mnt/c/...`) instead of Linux filesystem.

### Solution
**Always work in Linux filesystem**:

```bash
# ❌ BAD: Slow!
cd /mnt/c/Users/romai/Desktop/glass-dagger

# ✅ GOOD: Fast!
cd ~/glass-dagger
```

**Verify** you're in the right place:
```bash
pwd
# Should show: /home/yourname/glass-dagger
# NOT: /mnt/c/...
```

WSL2 docs explain this: https://learn.microsoft.com/en-us/windows/wsl/filesystems

---

## 7. Enzyme Tests Fail During Build

### Symptom
```
Step 4/5: Running Enzyme validation tests...
...
**Failed** Tests (5):
  Enzyme :: ...
```

### Root Cause
- LLVM version incompatibility (Enzyme targets LLVM 11-16 officially)
- Missing LLVM features or passes
- This is **often acceptable** for the smoke test

### Solution
Check which tests failed:

```bash
cd toolchain/enzyme-src/enzyme/build
ctest --rerun-failed --output-on-failure
```

If failures are in **advanced features** you're not using (GPU, parallel), proceed anyway.

**Critical check**: Did the smoke test (`make smoke`) pass? If yes, you're good.

**Reference**: Enzyme docs note that LLVM 17+ is experimental: https://enzyme.mit.edu/Installation/

---

## 8. Clang vs MSVC Confusion (Windows Native Attempt)

### Symptom
- Trying to build Enzyme natively on Windows
- Errors about incompatible toolchains or ABI
- Plugin fails to load

### Root Cause
Enzyme's plugin infrastructure doesn't mix well with MSVC-built LLVM on Windows.

### Solution
**Don't use native Windows for Enzyme MVP.** Use WSL2 instead.

This is a known issue: https://github.com/EnzymeAD/Enzyme/issues/1607

---

## 9. Incorrect Gradients Despite Passing Tests

### Symptom
- Smoke test passes
- But gradients don't match expected values for your function
- Or optimization doesn't converge

### Root Cause
- **Activity analysis**: Enzyme may mark variables as "inactive" (constant)
- **Incorrect use** of `__enzyme_autodiff` signature
- **Non-differentiable operations** in your code (e.g., random numbers, I/O)

### Solution
**Check Enzyme assumptions**:

1. Variables must **actually depend** on the input
2. No side effects (global state, I/O)
3. Use correct `__enzyme_autodiff` signature:

```c
// For scalar functions
extern double __enzyme_autodiff(void*, double);
double grad = __enzyme_autodiff((void*)f, x);

// For functions with multiple params, see Enzyme docs
```

**Validate with finite differences**:
```python
def validate(f, x, enzyme_grad, eps=1e-5):
    fd_grad = (f(x + eps) - f(x - eps)) / (2 * eps)
    assert abs(enzyme_grad - fd_grad) < 1e-3
```

---

## 10. "Outdated" LLVM IR After Edits

### Symptom
- Changed C source code
- Recompiled
- But behavior hasn't changed

### Root Cause
Stale `.ll` files in `build/` directory.

### Solution
**Always clean before rebuilding**:

```bash
make clean
make smoke
```

Or manually:
```bash
rm -rf build/
bash scripts/smoke.sh
```

---

## Quick Debug Checklist

When something goes wrong:

1. **Check versions**:
   ```bash
   $LLVM_BIN/clang --version
   $LLVM_BIN/opt --version
   ls -lh $ENZYME_PLUGIN
   ```

2. **Verify environment**:
   ```bash
   source scripts/toolchain/env.sh
   echo $LLVM_BIN
   echo $ENZYME_PLUGIN
   ```

3. **Inspect generated IR**:
   ```bash
   cat build/smoke.ll             # Original
   cat build/smoke_enzyme.ll      # After Enzyme
   grep "define.*diffe" build/smoke_enzyme.ll  # Find gradient functions
   ```

4. **Check build logs**:
   ```bash
   tail -f toolchain/llvm-project/build/build.log
   tail -f toolchain/enzyme-src/enzyme/build/Testing/Temporary/LastTest.log
   ```

5. **Test incrementally**:
   ```bash
   # Test LLVM only
   $LLVM_BIN/clang --version

   # Test Enzyme plugin load
   $LLVM_BIN/opt --load-pass-plugin=$ENZYME_PLUGIN --version

   # Test full pipeline
   make smoke
   ```

---

## Getting Help

If issues persist:

1. **Check Enzyme GitHub issues**: https://github.com/EnzymeAD/Enzyme/issues
2. **LLVM Discourse**: https://discourse.llvm.org/
3. **Include in bug reports**:
   - Output of `$LLVM_BIN/opt --version`
   - Output of `$LLVM_BIN/clang --version`
   - Enzyme plugin path and size: `ls -lh $ENZYME_PLUGIN`
   - Minimal `.ll` file that fails
   - Full error message

---

**Last Updated**: Following Enzyme 0.0.x and LLVM 18.1.x documentation
