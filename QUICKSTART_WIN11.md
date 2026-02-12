# Glass Dagger - Quick Start (Windows 11 x86_64)

> **Your Configuration**: Windows 11 x86_64 ✅  
> This is the optimal setup for LLVM/Enzyme development.

## Total Time: ~2-3 hours

- WSL2 setup: 15 minutes
- LLVM build: 1-2 hours
- Enzyme build: 15-30 minutes
- Smoke test: 5 minutes

---

## Step 1: Install WSL2 (15 minutes)

### Quick Install

Open **PowerShell as Administrator**:

```powershell
# One-command install (Windows 11 default)
wsl --install

# This installs:
# - WSL2 kernel
# - Ubuntu 22.04 LTS (default)
# - Virtual machine platform
```

**Reboot when prompted.**

### First Launch

After reboot, Ubuntu will auto-launch and ask for:
- Username (suggest: your Windows username)
- Password (needed for `sudo`)

```bash
# Verify installation
wsl --list --verbose
# Should show: Ubuntu    Running    2
```

---

## Step 2: Clone Project in WSL2 (5 minutes)

```bash
# Launch Ubuntu (if not already running)
wsl

# Update package list
sudo apt update

# Create workspace in Linux filesystem (CRITICAL!)
cd ~
git clone <your-repo-url> glass-dagger
cd glass-dagger

# OR copy from Windows:
# cp -r /mnt/c/Users/romai/Desktop/BUILDING\ PROJECTS/LANGAGE\ ADIABATIQUE/glass_dagger_enzyme ~/glass-dagger
# cd ~/glass-dagger
```

> **⚠️ IMPORTANT**: Work in `~/glass-dagger`, NOT `/mnt/c/...`  
> WSL2 performance is 10x faster on Linux filesystem.

---

## Step 3: Install Dependencies (5 minutes)

```bash
# Install all required packages
sudo apt install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    wget

# Verify
cmake --version   # Should be 3.22+
ninja --version   # Should be 1.10+
gcc --version     # Should be 11.x
```

---

## Step 4: Build LLVM 18 (1-2 hours) ☕

```bash
cd ~/glass-dagger

# Run automated build script
bash scripts/toolchain/build_llvm.sh
```

**What happens**:
1. Clones `llvm-project` (~500MB download)
2. Configures build with CMake
3. Builds with all but one CPU core
4. Installs to `toolchain/llvm18/`

**Progress monitoring**:
Open another WSL2 terminal:
```bash
# Watch build progress
htop

# Or check disk usage
du -sh ~/glass-dagger/toolchain/llvm-project/build
```

**Expected output**:
```
🎉 LLVM 18 build complete!
Next steps:
  1. Run: bash scripts/toolchain/build_enzyme.sh
  ...
```

---

## Step 5: Build Enzyme (15-30 minutes)

```bash
# Run automated build script
bash scripts/toolchain/build_enzyme.sh
```

**What happens**:
1. Clones Enzyme repository
2. Links to your LLVM 18 build
3. Runs validation tests
4. Installs plugin to `toolchain/enzyme/`

**Expected output**:
```
✅ All Enzyme tests passed
🎉 Enzyme build complete!
Plugin location: ~/glass-dagger/toolchain/enzyme/LLVMEnzyme-18.so
```

---

## Step 6: Run Smoke Test (5 minutes)

```bash
# Configure environment
source scripts/toolchain/env.sh

# Run smoke test
make smoke
```

**Expected output**:
```
=== Glass Dagger Enzyme Smoke Test ===
✅ Enzyme plugin found: ~/glass-dagger/toolchain/enzyme/LLVMEnzyme.so
✅ Using LLVM from: ~/glass-dagger/toolchain/llvm18/bin

Step 1/5: Compiling C to LLVM IR...
✅ Generated smoke.ll

Step 2/5: Applying Enzyme AD pass...
✅ Enzyme pass complete (smoke_enzyme.ll)

Step 3/5: Re-optimizing gradient code...
✅ Post-optimization complete (smoke_opt.ll)

Step 4/5: Compiling to binary...
✅ Binary created (smoke_test)

Step 5/5: Running smoke test...
---
=== Glass Dagger Enzyme Smoke Test ===

✅ square: d/dx(3.000000) = 6.000000 (expected 6.000000, error: 1.42e-14)
✅ square: d/dx(-2.500000) = -5.000000 (expected -5.000000, error: 0.00e+00)
✅ polynomial: d/dx(2.000000) = 39.000000 (expected 39.000000, error: 0.00e+00)
✅ polynomial: d/dx(-1.000000) = 0.000000 (expected 0.000000, error: 0.00e+00)

=== Test Summary ===
✅ All tests passed! Enzyme toolchain is working correctly.
---

🎉 SUCCESS: Enzyme toolchain is fully operational!
```

---

## Troubleshooting (Windows 11 Specific)

### "wsl --install" not found

**Cause**: PowerShell version too old.

**Fix**: Update PowerShell or use Windows Update to install WSL feature.

### Build fails with "virtual memory exhausted"

**Cause**: WSL2 default memory limit (50% of RAM).

**Fix**: Create `C:\Users\romai\.wslconfig`:
```ini
[wsl2]
memory=12GB
processors=6
```

Then restart WSL2:
```powershell
wsl --shutdown
wsl
```

### Slow build (>3 hours)

**Cause**: Working on Windows filesystem (`/mnt/c/`).

**Fix**: Ensure you're in Linux filesystem:
```bash
pwd
# Should show: /home/yourname/glass-dagger
# NOT: /mnt/c/Users/...
```

---

## What You Can Do Now

### Inspect Generated Code

```bash
cd ~/glass-dagger/build

# View original LLVM IR
cat smoke.ll

# View after Enzyme (gradient code added)
cat smoke_enzyme.ll | grep -A 20 "define.*diffe"

# View after re-optimization
cat smoke_opt.ll
```

### Run Python Validation

```bash
python3 python/finite_diff_check.py
```

---

## Next Steps

Once smoke test passes, you're ready for:

1. **M1**: Implement simple loss functions
2. **M2**: Double pendulum simulation
3. **M3**: Gradient-based optimization
4. **M4**: PyTorch benchmark

---

## Windows 11 Advantages

✅ **WSL2 GUI Support**: Can run Linux GUI apps  
✅ **Better Memory Management**: Dynamic memory allocation  
✅ **WSLg Integration**: Seamless clipboard/file sharing  
✅ **Faster I/O**: Improved filesystem performance  

---

## Persistence

Add to your `~/.bashrc` (in WSL2):
```bash
# Glass Dagger environment
if [ -d ~/glass-dagger ]; then
    source ~/glass-dagger/scripts/toolchain/env.sh 2>/dev/null
fi
```

Now `clang` and `opt` will always point to your LLVM 18 build.

---

## Summary

| Command | Purpose | Time |
|---------|---------|------|
| `wsl --install` | Install WSL2 | 15 min |
| `bash scripts/toolchain/build_llvm.sh` | Build LLVM 18 | 1-2 hrs |
| `bash scripts/toolchain/build_enzyme.sh` | Build Enzyme | 15-30 min |
| `source scripts/toolchain/env.sh` | Configure env | 1 sec |
| `make smoke` | Validate setup | 5 min |

**Total**: ~2-3 hours (mostly unattended build time)

---

**Ready to start?** Open PowerShell as Administrator and run `wsl --install` 🚀
