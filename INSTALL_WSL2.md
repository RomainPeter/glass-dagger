# Glass Dagger - WSL2 Toolchain Installation Guide

This guide walks you through setting up the complete Enzyme development environment on Windows via WSL2.

## Prerequisites

- **Windows 10** (version 2004+) or **Windows 11**
- **x86_64** architecture (ARM64 experimental, see notes below)
- At least **20GB** free disk space (LLVM build is large)
- Administrator access

## Step 1: Install WSL2

### Quick Install (Windows 11 or Windows 10 22H2+)

Open PowerShell as Administrator and run:

```powershell
wsl --install
```

This installs Ubuntu 22.04 by default. Reboot when prompted.

### Manual Install (Older Windows 10)

See: https://learn.microsoft.com/en-us/windows/wsl/install-manual

### Verify Installation

```powershell
wsl --list --verbose
```

You should see Ubuntu with VERSION 2.

## Step 2: Enter WSL2 and Set Up Workspace

```bash
# Launch Ubuntu
wsl

# Create workspace in Linux filesystem (NOT /mnt/c/...)
mkdir -p ~/glass-dagger
cd ~/glass-dagger

# Clone the project
git clone <your-repo-url> .
# OR if you're copying from Windows:
# cp -r /mnt/c/Users/romai/Desktop/.../glass_dagger_enzyme/* .
```

> **⚠️ CRITICAL**: Work in the Linux filesystem (`~/`), NOT Windows filesystem (`/mnt/c/`).  
> Enzyme builds can have I/O issues and performance degradation on mounted NTFS.

## Step 3: Install System Dependencies

```bash
# Update package lists
sudo apt update

# Install build essentials
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

# Verify versions
cmake --version    # Should be 3.22+
ninja --version    # Should be 1.10+
```

## Step 4: Build LLVM 18 from Source

This takes **1-2 hours** and requires ~15GB disk space.

```bash
cd ~/glass-dagger

# Run automated build script
bash scripts/toolchain/build_llvm.sh

# OR manual build:
# See scripts/toolchain/build_llvm.sh for exact steps
```

The script will:
1. Clone `llvm-project` (LLVM 18.1.x branch)
2. Configure with CMake + Ninja
3. Build LLVM, Clang, and opt
4. Install to `~/glass-dagger/toolchain/llvm18`

**Coffee break recommended.** ☕

## Step 5: Build Enzyme from Source

```bash
# Run automated build script
bash scripts/toolchain/build_enzyme.sh

# This will:
# 1. Clone Enzyme repository
# 2. Build against your LLVM 18
# 3. Run 'ninja check-enzyme' to validate
# 4. Install plugin to toolchain/enzyme
```

**Expected output**: All Enzyme tests pass, plugin built successfully.

## Step 6: Configure Environment

```bash
# Source the environment variables
source scripts/toolchain/env.sh

# Add to your ~/.bashrc for persistence
echo "source ~/glass-dagger/scripts/toolchain/env.sh" >> ~/.bashrc
```

This sets:
- `LLVM_BIN` → path to clang/opt
- `ENZYME_PLUGIN` → path to LLVMEnzyme-18.so
- Updates `PATH`

## Step 7: Run Smoke Test

```bash
# Validate the entire toolchain
make smoke
```

**Expected output**:
```
=== Glass Dagger Enzyme Smoke Test ===
✅ Enzyme plugin found: ~/glass-dagger/toolchain/enzyme/LLVMEnzyme-18.so
✅ LLVM toolchain ready
Step 1/5: Compiling C to LLVM IR...
✅ Generated smoke.ll
...
🎉 SUCCESS: Enzyme toolchain is fully operational!
```

If you see errors, check:
- LLVM and Enzyme were built from the same source tree
- Environment variables are set correctly
- You're not mixing system LLVM with custom build

## Troubleshooting

### "opt: error loading plugin"

**Cause**: LLVM version mismatch between `opt` and Enzyme plugin.

**Fix**: Rebuild Enzyme pointing to the exact LLVM you just built:
```bash
cd ~/glass-dagger/toolchain/enzyme-src
rm -rf build && mkdir build && cd build
cmake -G Ninja .. -DLLVM_DIR=~/glass-dagger/toolchain/llvm18/lib/cmake/llvm
ninja
```

### Build fails with "out of memory"

**Cause**: WSL2 default memory limit (50% of system RAM).

**Fix**: Create `%USERPROFILE%\.wslconfig` in Windows:
```ini
[wsl2]
memory=8GB
```

Restart WSL2: `wsl --shutdown` then `wsl`

### Slow build performance

**Cause**: Working on mounted Windows filesystem (`/mnt/c/`).

**Fix**: Move entire workspace to Linux filesystem (`~/glass-dagger`).

## ARM64 Windows (Surface, etc.)

Enzyme on ARM64 is **experimental**. LLVM 18 supports ARM64, but:
- Cross-compilation may be needed
- Some Enzyme tests might fail
- Recommend x86_64 for production use

If you must use ARM64:
1. Follow same steps
2. Expect longer build times
3. File issues on Enzyme GitHub if tests fail

## Next Steps

Once smoke test passes:
1. Proceed to M1: Simple loss functions
2. Implement M2: Double pendulum simulation
3. Run M4: Benchmark against PyTorch

## Resources

- [WSL2 Installation](https://learn.microsoft.com/en-us/windows/wsl/install)
- [LLVM Build Guide](https://llvm.org/docs/CMake.html)
- [Enzyme Installation](https://enzyme.mit.edu/Installation/)
- [Enzyme GitHub Issues](https://github.com/EnzymeAD/Enzyme/issues)
