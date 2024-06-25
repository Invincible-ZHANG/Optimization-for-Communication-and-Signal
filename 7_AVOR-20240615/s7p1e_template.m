clear; close all; clc;

% 加载数据
load data_robust_regression.mat;  
% 提取和合并常规数据和异常值数据
t_full = [Y(1, :) Yo(1, :)];  % 合并 t 值
y_full = [Y(2, :) Yo(2, :)];  % 合并 y 值
A_full = [ones(length(t_full), 1) t_full'];  % 完整的设计矩阵

% 初始化 CVX 环境
cvx_begin
    variables x1 x2
    % 选择一个基于判断合适的 M 值
    M = 1;  % M 值可以根据数据的分布或通过试验确定
    % 最小化 Huber 惩罚的目标函数
    minimize(sum(huber(A_full * [x1; x2] - y_full', M)))
cvx_end

% 显示求解的参数
disp(['Optimal x1: ', num2str(x1)]);
disp(['Optimal x2: ', num2str(x2)]);

% 绘制数据和拟合线
figure;
plot(t_full, y_full, 'ko', 'MarkerFaceColor', 'y');  % 绘制所有数据点
hold on;
fplot(@(t) x1 + x2 * t, [min(t_full), max(t_full)], 'r-');  % 绘制使用 Huber 惩罚的拟合线
legend('Data points', 'Huber fit', 'Location', 'Best');
xlabel('t');
ylabel('y(t)');
title('Linear Fit with Huber Penalty');
grid on;  % 添加网格以便更好地观察数据
hold off;

% 输出 Huber 惩罚下的残差信息
huber_residuals = A_full * [x1; x2] - y_full';
huber_residual_norm = norm(huber_residuals, 2);
fprintf('Norm of the residuals with Huber penalty: %f\n', huber_residual_norm);
