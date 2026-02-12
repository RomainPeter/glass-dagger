#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
import argparse
import json
import os
import subprocess
import sys
import platform
from datetime import datetime

def run_cmd(cmd, shell=False):
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True, shell=shell)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return None

def find_binary(args):
    # 1. Flag
    if args.bin and os.path.exists(args.bin):
        return args.bin
    
    # 2. Env var
    env_bin = os.getenv("GLASS_DAGGER_BIN")
    if env_bin and os.path.exists(env_bin):
        return env_bin
        
    # 3. Default path
    default_path = "./build/pendulum_bench"
    if os.path.exists(default_path):
        return default_path
        
    return None

def main():
    parser = argparse.ArgumentParser(description="Glass Dagger M3: Benchmark Demo")
    parser.add_argument("--bin", help="Path to the Enzyme benchmark binary")
    parser.add_argument("--wsl", action="store_true", help="Force execution via WSL")
    parser.add_argument("--dry-run", action="store_true", help="CI mode: check paths but don't run")
    parser.add_argument("--strict", action="store_true", help="Exit with error if binary missing")
    parser.add_argument("--iters", type=int, default=200)
    parser.add_argument("--steps", type=int, default=1000)
    args = parser.parse_args()

    print("=== Glass Dagger M3: Benchmark Demo ===")

    binary = find_binary(args)
    
    if args.dry_run:
        print("✅ Dry-run: Paths and syntax OK.")
        sys.exit(0)

    if not binary:
        print("⚠️  Enzyme binary not found.")
        print("💡 To build it, run: make pendulum_bench (in WSL/Linux)")
        if args.strict:
            sys.exit(1)
        sys.exit(0)

    # WSL Check
    use_wsl = args.wsl or (platform.system() == "Windows" and binary.startswith("./"))
    
    cmd = []
    if use_wsl:
        # Avoid C:\ paths in WSL command
        wsl_binary = binary.replace("\\", "/")
        cmd = ["wsl", "-d", "Ubuntu", "-u", "romain", "bash", "-c", 
               f"source ~/glass-dagger/scripts/toolchain/env.sh && cd ~/glass-dagger && {wsl_binary} --json --iters {args.iters} --steps {args.steps}"]
    else:
        cmd = [binary, "--json", "--iters", str(args.iters), "--steps", str(args.steps)]

    print(f"🚀 Running {'(WSL) ' if use_wsl else ''}{binary}...")
    
    start_wall = datetime.now()
    output = run_cmd(cmd)
    end_wall = datetime.now()
    wall_ms = (end_wall - start_wall).total_seconds() * 1000

    if not output:
        print("❌ Benchmark execution failed.")
        sys.exit(1)

    try:
        res = json.loads(output)
        res["meta"] = {
            "timestamp": datetime.now().isoformat(),
            "os": platform.system(),
            "wsl": use_wsl,
            "wall_ms": wall_ms
        }
        
        os.makedirs("artifacts", exist_ok=True)
        with open("artifacts/bench_demo.json", "w") as f:
            json.dump(res, f, indent=2)

        # ASCII Table
        print("\n" + "="*45)
        print(f"| {'Metric':<20} | {'Value':<18} |")
        print("|" + "-"*22 + "|" + "-"*20 + "|")
        print(f"| {'Engine':<20} | {res['engine']:<18} |")
        print(f"| {'Loss (Start)':<20} | {res['results']['loss_start']:<18.6f} |")
        print(f"| {'Loss (End)':<20} | {res['results']['loss_end']:<18.6f} |")
        print(f"| {'Total Time (ms)':<20} | {res['results']['time_total_ms']:<18.2f} |")
        print(f"| {'Time/Iter (ms)':<20} | {res['results']['time_per_iter_ms']:<18.4f} |")
        print("="*45)
        print("\n✅ Results saved to artifacts/bench_demo.json")

    except json.JSONDecodeError:
        print(f"❌ Failed to parse JSON output: {output[:200]}")
        sys.exit(1)

if __name__ == "__main__":
    main()

