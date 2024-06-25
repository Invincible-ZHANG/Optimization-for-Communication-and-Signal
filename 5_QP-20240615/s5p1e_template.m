% close all;
% 
% % cost plot related to risk-insensitive design (linear programming)
% figure('Name', 'LP'); 
% plot(cost_LP); hold on;
% 
% % plot lines for mean and mean +/- variance
% 
% axis([0 n_iter 7 10]);
% 
% % cost plot related to risk-sensitive design (quadratic programming)
% for i = 1 : n_g
% 
% figure('Name', ['QP, Gamma = ' num2str(gammas(i))]); 
% plot(cost_QP(:, i)); hold on;
% 
% % plot lines for mean and mean +/- variance
% 
% axis([0 n_iter 7 10]);
% 
% end


clear; clc; close all;

% 加载之前保存的成本数据
load('cost_LP.mat');  % 加载线性规划的成本数据
load('cost_QP.mat');  % 加载二次规划的成本数据

% 定义迭代次数和风险厌恶参数
n_iter = 1000;
gammas = [0.1, 0.85, 1000];

% cost plot related to risk-insensitive design (linear programming)
figure('Name', 'Cost Analysis for LP', 'NumberTitle', 'off');
plot(cost_LP, 'LineWidth', 1.5); hold on;
mean_LP = mean(cost_LP);
var_LP = var(cost_LP);
plot([1 n_iter], [mean_LP mean_LP], 'r--', 'LineWidth', 2); % Plot mean
plot([1 n_iter], [mean_LP + sqrt(var_LP) mean_LP + sqrt(var_LP)], 'k:', 'LineWidth', 1.5); % Plot mean + std deviation
plot([1 n_iter], [mean_LP - sqrt(var_LP) mean_LP - sqrt(var_LP)], 'k:', 'LineWidth', 1.5); % Plot mean - std deviation
title('Risk-Insensitive Cost (LP)');
xlabel('Iteration');
ylabel('Cost');
legend('Actual Costs', 'Mean', 'Mean \pm Std. Deviation', 'Location', 'best');
grid on;
axis tight;

% cost plot related to risk-sensitive design (quadratic programming)
for i = 1 : length(gammas)
    figure('Name', ['Cost Analysis for QP, Gamma = ' num2str(gammas(i))], 'NumberTitle', 'off');
    plot(cost_QP(:, i), 'LineWidth', 1.5); hold on;
    mean_QP = mean(cost_QP(:, i));
    var_QP = var(cost_QP(:, i));
    plot([1 n_iter], [mean_QP mean_QP], 'r--', 'LineWidth', 2); % Plot mean
    plot([1 n_iter], [mean_QP + sqrt(var_QP) mean_QP + sqrt(var_QP)], 'k:', 'LineWidth', 1.5); % Plot mean + std deviation
    plot([1 n_iter], [mean_QP - sqrt(var_QP) mean_QP - sqrt(var_QP)], 'k:', 'LineWidth', 1.5); % Plot mean - std deviation
    title(['Risk-Sensitive Cost (QP) with \gamma = ' num2str(gammas(i))]);
    xlabel('Iteration');
    ylabel('Cost');
    legend('Actual Costs', 'Mean', 'Mean \pm Std. Deviation', 'Location', 'best');
    grid on;
    axis tight;
end
