#!/usr/bin/env python3
"""
Glass Dagger: Finite Difference Gradient Checker
Validates Enzyme-generated gradients against numerical approximations
"""

import sys
from typing import Callable


def finite_difference(func: Callable[[float], float], 
                      x: float, 
                      eps: float = 1e-5) -> float:
    """
    Compute gradient using central finite differences
    
    df/dx ≈ [f(x + ε) - f(x - ε)] / (2ε)
    
    Args:
        func: Function to differentiate
        x: Point at which to compute gradient
        eps: Step size (smaller = more accurate but numerically unstable)
    
    Returns:
        Numerical approximation of gradient
    """
    return (func(x + eps) - func(x - eps)) / (2.0 * eps)


def validate_gradient(enzyme_grad: float,
                      numerical_grad: float,
                      tolerance: float = 1e-4,
                      name: str = "unnamed") -> bool:
    """
    Compare Enzyme gradient against finite difference approximation
    
    Args:
        enzyme_grad: Gradient computed by Enzyme
        numerical_grad: Gradient from finite differences
        tolerance: Maximum acceptable absolute error
        name: Name of test for logging
    
    Returns:
        True if gradients match within tolerance
    """
    error = abs(enzyme_grad - numerical_grad)
    
    if error < tolerance:
        print(f"✅ {name}: Enzyme={enzyme_grad:.6f}, FD={numerical_grad:.6f}, "
              f"error={error:.2e}")
        return True
    else:
        print(f"❌ {name}: Enzyme={enzyme_grad:.6f}, FD={numerical_grad:.6f}, "
              f"error={error:.2e} FAILED (tolerance={tolerance})")
        return False


# Example test functions
def square(x: float) -> float:
    """f(x) = x²"""
    return x * x


def poly(x: float) -> float:
    """f(x) = 3x³ + 2x² - 5x + 7"""
    return 3.0 * x**3 + 2.0 * x**2 - 5.0 * x + 7.0


if __name__ == "__main__":
    print("=== Glass Dagger Finite Difference Checker ===\n")
    
    # These are example tests - in practice, you'd load gradients from C binary output
    # For now, we demonstrate the concept with analytical gradients
    
    tests_passed = 0
    tests_failed = 0
    
    # Test 1: Square function at x=3
    # f'(x) = 2x, f'(3) = 6
    x1 = 3.0
    analytical_grad_1 = 2.0 * x1
    numerical_grad_1 = finite_difference(square, x1)
    if validate_gradient(analytical_grad_1, numerical_grad_1, name="square(3.0)"):
        tests_passed += 1
    else:
        tests_failed += 1
    
    # Test 2: Polynomial at x=2
    # f'(x) = 9x² + 4x - 5, f'(2) = 39
    x2 = 2.0
    analytical_grad_2 = 9.0 * x2**2 + 4.0 * x2 - 5.0
    numerical_grad_2 = finite_difference(poly, x2)
    if validate_gradient(analytical_grad_2, numerical_grad_2, name="poly(2.0)"):
        tests_passed += 1
    else:
        tests_failed += 1
    
    print(f"\n=== Summary ===")
    print(f"Passed: {tests_passed}")
    print(f"Failed: {tests_failed}")
    
    sys.exit(0 if tests_failed == 0 else 1)
