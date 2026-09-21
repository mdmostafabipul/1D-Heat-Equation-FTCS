%% Stability Experiment for the 1D Heat Equation
% Compare FTCS for:
% r = 0.4  -> stable
% r = 0.5  -> stability limit
% r = 0.6  -> unstable

clear;
clc;
close all;

%% Problem parameters
alpha = 1.0;
L = 1.0;
Nx = 51;
T = 0.02;

dx = L/(Nx-1);
x = linspace(0,L,Nx)';

%% Values of r to test
r_values = [0.4, 0.5, 0.6];

%% Exact solution at final time
u_exact = exp(-alpha*pi^2*T).*sin(pi*x);

%% Initial condition
u0 = sin(pi*x);

% Add a very small high-frequency perturbation.
% This helps us clearly observe instability when r > 0.5.
perturbation = 1e-8*(-1).^(0:Nx-1)';
u0 = u0 + perturbation;

% Enforce boundary conditions
u0(1) = 0;
u0(end) = 0;

%% Storage
solutions = zeros(Nx,length(r_values));

%% Run each stability case
for k = 1:length(r_values)

    r = r_values(k);

    % From:
    % r = alpha*dt/dx^2
    dt_guess = r*dx^2/alpha;

    % Choose number of time steps
    Nt = round(T/dt_guess);

    % Actual final time for this experiment
    dt = dt_guess;
    T_actual = Nt*dt;

    fprintf('\n-----------------------------\n');
    fprintf('r = %.2f\n',r);
    fprintf('dx = %.6e\n',dx);
    fprintf('dt = %.6e\n',dt);
    fprintf('Nt = %d\n',Nt);
    fprintf('Actual final time = %.6f\n',T_actual);

    %% Initial solution
    u = u0;

    %% FTCS time stepping
    for n = 1:Nt

        u_old = u;

        u(2:end-1) = ...
            u_old(2:end-1) + ...
            r*(u_old(3:end) ...
            - 2*u_old(2:end-1) ...
            + u_old(1:end-2));

        % Boundary conditions
        u(1) = 0;
        u(end) = 0;

    end

    solutions(:,k) = u;

    fprintf('Maximum |u| = %.6e\n',max(abs(u)));

end

%% Plot all three cases
figure;

plot(x,u_exact,'k--','LineWidth',2);
hold on;

plot(x,solutions(:,1),'LineWidth',1.8);
plot(x,solutions(:,2),'LineWidth',1.8);
plot(x,solutions(:,3),'LineWidth',1.8);

xlabel('x');
ylabel('u(x,T)');

title('FTCS Stability Experiment');

legend( ...
    'Exact solution', ...
    'r = 0.4', ...
    'r = 0.5', ...
    'r = 0.6', ...
    'Location','best');

grid on;

%% Separate figures

figure;
plot(x,solutions(:,1),'LineWidth',1.8);
hold on;
plot(x,u_exact,'k--','LineWidth',1.8);
xlabel('x');
ylabel('u');
title('Stable Case: r = 0.4');
legend('Numerical','Exact');
grid on;


figure;
plot(x,solutions(:,2),'LineWidth',1.8);
hold on;
plot(x,u_exact,'k--','LineWidth',1.8);
xlabel('x');
ylabel('u');
title('Stability Boundary: r = 0.5');
legend('Numerical','Exact');
grid on;


figure;
plot(x,solutions(:,3),'LineWidth',1.8);
xlabel('x');
ylabel('u');
title('Unstable Case: r = 0.6');
grid on;