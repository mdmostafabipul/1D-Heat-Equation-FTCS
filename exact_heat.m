function u = exact_heat(x, t, alpha)
%EXACT_HEAT Exact solution for the chosen heat-equation test problem.
%
% PDE:
%   u_t = alpha*u_xx, 0 < x < 1
%
% BC:
%   u(0,t) = u(1,t) = 0
%
% IC:
%   u(x,0) = sin(pi*x)
%
% Exact:
%   u(x,t) = exp(-alpha*pi^2*t)*sin(pi*x)

u = exp(-alpha*pi^2*t).*sin(pi*x);
end
