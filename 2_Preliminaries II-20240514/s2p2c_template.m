clear; clc; close all;

% Dimension of A and b
n = 2;

% Generate all vectors x of dimension d with coordinates between -range and +range
step  = 1;
range = 20; 
interval = -range:step:range; % the window of x to be observed regarding the set 'C'

% Generate all combinations in the defined range
x = combn(interval, n); x = x';



% Generate A, b and c (random):

B = -5 + 10 * rand(n);   % Generate a random matrix B with elements in [-5, 5]
A = 0.5 * (B + B');      % Make A symmetric
b = -5 + 10 * rand(n, 1); % Generate random vector b
c = -5 + 10 * rand;       % Generate random scalar c

% Observe the nature (positive-definite, ...) of the resulting matrix A.
eigenvalues = eig(A);   %Obtain the eigenvalues of the random matrix A.

if all(eigenvalues >= 0)
    disp('A is positive semi-definite.');
else
    disp('A is indefinite.');
end

% Evaluate the quadratic form for each combination of x
f_values = zeros(1, size(x, 2)); % Initialize f_values array
for i = 1:size(x, 2)
    xi = x(:, i); % Extract each column
    f_values(i) = xi' * A * xi + b' * xi + c; % Correctly compute the quadratic form
end


% Determine if each point is inside the set C
inside_C = f_values <= 0; % Create a logical array where 1 indicates the point is inside C

% Prepare the data for plotting
f_values_plot = double(reshape(inside_C, length(interval), length(interval))); % Reshape and convert to +1/-1 for plotting

% Plot the set C using the sign function
figure();
surf(interval, interval, f_values_plot);
xlabel('x1');
ylabel('x2');
zlabel('Set C');
title('Visualization of the Set C');