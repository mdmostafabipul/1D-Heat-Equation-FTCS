function [x, u] = heat_ftcs(alpha, L, Nx, T, dt)
%HEAT_FTCS Solve the 1D heat equation using the explicit FTCS scheme.
%
%   u_t = alpha*u_xx,  0 < x < L
%   u(0,t) = u(L,t) = 0
%   u(x,0) = sin(pi*x/L)
%
% Inputs:
%   alpha  diffusion coefficient
%   L      domain length
%   Nx     number of spatial grid points
%   T      final time
%   dt     time step
%
% Outputs:
%   x      spatial grid
%   u      numerical solution at time T

dx = L/(Nx-1);
x = linspace(0, L, Nx)';

Nt = round(T/dt);
dt = T/Nt;  % ensure final time is exactly T
r = alpha*dt/dx^2;

if r > 0.5
    error('FTCS unstable: alpha*dt/dx^2 = %.4f > 0.5', r);
end

% Initial condition
u = sin(pi*x/L);

% Enforce boundary conditions
u(1) = 0;
u(end) = 0;

for n = 1:Nt
    u_old = u;

    % FTCS update for interior points
    u(2:end-1) = u_old(2:end-1) + ...
        r*(u_old(3:end) - 2*u_old(2:end-1) + u_old(1:end-2));

    % Boundary conditions
    u(1) = 0;
    u(end) = 0;
end
end
