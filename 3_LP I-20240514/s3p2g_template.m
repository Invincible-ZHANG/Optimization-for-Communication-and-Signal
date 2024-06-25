% clear; clc; close all;

cvx_quiet(true);

run s3p2e_template

cvx_begin
%     variable p(n) nonnegative; % Power on each edge
    
    variable x(n);
    
    variable t(n) nonnegative;

    % Objective function
    minimize(sum(t));

    % Constraints
    subject to
        A * x <= b; % Example constraint, adjust based on actual network model
        x >= 0;
        
%         p = noise_power ./ (h.^2) .* (2.^(r) - 1) ./ p)

        % Ensuring that the rate requirements are met on each edge
        for j = 1:n
            % We use the calculated slopes (a) and intercepts (b) from earlier to form the constraint
            % Find the minimal power required to achieve at least rate R on each edge
            % Since this involves inverse calculation from rate to power, we can use the approximations made
            % Assuming rate R requires using the last calculated interval
            %approx_power = a(j, :) * rate + c(j, :);
            true_value = noise_power / h(j)^2 * (2^x(j) - 1)
            
            %p(j) >= max(approx_power); % Enforce that the power must be at least the approximated value
            
            true_value <= t(j);
            
%             p >= t
            
        end



cvx_end

% print the result here %
% Print the results
fprintf('Total minimum power used: %f Watts\n', sum(t));