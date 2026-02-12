// SPDX-License-Identifier: MIT
// Glass Dagger M2: Double Pendulum Physics
// Reference: https://physics.umd.edu/hep/drew/pendulum2.html

#ifndef DOUBLE_PENDULUM_H
#define DOUBLE_PENDULUM_H

// State vector: [theta1, omega1, theta2, omega2]
typedef struct {
    double theta1;   // Angle of pendulum 1 (rad)
    double omega1;   // Angular velocity of pendulum 1 (rad/s)
    double theta2;   // Angle of pendulum 2 (rad)
    double omega2;   // Angular velocity of pendulum 2 (rad/s)
} State;

// Physical parameters
typedef struct {
    double m1, m2;   // Masses (kg)
    double L1, L2;   // Lengths (m)
    double g;        // Gravity (m/s²)
} Params;

// Compute derivatives dy/dt = f(t, y) using UMD equations
void deriv(double t, const State* y, State* dydt, const Params* p);

// Single RK4 integration step
void rk4_step(State* y, double dt, const Params* p);

// Simulate from y0 for N steps with timestep dt
State simulate(State y0, int steps, double dt, const Params* p);

// Compute Cartesian position of bob 2
void get_bob2_position(const State* y, const Params* p, double* x2, double* y2);

#endif // DOUBLE_PENDULUM_H
