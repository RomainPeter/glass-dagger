// SPDX-License-Identifier: MIT
// Glass Dagger M2: Double Pendulum Physics Implementation
// Reference: https://physics.umd.edu/hep/drew/pendulum2.html

#include "double_pendulum.h"
#include <math.h>

// Compute derivatives using UMD formulation
// dy/dt = [omega1, alpha1, omega2, alpha2]
void deriv(double t, const State* y, State* dydt, const Params* p) {
    (void)t;  // Time-independent system
    
    double theta1 = y->theta1;
    double omega1 = y->omega1;
    double theta2 = y->theta2;
    double omega2 = y->omega2;
    
    double m1 = p->m1;
    double m2 = p->m2;
    double L1 = p->L1;
    double L2 = p->L2;
    double g = p->g;
    
    // Delta theta
    double dtheta = theta1 - theta2;
    double cos_dtheta = cos(dtheta);
    double sin_dtheta = sin(dtheta);
    
    // Denominator (appears in both equations)
    double denom = 2*m1 + m2 - m2*cos(2*dtheta);
    
    // Angular accelerations (UMD equations)
    double alpha1_num = -g*(2*m1 + m2)*sin(theta1) 
                       - m2*g*sin(theta1 - 2*theta2)
                       - 2*sin_dtheta*m2*(omega2*omega2*L2 + omega1*omega1*L1*cos_dtheta);
    double alpha1 = alpha1_num / (L1 * denom);
    
    double alpha2_num = 2*sin_dtheta*(omega1*omega1*L1*(m1 + m2)
                                     + g*(m1 + m2)*cos(theta1)
                                     + omega2*omega2*L2*m2*cos_dtheta);
    double alpha2 = alpha2_num / (L2 * denom);
    
    // Pack derivatives
    dydt->theta1 = omega1;
    dydt->omega1 = alpha1;
    dydt->theta2 = omega2;
    dydt->omega2 = alpha2;
}

// Classic 4th-order Runge-Kutta step
void rk4_step(State* y, double dt, const Params* p) {
    State k1, k2, k3, k4;
    State temp;
    
    // k1 = f(t, y)
    deriv(0.0, y, &k1, p);
    
    // k2 = f(t + dt/2, y + dt*k1/2)
    temp.theta1 = y->theta1 + 0.5*dt*k1.theta1;
    temp.omega1 = y->omega1 + 0.5*dt*k1.omega1;
    temp.theta2 = y->theta2 + 0.5*dt*k1.theta2;
    temp.omega2 = y->omega2 + 0.5*dt*k1.omega2;
    deriv(0.0, &temp, &k2, p);
    
    // k3 = f(t + dt/2, y + dt*k2/2)
    temp.theta1 = y->theta1 + 0.5*dt*k2.theta1;
    temp.omega1 = y->omega1 + 0.5*dt*k2.omega1;
    temp.theta2 = y->theta2 + 0.5*dt*k2.theta2;
    temp.omega2 = y->omega2 + 0.5*dt*k2.omega2;
    deriv(0.0, &temp, &k3, p);
    
    // k4 = f(t + dt, y + dt*k3)
    temp.theta1 = y->theta1 + dt*k3.theta1;
    temp.omega1 = y->omega1 + dt*k3.omega1;
    temp.theta2 = y->theta2 + dt*k3.theta2;
    temp.omega2 = y->omega2 + dt*k3.omega2;
    deriv(0.0, &temp, &k4, p);
    
    // y_new = y + dt/6 * (k1 + 2*k2 + 2*k3 + k4)
    y->theta1 += dt/6.0 * (k1.theta1 + 2*k2.theta1 + 2*k3.theta1 + k4.theta1);
    y->omega1 += dt/6.0 * (k1.omega1 + 2*k2.omega1 + 2*k3.omega1 + k4.omega1);
    y->theta2 += dt/6.0 * (k1.theta2 + 2*k2.theta2 + 2*k3.theta2 + k4.theta2);
    y->omega2 += dt/6.0 * (k1.omega2 + 2*k2.omega2 + 2*k3.omega2 + k4.omega2);
}

// Simulate from y0 for N steps
State simulate(State y0, int steps, double dt, const Params* p) {
    State y = y0;
    for (int i = 0; i < steps; i++) {
        rk4_step(&y, dt, p);
    }
    return y;
}

// Compute Cartesian position of bob 2
void get_bob2_position(const State* y, const Params* p, double* x2, double* y2) {
    double x1 = p->L1 * sin(y->theta1);
    double y1 = -p->L1 * cos(y->theta1);
    
    *x2 = x1 + p->L2 * sin(y->theta2);
    *y2 = y1 - p->L2 * cos(y->theta2);
}
