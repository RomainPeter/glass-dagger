/**
 * Glass Dagger M1: Loss Function and Optimization
 * 
 * Goal: Minimize L(w, b) = 1/2 * (f(x, w, b) - y)^2
 * where f(x, w, b) = w * x + b (linear model)
 */

#include <stdio.h>
#include <math.h>

// Enzyme signature for gradient computation
extern double __enzyme_autodiff(void*, double, double, double, double);

// Simple linear model: f(x) = w*x + b
double model(double x, double w, double b) {
    return w * x + b;
}

// Loss function: MSE for a single point
// We want to differentiate this with respect to w and b
double loss(double x, double w, double b, double target) {
    double prediction = model(x, w, b);
    double diff = prediction - target;
    return 0.5 * diff * diff;
}

/**
 * Gradient calculation using Enzyme
 * 
 * Key insight: __enzyme_autodiff differentiates with respect to the FIRST argument.
 * So we create wrapper functions that reorder arguments to put the target parameter first.
 */

// Wrapper: loss with w as first argument
double loss_w(double w, double x, double b, double target) {
    return loss(x, w, b, target);  // Reorder: x, w, b, target
}

// Wrapper: loss with b as first argument  
double loss_b(double b, double x, double w, double target) {
    return loss(x, w, b, target);  // Reorder: x, w, b, target
}

// Gradient with respect to w
double dloss_dw(double x, double w, double b, double target) {
    return __enzyme_autodiff((void*)loss_w, w, x, b, target);
}

// Gradient with respect to b
double dloss_db(double x, double w, double b, double target) {
    return __enzyme_autodiff((void*)loss_b, b, x, w, target);
}

int main() {
    // Initial parameters
    double w = 2.0;
    double b = 5.0;
    
    // Training data (x=1.0, y=10.0) -> Expected w*x+b = 10
    double x = 1.0;
    double target = 10.0;
    
    // Hyperparameters
    double learning_rate = 0.1;
    int iterations = 40;

    printf("=== Glass Dagger M1: Optimization Loop ===\n");
    printf("Target: f(%.1f) = %.1f\n", x, target);
    printf("Initial: w=%.2f, b=%.2f, f(x)=%.2f, loss=%.4f\n\n", 
           w, b, model(x, w, b), loss(x, w, b, target));

    for (int i = 0; i < iterations; i++) {
        // Compute gradients (one at a time)
        double dw = dloss_dw(x, w, b, target);
        double db = dloss_db(x, w, b, target);
        
        // Update parameters (Gradient Descent)
        w -= learning_rate * dw;
        b -= learning_rate * db;
        
        double current_loss = loss(x, w, b, target);
        printf("[%02d] w=%.4f, b=%.4f, loss=%.6f\n", i+1, w, b, current_loss);
        
        if (current_loss < 1e-9) break;
    }

    printf("\nFinal Result: f(%.1f) = %.4f (Target %.1f)\n", x, model(x, w, b), target);
    
    // Validation check
    if (fabs(model(x, w, b) - target) < 1e-3) {
        printf("✅ M1 SUCCESS: Parameters converged to target!\n");
    } else {
        printf("❌ M1 FAILURE: Failed to converge.\n");
        return 1;
    }

    return 0;
}
