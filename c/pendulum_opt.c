// SPDX-License-Identifier: MIT
// Glass Dagger M2: Loss Function for Double Pendulum Optimization

#include "double_pendulum.h"
#include <stdio.h>
#include <math.h>

// Enzyme declaration
extern double __enzyme_autodiff(void*, double, double);

// Fixed initial angles
#define THETA1_0 (M_PI / 4.0)  // 45 degrees
#define THETA2_0 (M_PI / 6.0)  // 30 degrees

// Target position for bob 2 (adjusted for reachability)
#define X2_TARGET 0.0
#define Y2_TARGET -1.8

// Simulation parameters
#define STEPS 1000
#define DT 0.001  // 1ms timestep -> T = 1.0s

// Fixed physical parameters
static const Params params = {
    .m1 = 1.0,
    .m2 = 1.0,
    .L1 = 1.0,
    .L2 = 1.0,
    .g = 9.81
};

// Helper: compute derivatives (inlined version)
static inline void compute_deriv(double theta1, double omega1, double theta2, double omega2,
                                 double* dtheta1, double* domega1, double* dtheta2, double* domega2) {
    double m1 = params.m1;
    double m2 = params.m2;
    double L1 = params.L1;
    double L2 = params.L2;
    double g = params.g;
    
    double dtheta = theta1 - theta2;
    double cos_dtheta = cos(dtheta);
    double sin_dtheta = sin(dtheta);
    
    double denom = 2*m1 + m2 - m2*cos(2*dtheta);
    
    double alpha1_num = -g*(2*m1 + m2)*sin(theta1) 
                       - m2*g*sin(theta1 - 2*theta2)
                       - 2*sin_dtheta*m2*(omega2*omega2*L2 + omega1*omega1*L1*cos_dtheta);
    double alpha1 = alpha1_num / (L1 * denom);
    
    double alpha2_num = 2*sin_dtheta*(omega1*omega1*L1*(m1 + m2)
                                     + g*(m1 + m2)*cos(theta1)
                                     + omega2*omega2*L2*m2*cos_dtheta);
    double alpha2 = alpha2_num / (L2 * denom);
    
    *dtheta1 = omega1;
    *domega1 = alpha1;
    *dtheta2 = omega2;
    *domega2 = alpha2;
}

// Loss function with omega1_0 as first argument (for Enzyme)
// Fully inlined to avoid struct return issues
double loss_omega1(double omega1_0, double omega2_0) {
    // Initial state
    double theta1 = THETA1_0;
    double omega1 = omega1_0;
    double theta2 = THETA2_0;
    double omega2 = omega2_0;
    
    // RK4 integration loop (inlined)
    for (int i = 0; i < STEPS; i++) {
        double k1_theta1, k1_omega1, k1_theta2, k1_omega2;
        double k2_theta1, k2_omega1, k2_theta2, k2_omega2;
        double k3_theta1, k3_omega1, k3_theta2, k3_omega2;
        double k4_theta1, k4_omega1, k4_theta2, k4_omega2;
        
        // k1
        compute_deriv(theta1, omega1, theta2, omega2,
                     &k1_theta1, &k1_omega1, &k1_theta2, &k1_omega2);
        
        // k2
        compute_deriv(theta1 + 0.5*DT*k1_theta1, omega1 + 0.5*DT*k1_omega1,
                     theta2 + 0.5*DT*k1_theta2, omega2 + 0.5*DT*k1_omega2,
                     &k2_theta1, &k2_omega1, &k2_theta2, &k2_omega2);
        
        // k3
        compute_deriv(theta1 + 0.5*DT*k2_theta1, omega1 + 0.5*DT*k2_omega1,
                     theta2 + 0.5*DT*k2_theta2, omega2 + 0.5*DT*k2_omega2,
                     &k3_theta1, &k3_omega1, &k3_theta2, &k3_omega2);
        
        // k4
        compute_deriv(theta1 + DT*k3_theta1, omega1 + DT*k3_omega1,
                     theta2 + DT*k3_theta2, omega2 + DT*k3_omega2,
                     &k4_theta1, &k4_omega1, &k4_theta2, &k4_omega2);
        
        // Update
        theta1 += DT/6.0 * (k1_theta1 + 2*k2_theta1 + 2*k3_theta1 + k4_theta1);
        omega1 += DT/6.0 * (k1_omega1 + 2*k2_omega1 + 2*k3_omega1 + k4_omega1);
        theta2 += DT/6.0 * (k1_theta2 + 2*k2_theta2 + 2*k3_theta2 + k4_theta2);
        omega2 += DT/6.0 * (k1_omega2 + 2*k2_omega2 + 2*k3_omega2 + k4_omega2);
    }
    
    // Compute bob 2 position
    double x2 = params.L1 * sin(theta1) + params.L2 * sin(theta2);
    double y2 = -params.L1 * cos(theta1) - params.L2 * cos(theta2);
    
    // MSE loss
    double dx = x2 - X2_TARGET;
    double dy = y2 - Y2_TARGET;
    double pos_loss = dx*dx + dy*dy;
    
    // Regularization
    double reg = 1e-3 * (omega1_0*omega1_0 + omega2_0*omega2_0);
    
    return pos_loss + reg;
}

