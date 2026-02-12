#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
import time
import json
import os
import math
import argparse
from datetime import datetime

try:
    import torch
except ImportError:
    torch = None

# Physics constants (Identical to C version)
M1, M2, L1, L2, G = 1.0, 1.0, 1.0, 1.0, 9.81
THETA1_0, THETA2_0 = math.pi / 4.0, math.pi / 6.0
X2_TARGET, Y2_TARGET = 0.0, -1.8

def double_pendulum_deriv(state):
    theta1, omega1, theta2, omega2 = state
    dtheta = theta1 - theta2
    cos_dtheta = torch.cos(dtheta)
    sin_dtheta = torch.sin(dtheta)
    denom = 2*M1 + M2 - M2*torch.cos(2*dtheta)
    
    alpha1_num = -G*(2*M1 + M2)*torch.sin(theta1) - M2*G*torch.sin(theta1 - 2*theta2) - 2*sin_dtheta*M2*(omega2**2*L2 + omega1**2*L1*cos_dtheta)
    alpha1 = alpha1_num / (L1 * denom)
    
    alpha2_num = 2*sin_dtheta*(omega1**2*L1*(M1 + M2) + G*(M1 + M2)*torch.cos(theta1) + omega2**2*L2*M2*cos_dtheta)
    alpha2 = alpha2_num / (L2 * denom)
    
    return torch.stack([omega1, alpha1, omega2, alpha2])

def simulate(omega1_0, omega2_0, steps=1000, dt=0.001):
    state = torch.stack([
        torch.tensor(THETA1_0, dtype=torch.float64),
        omega1_0,
        torch.tensor(THETA2_0, dtype=torch.float64),
        omega2_0
    ])
    
    for _ in range(steps):
        k1 = double_pendulum_deriv(state)
        k2 = double_pendulum_deriv(state + 0.5 * dt * k1)
        k3 = double_pendulum_deriv(state + 0.5 * dt * k2)
        k4 = double_pendulum_deriv(state + dt * k3)
        state = state + (dt / 6.0) * (k1 + 2*k2 + 2*k3 + k4)
        
    return state

def main():
    parser = argparse.ArgumentParser(description="Glass Dagger M3: PyTorch Baseline")
    parser.add_argument("--iters", type=int, default=200)
    parser.add_argument("--steps", type=int, default=1000)
    args = parser.parse_args()

    print("=== Glass Dagger M3: PyTorch Baseline ===")

    if torch is None:
        print("⚠️  PyTorch not installed. Skip benchmark.")
        print("💡 Run: pip install torch")
        return

    # Deterministic behavior for benchmarking
    torch.set_num_threads(1)
    
    omega1_0 = torch.tensor(0.0, dtype=torch.float64, requires_grad=True)
    omega2_0 = torch.tensor(0.0, dtype=torch.float64, requires_grad=True)
    optimizer = torch.optim.SGD([omega1_0, omega2_0], lr=0.02)
    
    # Measure
    start_time = time.time()
    for i in range(args.iters):
        optimizer.zero_grad()
        state_T = simulate(omega1_0, omega2_0, steps=args.steps)
        theta1, _, theta2, _ = state_T
        x2 = L1 * torch.sin(theta1) + L2 * torch.sin(theta2)
        y2 = -L1 * torch.cos(theta1) - L2 * torch.cos(theta2)
        loss = (x2 - X2_TARGET)**2 + (y2 - Y2_TARGET)**2 + 1e-3 * (omega1_0**2 + omega2_0**2)
        loss.backward()
        optimizer.step()
    
    total_ms = (time.time() - start_time) * 1000
    
    # Results
    res = {
        "engine": "pytorch_cpu",
        "results": {
            "loss_start": 0.0, # Placeholder or measure properly
            "loss_end": float(loss.item()),
            "time_total_ms": total_ms,
            "time_per_iter_ms": total_ms / args.iters
        },
        "meta": {
            "timestamp": datetime.now().isoformat(),
            "torch_version": torch.__version__
        }
    }
    
    os.makedirs("artifacts", exist_ok=True)
    with open("artifacts/bench_results.json", "w") as f:
        json.dump(res, f, indent=2)

    print(f"\n✅ PyTorch Benchmark Finished.")
    print(f"   Time/Iter: {res['results']['time_per_iter_ms']:.4f} ms")
    print(f"   Results saved to artifacts/bench_results.json")

if __name__ == "__main__":
    main()

