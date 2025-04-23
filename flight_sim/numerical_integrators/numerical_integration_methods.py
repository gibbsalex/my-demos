import numpy as np

def forward_euler(f, t_s, x, h_s, vmod, amod):
    """
    euler integration to approximate the solution of a differential equation

    Input Args:
        f: a function representing rhs of dx/dt = f(t,x)
        t_s: a vector in time at which the numerical solu will be approx
        x: numerical approx soln data to the diff eq, f
        h_s: step size in seconds

    Returns:
        t_s: a vector of points in time at which numerical soln. are approximated
        x: numerically approximated soln data to the diffeq, f
    """

    # forward euler num integration
    for i in range(1, len(t_s)):
        x[:, i] = x[:, i-1] + h_s * f(t_s[i-1], x[:, i-1], vmod, amod)

    return t_s, x