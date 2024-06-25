clear; clc; close all;

% Dimension of matrices
n = 3;

% Generate two random positive semidefinite matrices U and V
U = rand(n);
U = U * U'; % U is now positive semidefinite
V = rand(n);
V = V * V'; % V is now positive semidefinite

% Interval and step for evaluation
step = 0.01;
start = 0;
stop = 1;
t = start : step : stop;

% Initialize f for storing function values
f = zeros(length(t), 1);

% Evaluate the function f(X) = tr(X^-1) along the line segment
for i = 1:length(t)
    X = U + t(i) * V;
    f(i) = trace(inv(X));
end

% Plot the function
figure;
plot(t, f, 'LineWidth', 2);
title('Function f(X(t)) = tr(X^{-1})');
xlabel('t');
ylabel('f(X(t))');
grid on;
