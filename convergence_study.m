%% Grid Convergence Study for the 1D Heat Equation
clear; clc; close all;

alpha = 1.0;
L = 1.0;
T = 0.10;

Nx_values = [21, 41, 81, 161];
errors_inf = zeros(size(Nx_values));
errors_l2  = zeros(size(Nx_values));
dx_values  = zeros(size(Nx_values));

for k = 1:length(Nx_values)
    Nx = Nx_values(k);
    dx = L/(Nx-1);
    dx_values(k) = dx;

    % dt = O(dx^2), which keeps FTCS stable and makes
    % the time error comparable to the spatial O(dx^2) error.
    r_target = 0.40;
    dt_guess = r_target*dx^2/alpha;
    Nt = ceil(T/dt_guess);
    dt = T/Nt;

    [x, u_num] = heat_ftcs(alpha, L, Nx, T, dt);
    u_ex = exact_heat(x, T, alpha);

    errors_inf(k) = max(abs(u_num-u_ex));
    errors_l2(k) = sqrt(dx*sum((u_num-u_ex).^2));
end

fprintf(' Nx        dx          Linf Error      Observed Order\n');
fprintf('------------------------------------------------------\n');

for k = 1:length(Nx_values)
    if k == 1
        fprintf('%4d   %.4e   %.4e        ---\n', ...
            Nx_values(k), dx_values(k), errors_inf(k));
    else
        p = log(errors_inf(k-1)/errors_inf(k)) / ...
            log(dx_values(k-1)/dx_values(k));
        fprintf('%4d   %.4e   %.4e      %.4f\n', ...
            Nx_values(k), dx_values(k), errors_inf(k), p);
    end
end

figure;
loglog(dx_values, errors_inf, 'o-', 'LineWidth', 1.8);
xlabel('\Deltax');
ylabel('L_\infty error');
title('Grid Convergence of FTCS');
grid on;
set(gca, 'XDir', 'reverse');
