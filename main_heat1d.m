%% 1D Heat Equation using FTCS
% u_t = alpha*u_xx, 0 < x < 1
% u(0,t) = u(1,t) = 0
% u(x,0) = sin(pi*x)
% Exact solution: u(x,t) = exp(-alpha*pi^2*t)*sin(pi*x)

clear; clc; close all;

%% Parameters
alpha = 1.0;      % diffusion coefficient
L = 1.0;          % domain length
Nx = 101;          % number of spatial grid points
T = 0.10;         % final time

dx = L/(Nx-1);

% Choose dt so that r = alpha*dt/dx^2 <= 1/2
r_target = 0.40;
dt_guess = r_target*dx^2/alpha;

% Adjust dt so that the last step lands exactly at T
Nt = ceil(T/dt_guess);
dt = T/Nt;

r = alpha*dt/dx^2;

fprintf('Nx = %d\n', Nx);
fprintf('dx = %.6e\n', dx);
fprintf('Nt = %d\n', Nt);
fprintf('dt = %.6e\n', dt);
fprintf('r = alpha*dt/dx^2 = %.6f\n', r);

if r > 0.5
    error('Stability condition violated: r must be <= 0.5 for FTCS.');
end

%% Numerical solution
[x, u_num] = heat_ftcs(alpha, L, Nx, T, dt);

%% Exact solution
u_ex = exact_heat(x, T, alpha);

%% Error
err_inf = max(abs(u_num - u_ex));
err_l2  = sqrt(dx * sum((u_num - u_ex).^2));

fprintf('\nErrors at T = %.4f\n', T);
fprintf('L-infinity error = %.6e\n', err_inf);
fprintf('Discrete L2 error = %.6e\n', err_l2);

%% Plot numerical and exact solutions
figure;
plot(x, u_ex, 'LineWidth', 1.8);
hold on;
plot(x, u_num, 'o', 'MarkerSize', 4);
xlabel('x');
ylabel('u(x,T)');
title(sprintf('1D Heat Equation at T = %.2f', T));
legend('Exact solution', 'FTCS numerical solution', 'Location', 'best');
grid on;

%% Plot pointwise absolute error
figure;
plot(x, abs(u_num-u_ex), 'LineWidth', 1.8);
xlabel('x');
ylabel('|u_{num} - u_{exact}|');
title('Pointwise Absolute Error');
grid on;
