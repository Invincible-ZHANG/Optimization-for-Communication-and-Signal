% Clear the workspace and close all figures
clear; clc; close all;

% Run the pre-setup script to initialize variables
run s3p2e_template % Assuming this script initializes A, b, etc.

% Start defining the optimization problem
cvx_begin
    variable p(n) nonnegative; % Define the power used on each edge
    
    variable x(n);
    
%     variable t(n) nonnegative;

    % Objective: Minimize total power usage across all edges
    minimize(sum(p));
    
    % Constraints
    subject to
        % Flow conservation constraints (A matrix should represent this correctly)
        A * x == b;
        x >= 0;

        % Ensuring that the rate requirements are met on each edge
        for j = 1:n
            % We use the calculated slopes (a) and intercepts (b) from earlier to form the constraint
            % Find the minimal power required to achieve at least rate R on each edge
            % Since this involves inverse calculation from rate to power, we can use the approximations made
            % Assuming rate R requires using the last calculated interval
            approx_power = a(j, :) * x(j) + c(j, :);
            %p(j) >= max(approx_power); % Enforce that the power must be at least the approximated value
            
            approx_power <= p(j);
            
%             p >= t
            
        end
cvx_end

% Output the results
fprintf('Total minimum power used: %f Watts\n', sum(p));
