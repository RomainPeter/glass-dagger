#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
# Glass Dagger M3: PyTorch Baseline for Double Pendulum Optimization

import torch
import math
import time
import json
import argparse
import sys

# Fixed physical parameters
M1 = 1.0
M2 = 1.0
L1 = 1.0
L2 = 1.0
G = 9.81

# Initial angles
THETA1_0 = math.pi / 4.0
THETA2_0 = math.pi / 6.0

# Target position
X2_TARGET = 0.0
Y2_TARGET = -1.8

def double_pendulum_deriv(state):
    theta1, omega1, theta2, omega2 = state
    
    dtheta = theta1 - theta2
    cos_dtheta = torch.cos(dtheta)
    sin_dtheta = torch.sin(dtheta)
    
    denom = 2*M1 + M2 - M2*torch.cos(2*dtheta)
    
    alpha1_num = -G*(2*M1 + M2)*torch.sin(theta1) \
                 - M2*G*torch.sin(theta1 - 2*theta2) \
                 - 2*sin_dtheta*M2*(omega2**2*L2 + omega1**2*L1*cos_dtheta)
    alpha1 = alpha1_num / (L1 * denom)
    
    alpha2_num = 2*sin_dtheta*(omega1**2*L1*(M1 + M2) \
                               + G*(M1 + M2)*torch.cos(theta1) \
                               + omega2**2*L2*M2*cos_dtheta)
    alpha2 = alpha2_num / (L2 * denom)
    
    return torch.stack([omega1, alpha1, omega2, alpha2])

def simulate(omega1_0, omega2_0, steps, dt):
    state = torch.stack([
        torch.tensor(THETA1_0, dtype=torch.float64),
        omega1_0,
        torch.tensor(THETA2_0, dtype=torch.float64),
        omega2_0
    ])
    
    for _ in range(steps):
        # RK4
        k1 = double_pendulum_deriv(state)
        k2 = double_pendulum_deriv(state + 0.5 * dt * k1)
        k3 = double_pendulum_deriv(state + 0.5 * dt * k2)
        k4 = double_pendulum_deriv(state + dt * k3)
        
        state = state + (dt / 6.0) * (k1 + 2*k2 + 2*k3 + k4)
        
    return state

def run_optimization(steps=1000, dt=0.001, iters=200, lr=0.02, silent=False):
    torch.set_num_threads(1)
    
    # Parameters to optimize
    omega1_0 = torch.tensor(0.0, dtype=torch.float64, requires_grad=True)
    omega2_0 = torch.tensor(0.0, dtype=torch.float64, requires_grad=True)
    
    optimizer = torch.optim.SGD([omega1_0, omega2_0], lr=lr)
    
    start_time = time.time()
    
    initial_loss = 0.0
    final_loss = 0.0
    
    if not silent:
        print(f"=== Glass Dagger M3: PyTorch Baseline ===")
        print(f"Target: ({X2_TARGET}, {Y2_TARGET})")
        
    for i in range(iters):
        optimizer.zero_grad()
        
        state_T = simulate(omega1_0, omega2_0, steps, dt)
        theta1_T, _, theta2_T, _ = state_T
        
        x2 = L1 * torch.sin(theta1_T) + L2 * torch.sin(theta2_T)
        y2 = -L1 * torch.cos(theta1_T) - L2 * torch.cos(theta2_T)
        
        pos_loss = (x2 - X2_TARGET)**2 + (y2 - Y2_TARGET)**2
        reg = 1e-3 * (omega1_0**2 + omega2_0**2)
        loss = pos_loss + reg
        
        if i == 0:
            initial_loss = loss.item()
            if not silent:
                print(f"Initial: loss={initial_loss:.6f}")
        
        loss.backward()
        optimizer.step()
        
        if not silent and ((i+1) % 10 == 0 or i == 0):
            print(f"[{i+1:03d}] loss={loss.item():.6f}")
            
    final_loss = loss.item()
    total_time = (time.time() - start_time) * 1000.0  # ms
    
    # Final state for error compute
    with torch.no_grad():
        final_state = simulate(omega1_0, omega2_0, steps, dt)
        f_theta1, _, f_theta2, _ = final_state
        fx2 = L1 * math.sin(f_theta1) + L2 * math.sin(f_theta2)
        fy2 = -L1 * math.cos(f_theta1) - L2 * math.cos(f_theta2)
        final_dist = math.sqrt((fx2 - X2_TARGET)**2 + (fy2 - Y2_TARGET)**2)

    result = {
        "engine": "pytorch_cpu",
        "config": {
            "steps": steps,
            "dt": dt,
            "iters": iters,
            "dtype": "float64",
            "threads": 1
        },
        "results": {
            "loss_start": initial_loss,
            "loss_end": final_loss,
            "dist_end_cm": final_dist * 100.0,
            "time_total_ms": total_time,
            "time_per_iter_ms": total_time / iters
        },
        "versions": {
            "torch": torch.__version__,
            "python": sys.version.split()[0]
        }
    }
    
    return result

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--json", action="store_true", help="Output JSON only")
    parser.add_argument("--iters", type=int, default=200, help="Number of iterations")
    parser.add_argument("--steps", type=int, default=1000, help="Simulation steps")
    args = parser.parse_args()
    
    res = run_optimization(iters=args.iters, steps=args.steps, silent=args.json)
    
    if args.json:
        print(json.dumps(res, indent=2))
    else:
        print(f"\nFinal Result: Loss={res['results']['loss_end']:.6f}, Time={res['results']['time_total_ms']:.2f}ms")
