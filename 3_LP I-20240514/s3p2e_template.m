run s3p2ab_template

% generating channel coefficients
randn('state', 17);
h = randn(n, 1);

% noise power
noise_power = 1;

% precision of interpolation
r = [0, 3, 6, 9, 12, 15]; % evaluation points for the power function

% initialize slopes and constants of the linear pieces
a = zeros(n, length(r) - 1); % slopes
c = zeros(n, length(r) - 1); % constants

for j = 1:n % over all edges
    for i = 1:length(r)-1 % over all intervals
        % Compute the power at both ends of the interval
        P1 = noise_power / h(j)^2 * (2^r(i) - 1);
        P2 = noise_power / h(j)^2 * (2^r(i+1) - 1);
        
        % Calculate slopes and constants
        a(j, i) = (P2 - P1) / (r(i+1) - r(i));
        c(j, i) = P1 - a(j, i) * r(i);
    end
end

% range for observing the approximated function
xp = 0 : 0.1 : 15;
truef = zeros(size(xp));
appf = zeros(size(xp));

% choose one of the power-rate functions
j = 1; % here, we chose the first one

for rate_idx = 1:length(xp)
    rate = xp(rate_idx);
    
    truef(rate_idx) = noise_power / h(j)^2 * (2^rate - 1); % calculate true function value
    % Determine which interval rate belongs to
    interval = find(r <= rate, 1, 'last');
    
    % Calculate approximated function value
    if interval < length(r)
        appf(rate_idx) = a(j, interval) * rate + c(j, interval);
    else
        appf(rate_idx) = a(j, end) * rate + c(j, end);
    end
end

plot(xp, truef, 'c', xp, appf, 'r--')
legend('True power function', 'Affine approximation');
title('Power Function Approximation');
xlabel('Rate');
ylabel('Power');
