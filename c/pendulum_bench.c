// SPDX-License-Identifier: MIT
// Glass Dagger M3: Benchmark Binary with JSON Output

#include "double_pendulum.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <stdbool.h>

// Enzyme declaration
extern double __enzyme_autodiff(void*, double, double);

// Fixed initial angles
#define THETA1_0 (M_PI / 4.0)
#define THETA2_0 (M_PI / 6.0)

// Target position
#define X2_TARGET 0.0
#define Y2_TARGET -1.8

// Default simulation parameters
#define DEFAULT_STEPS 1000
#define DEFAULT_DT 0.001
#define DEFAULT_ITERS 200
#define DEFAULT_LR 0.02

static Params params = { .m1 = 1.0, .m2 = 1.0, .L1 = 1.0, .L2 = 1.0, .g = 9.81 };

// Helper: compute derivatives (inlined)
static inline void compute_deriv(double theta1, double omega1, double theta2, double omega2,
                                 double* dtheta1, double* domega1, double* dtheta2, double* domega2) {
    double dtheta = theta1 - theta2;
    double cos_dtheta = cos(dtheta);
    double sin_dtheta = sin(dtheta);
    double denom = 2*params.m1 + params.m2 - params.m2*cos(2*dtheta);
    
    double alpha1 = (-params.g*(2*params.m1 + params.m2)*sin(theta1) 
                     - params.m2*params.g*sin(theta1 - 2*theta2)
                     - 2*sin_dtheta*params.m2*(omega2*omega2*params.L2 + omega1*omega1*params.L1*cos_dtheta)) / (params.L1 * denom);
    
    double alpha2 = (2*sin_dtheta*(omega1*omega1*params.L1*(params.m1 + params.m2)
                                   + params.g*(params.m1 + params.m2)*cos(theta1)
                                   + omega2*omega2*params.L2*params.m2*cos_dtheta)) / (params.L2 * denom);
    
    *dtheta1 = omega1; *domega1 = alpha1;
    *dtheta2 = omega2; *domega2 = alpha2;
}

double loss_omega1(double omega1_0, double omega2_0, int steps, double dt) {
    double t1 = THETA1_0, w1 = omega1_0, t2 = THETA2_0, w2 = omega2_0;
    for (int i = 0; i < steps; i++) {
        double k1t1, k1w1, k1t2, k1w2, k2t1, k2w1, k2t2, k2w2, k3t1, k3w1, k3t2, k3w2, k4t1, k4w1, k4t2, k4w2;
        compute_deriv(t1, w1, t2, w2, &k1t1, &k1w1, &k1t2, &k1w2);
        compute_deriv(t1+0.5*dt*k1t1, w1+0.5*dt*k1w1, t2+0.5*dt*k1t2, w2+0.5*dt*k1w2, &k2t1, &k2w1, &k2t2, &k2w2);
        compute_deriv(t1+0.5*dt*k2t1, w1+0.5*dt*k2w1, t2+0.5*dt*k2t2, w2+0.5*dt*k2w2, &k3t1, &k3w1, &k3t2, &k3w2);
        compute_deriv(t1+dt*k3t1, w1+dt*k3w1, t2+dt*k3t2, w2+dt*k3w2, &k4t1, &k4w1, &k4t2, &k4w2);
        t1 += dt/6.0*(k1t1+2*k2t1+2*k3t1+k4t1); w1 += dt/6.0*(k1w1+2*k2w1+2*k3w1+k4w1);
        t2 += dt/6.0*(k1t2+2*k2t2+2*k3t2+k4t2); w2 += dt/6.0*(k1w2+2*k2w2+2*k3w2+k4w2);
    }
    double x2 = params.L1*sin(t1) + params.L2*sin(t2), y2 = -params.L1*cos(t1) - params.L2*cos(t2);
    return (x2-X2_TARGET)*(x2-X2_TARGET) + (y2-Y2_TARGET)*(y2-Y2_TARGET) + 1e-3*(omega1_0*omega1_0 + omega2_0*omega2_0);
}

double loss_omega2(double omega2_0, double omega1_0, int steps, double dt) {
    return loss_omega1(omega1_0, omega2_0, steps, dt);
}

double dloss_domega1(double omega1_0, double omega2_0, int steps, double dt) {
    return __enzyme_autodiff((void*)loss_omega1, omega1_0, omega2_0, steps, dt);
}

double dloss_domega2(double omega1_0, double omega2_0, int steps, double dt) {
    return __enzyme_autodiff((void*)loss_omega2, omega2_0, omega1_0, steps, dt);
}

int main(int argc, char** argv) {
    bool use_json = false;
    int iters = DEFAULT_ITERS, steps = DEFAULT_STEPS;
    double dt = DEFAULT_DT, lr = DEFAULT_LR;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--json") == 0) use_json = true;
        if (strcmp(argv[i], "--iters") == 0 && i+1 < argc) iters = atoi(argv[++i]);
        if (strcmp(argv[i], "--steps") == 0 && i+1 < argc) steps = atoi(argv[++i]);
    }

    double w1 = 0.0, w2 = 0.0;
    double initial_loss = loss_omega1(w1, w2, steps, dt);

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < iters; i++) {
        double g1 = dloss_domega1(w1, w2, steps, dt);
        double g2 = dloss_domega2(w1, w2, steps, dt);
        w1 -= lr * g1; w2 -= lr * g2;
    }

    clock_gettime(CLOCK_MONOTONIC, &end);
    double final_loss = loss_omega1(w1, w2, steps, dt);
    double total_ms = (end.tv_sec - start.tv_sec) * 1000.0 + (end.tv_nsec - start.tv_nsec) / 1000000.0;

    // Final distance
    State y0 = {THETA1_0, w1, THETA2_0, w2};
    State yT = simulate(y0, steps, dt, &params);
    double fx2, fy2; get_bob2_position(&yT, &params, &fx2, &fy2);
    double dist = sqrt((fx2-X2_TARGET)*(fx2-X2_TARGET) + (fy2-Y2_TARGET)*(fy2-Y2_TARGET));

    if (use_json) {
        printf("{\n");
        printf("  \"engine\": \"enzyme_llvm\",\n");
        printf("  \"config\": { \"steps\": %d, \"dt\": %f, \"iters\": %d, \"dtype\": \"float64\" },\n", steps, dt, iters);
        printf("  \"results\": {\n");
        printf("    \"loss_start\": %.10f,\n", initial_loss);
        printf("    \"loss_end\": %.10f,\n", final_loss);
        printf("    \"dist_end_cm\": %.4f,\n", dist * 100.0);
        printf("    \"time_total_ms\": %.4f,\n", total_ms);
        printf("    \"time_per_iter_ms\": %.4f\n", total_ms / iters);
        printf("  }\n}\n");
    } else {
        printf("Enzyme Optimization: Loss %.6f -> %.6f, Time: %.2f ms\n", initial_loss, final_loss, total_ms);
    }
    return 0;
}
