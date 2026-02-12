// SPDX-License-Identifier: MIT
// Glass Dagger: Enzyme Smoke Test
// Validates that __enzyme_autodiff generates correct gradients

#include <stdio.h>
#include <math.h>

// Enzyme external declaration
// This tells the compiler that __enzyme_autodiff is a special function
// that will be handled by the Enzyme LLVM pass
extern double __enzyme_autodiff(void*, double);

// Simple function: f(x) = x²
// Expected gradient: f'(x) = 2x
double square(double x) {
    return x * x;
}

// Gradient function using Enzyme
// The Enzyme pass will replace this call with actual gradient code
double dsquare(double x) {
    return __enzyme_autodiff((void*)square, x);
}

// More complex function: f(x) = 3x³ + 2x² - 5x + 7
// Expected gradient: f'(x) = 9x² + 4x - 5
double poly(double x) {
    return 3.0 * x * x * x + 2.0 * x * x - 5.0 * x + 7.0;
}

double dpoly(double x) {
    return __enzyme_autodiff((void*)poly, x);
}

// Test helper
int test_gradient(const char* name, double x, double computed, double expected, double tolerance) {
    double error = fabs(computed - expected);
    if (error < tolerance) {
        printf("✅ %s: d/dx(%f) = %f (expected %f, error: %.2e)\n", 
               name, x, computed, expected, error);
        return 0;
    } else {
        printf("❌ %s: d/dx(%f) = %f (expected %f, error: %.2e) FAILED\n", 
               name, x, computed, expected, error);
        return 1;
    }
}

int main() {
    printf("=== Glass Dagger Enzyme Smoke Test ===\n\n");
    
    int failures = 0;
    const double tolerance = 1e-6;
    
    // Test 1: Square function at x=3
    // f(x) = x², f'(x) = 2x, f'(3) = 6
    {
        double x = 3.0;
        double grad = dsquare(x);
        double expected = 2.0 * x;
        failures += test_gradient("square", x, grad, expected, tolerance);
    }
    
    // Test 2: Square function at x=-2.5
    {
        double x = -2.5;
        double grad = dsquare(x);
        double expected = 2.0 * x;
        failures += test_gradient("square", x, grad, expected, tolerance);
    }
    
    // Test 3: Polynomial at x=2
    // f(x) = 3x³ + 2x² - 5x + 7
    // f'(x) = 9x² + 4x - 5
    // f'(2) = 9*4 + 4*2 - 5 = 36 + 8 - 5 = 39
    {
        double x = 2.0;
        double grad = dpoly(x);
        double expected = 9.0 * x * x + 4.0 * x - 5.0;
        failures += test_gradient("polynomial", x, grad, expected, tolerance);
    }
    
    // Test 4: Polynomial at x=-1
    // f'(-1) = 9*1 + 4*(-1) - 5 = 9 - 4 - 5 = 0
    {
        double x = -1.0;
        double grad = dpoly(x);
        double expected = 9.0 * x * x + 4.0 * x - 5.0;
        failures += test_gradient("polynomial", x, grad, expected, tolerance);
    }
    
    printf("\n=== Test Summary ===\n");
    if (failures == 0) {
        printf("✅ All tests passed! Enzyme toolchain is working correctly.\n");
        return 0;
    } else {
        printf("❌ %d test(s) failed. Check Enzyme installation and build pipeline.\n", failures);
        return 1;
    }
}