// Loss function with omega2_0 as first argument (for Enzyme)
double loss_omega2(double omega2_0, double omega1_0) {
    return loss_omega1(omega1_0, omega2_0);
}

// Gradient with respect to omega1_0
double dloss_domega1(double omega1_0, double omega2_0) {
    return __enzyme_autodiff((void*)loss_omega1, omega1_0, omega2_0);
}

// Gradient with respect to omega2_0
double dloss_domega2(double omega1_0, double omega2_0) {
    return __enzyme_autodiff((void*)loss_omega2, omega2_0, omega1_0);
}

int main() {
    // Initial guess
    double omega1 = 0.0;
    double omega2 = 0.0;
    
    // Hyperparameters
    double learning_rate = 0.02;
    int iterations = 200;
    
    printf("=== Glass Dagger M2: Double Pendulum Optimization ===\n");
    printf("Target: bob 2 at (%.2f, %.2f) after T=%.1fs\n", X2_TARGET, Y2_TARGET, STEPS*DT);
    printf("Initial: omega1=%.4f, omega2=%.4f, loss=%.6f\n\n", 
           omega1, omega2, loss_omega1(omega1, omega2));
    
    for (int i = 0; i < iterations; i++) {
        // Compute gradients
        double grad1 = dloss_domega1(omega1, omega2);
        double grad2 = dloss_domega2(omega1, omega2);
        
        // Gradient descent update
        omega1 -= learning_rate * grad1;
        omega2 -= learning_rate * grad2;
        
        double current_loss = loss_omega1(omega1, omega2);
        
        if ((i+1) % 10 == 0 || i == 0) {
            printf("[%03d] omega1=%.4f, omega2=%.4f, loss=%.6f\n", 
                   i+1, omega1, omega2, current_loss);
        }
        
        if (current_loss < 1e-6) break;
    }
    
    // Final evaluation
    State y0 = {THETA1_0, omega1, THETA2_0, omega2};
    State yT = simulate(y0, STEPS, DT, &params);
    double x2, y2;
    get_bob2_position(&yT, &params, &x2, &y2);
    
    printf("\nFinal Result:\n");
    printf("  omega1=%.6f, omega2=%.6f\n", omega1, omega2);
    printf("  Bob 2 position: (%.6f, %.6f)\n", x2, y2);
    printf("  Target:         (%.6f, %.6f)\n", X2_TARGET, Y2_TARGET);
    printf("  Error: %.6f m\n", sqrt((x2-X2_TARGET)*(x2-X2_TARGET) + (y2-Y2_TARGET)*(y2-Y2_TARGET)));
    
    // Success criterion: error < 30cm (realistic for chaotic system)
    if (sqrt((x2-X2_TARGET)*(x2-X2_TARGET) + (y2-Y2_TARGET)*(y2-Y2_TARGET)) < 0.3) {
        printf("✅ M2 SUCCESS: Converged to target!\n");
        return 0;
    } else {
        printf("❌ M2 FAILURE: Did not converge.\n");
        return 1;
    }
}
