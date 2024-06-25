% mode definition: 1 for correct detection probability, 0 for erroneous detection
mode = 1 ;
% Assumed expected values of functions of noise vector n
% Example: Assume some functions such as mean, variance etc. This is just a placeholder.
a = [1, 0, 0, 1, 1, 0];

% % Define symbols and noise vectors
% num_symbols = 16;  % 16-QAM, so there are 16 symbols
% dimension = 2;  % symbol dimension
% 
% % Hypothetical noise levels and constellation points definitions
% noise_levels = [-2; 0; 2];
% constellation_points = [-3; -1; 1; 3];
% S = combn(noise_levels, dimension)';
% P = combn(constellation_points, dimension)';

% sum = 0;

% Initialize CVX
cvx_begin
    
    variable y(6)% nonnegative % Defining probability variables for detection
        % Maximizing the probability of correct detection
    minimize(a* y);
    subject to 
    
          for i = 1: size(C,2)
                f = [1; C(1,i);C(2,i);C(1,i)^2;C(2,i)^2;C(1,i)*C(2,i)];
                y' * f >= 0;          
          end
          
          for i = 1: size(C,2)
                f = [1; SC(1,i);SC(2,i);SC(1,i)^2;SC(2,i)^2;SC(1,i)*SC(2,i)];
                y' * f >= 1;          
          end
          
          
          
          
            
cvx_end

% Output results
disp('Optimal y values (probabilities):');
disp(y);
