clear; clc; close all;

% Dimension of the constellation
dimension = 2;

% Set S of possible noise values
noise_levels = [-2; 0; 2];
S = combn(noise_levels, dimension)';

% Set P of possible constellation points
constellation_points = [-3; -1; 1; 3];
P = combn(constellation_points, dimension)';

for j = 1 : size(P, 2)  % over all symbols
    p_j = P(:, j);
    C = [];  % Initialize set C_j
    SC = []; % Initialize set S \ C_j
    
    % Check each noise vector n
    for n_idx = 1 : size(S, 2)
        n = S(:, n_idx);
        isValid = true; % Assume n is valid for C_j unless proven otherwise
        
        % Compare against all other constellation points p_i
        for i = 1 : size(P, 2)
            if i ~= j
                p_i = P(:, i);
                % Check the condition from equation 4.22
                if 2 * (p_i - p_j)' * (p_j + n) >= norm(p_i)^2 - norm(p_j)^2
                    isValid = false;
                    break; % n does not satisfy the condition for p_i
                end
            end
        end
        
        % Assign n to the correct set based on its validity
        if isValid
            C = [C, n];  % Add n to C_j
        else
            SC = [SC, n]; % Add n to S \ C_j
        end
    end
    
    % Print the sets for verification
    fprintf('C{%d}:\n', j);
    disp(C)
    fprintf('S\\C{%d}:\n', j);
    disp(SC)
end
