# Project 1: Numerical Solution of the 1D Heat Equation

## Goal
Solve the one-dimensional heat equation using the explicit Forward-Time Central-Space (FTCS) finite-difference method and compare the numerical result with an exact solution.

## Model Problem

\[
u_t = \alpha u_{xx}, \qquad 0<x<1,\ t>0,
\]

with boundary conditions

\[
u(0,t)=u(1,t)=0,
\]

and initial condition

\[
u(x,0)=\sin(\pi x).
\]

For this problem, the exact solution is

\[
u(x,t)=e^{-\alpha\pi^2t}\sin(\pi x).
\]

## Numerical Method

Let

\[
x_i=i\Delta x,\qquad t^n=n\Delta t.
\]

The FTCS approximation is

\[
\frac{u_i^{n+1}-u_i^n}{\Delta t}
=
\alpha
\frac{u_{i+1}^n-2u_i^n+u_{i-1}^n}{(\Delta x)^2}.
\]

Therefore,

\[
u_i^{n+1}
=
u_i^n
+
r\left(u_{i+1}^n-2u_i^n+u_{i-1}^n\right),
\]

where

\[
r=\frac{\alpha\Delta t}{(\Delta x)^2}.
\]

For the explicit FTCS method, the stability requirement is

\[
r\le \frac12.
\]

## Files

- `main_heat1d.m` — runs one simulation and compares numerical and exact solutions.
- `heat_ftcs.m` — FTCS solver.
- `exact_heat.m` — exact solution.
- `convergence_study.m` — grid-refinement and observed-order study.

## Day 1

1. Run `main_heat1d.m`.
2. Check that `r <= 0.5`.
3. Look at the exact-vs-numerical plot.
4. Look at the pointwise error.
5. Record the printed L-infinity and L2 errors.
6. Change `Nx` from 51 to 101 and compare the error.

## Day 2

Run `convergence_study.m` and verify that the observed order approaches approximately 2 when `dt = O(dx^2)`.

## What to Save for Your Portfolio

- Numerical-vs-exact solution plot
- Error plot
- Convergence plot
- Error table
- Short explanation of the FTCS scheme and stability condition

## CV wording after completion

**Numerical Solution of the One-Dimensional Heat Equation**
- Implemented an explicit finite-difference solver for a parabolic PDE in MATLAB.
- Verified the numerical solution against an analytical solution and quantified L2 and L-infinity errors.
- Performed grid-refinement and convergence studies and investigated the CFL-type stability restriction of the FTCS method.
