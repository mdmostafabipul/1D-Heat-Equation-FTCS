# Numerical Solution of the 1D Heat Equation Using FTCS

This project studies the numerical solution of the one-dimensional heat
equation using the Forward-Time Central-Space (FTCS) finite difference
method in MATLAB.

## Main Results

- Compared the FTCS numerical solution with an exact solution.
- Performed a grid-refinement study.
- Observed approximately second-order convergence.
- Investigated the FTCS stability condition.
- Demonstrated numerical instability for r > 1/2.

## Model Problem

u_t = alpha u_xx,  0 < x < 1

with homogeneous Dirichlet boundary conditions and initial condition

u(x,0) = sin(pi x).

## Software

MATLAB
