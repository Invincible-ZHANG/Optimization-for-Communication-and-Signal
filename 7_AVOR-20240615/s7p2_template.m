clear; close all; clc;


%% a
load data_l1_trend_filtering.mat;

figure(1)
plot(yti); % 绘制时间序列
title('Initial Time Series');
xlabel('Time');
ylabel('Price');



%% b

N = length(yti);  
gamma_values = linspace(1, 40, 20);  % 生成 20 个从 1 到 40 的 gamma 值
errors = zeros(size(gamma_values));
smoothness = zeros(size(gamma_values));

options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'MaxFunctionEvaluations', 5e5, 'Diagnostics', 'on');
for i = 1:length(gamma_values)
    gamma = gamma_values(i);
    [x_opt, fval] = fminunc(@(x) norm(yti - x)^2 + gamma * norm(diff(x))^2, yti, options);  
    errors(i) = norm(yti - x_opt)^2;
    smoothness(i) = sum(diff(x_opt).^2);
end

figure;
plot(errors, smoothness, '-o');
xlabel('Sum of squared errors ||x-y||^2');
ylabel('Sum of squared differences ||x_{t+1} - x_t||^2');
title('Pareto Optimal Trade-off Curve');


%% c
% 已知gamma_values, errors, smoothness数据
[minError, idx] = min(abs(errors - 2.2e6));  % 找到与2.2e6最接近的误差
%大约在 Sum of squared errors ≈2.2e6附近，
% 曲线开始从较陡的斜率变得相对平缓，
% 这表明进一步增加平滑度带来的拟合误差增加开始减少。
% 这个区域可能代表了一个较好的拟合精度与平滑度之间的折衷，特别是如果曲线在这点附近趋于水平。
selected_gamma = gamma_values(idx);  % 获取对应的gamma值

% 使用选定的gamma重新去噪时间序列
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'MaxFunctionEvaluations', 50000);
[x_opt, fval] = fminunc(@(x) sum((yti - x).^2) + selected_gamma * sum(diff(x).^2), yti, options);

% 绘制选择的gamma值下的去噪结果
figure;
plot(yti, 'b'); hold on;
plot(x_opt, 'r--');
legend('Original', 'Denoised with selected γ');
title(['Denoised Time Series with γ = ', num2str(selected_gamma)]);
xlabel('Time');
ylabel('Signal');
hold off;



%% d
% 合并两个时间序列段
yt = [yti; ytf]; 

% 选择的 γ 值
selected_gamma = 5;  

% 使用优化求解
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'MaxFunctionEvaluations', 50000);
[x_opt, fval] = fminunc(@(x) sum((yt - x).^2) + selected_gamma * sum(diff(x).^2), yt, options);

% 绘制去噪后的时间序列
figure;
plot(yt, 'b'); hold on;
plot(x_opt, 'r--');
legend('Original', 'Denoised with γ');
title('Denoised Extended Time Series');
xlabel('Time');
ylabel('Signal');
hold off;


%% e

n = length(yt);  
gamma_l1 = 5000;  

cvx_begin
    variable x(n)
    minimize(0.5 * sum_square(yt - x) + gamma_l1 * norm([x(1:n-2) - 2*x(2:n-1) + x(3:n)], 1))
cvx_end

% 绘制结果
figure;
plot(yt, 'b'); hold on;
plot(x, 'r--');
legend('Original Time Series', 'Filtered Time Series');
title('L1 Trend Filtering Results');
xlabel('Time');
ylabel('Signal Value');
hold off;


%% f

% 加载数据
load('data_l1_discussion.mat', 'x_true');


figure;
plot(x_true, 'k', 'LineWidth', 2);
hold on;
plot(x_opt, 'r--', 'LineWidth', 1.5);  %l2
plot(x, 'b-.', 'LineWidth', 1.5);  %l1
legend('True Component', 'L2 Filtered', 'L1 Filtered');
title('Comparison of True Component and Filtering Results');
xlabel('Time');
ylabel('Signal Value');
grid on;
hold off;



