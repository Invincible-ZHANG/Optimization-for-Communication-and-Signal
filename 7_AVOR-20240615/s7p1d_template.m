    %% d

clear; close all; clc;
M = 2;
u = linspace(-5, 5, 400);
phi_hub = zeros(size(u));
phi_ach = zeros(size(u));

for i = 1:length(u)
    if abs(u(i)) <= M
        phi_hub(i) = u(i)^2 ;
        phi_ach(i) = u(i)^2 ;
    else
        phi_hub(i) = M * (2 * abs(u(i)) - M);
        phi_ach(i) = M^2 ;
    end
end

figure;
plot(u, phi_hub, 'b-', 'LineWidth', 2);
hold on;
plot(u, phi_ach, 'r--', 'LineWidth', 2);
legend({'\phi_{hub}(u)', '\phi_{nch}(u)'}, 'Location', 'northwest');
xlabel('u');
ylabel('Penalty Value');
title('Comparison of Huber Penalty Functions');
grid on;
