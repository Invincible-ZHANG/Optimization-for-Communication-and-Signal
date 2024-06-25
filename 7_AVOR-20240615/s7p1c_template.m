%% c

clear; close all; clc;

% 加载数据
load data_robust_regression.mat;  % 假设 data_robust_regression.mat 包含 Y 和 Yo

% 合并常规数据和异常值数据
t_full = [Y(1, :) Yo(1, :)];  % 合并 t 值
y_full = [Y(2, :) Yo(2, :)];  % 合并 y 值

% 创建设计矩阵
A_full = [ones(length(t_full), 1) t_full'];  % 完整的设计矩阵

% 使用所有数据求解最小二乘问题
x_full = A_full \ y_full';  

% 计算残差和残差的范数
residuals_full = y_full' - A_full * x_full;  % 计算残差
residual_norm_full = norm(residuals_full);  % 计算残差的范数

% 绘制所有数据点和最优拟合线
figure;
plot(t_full, y_full, 'ko', 'MarkerFaceColor', 'y');  % 绘制所有数据点
hold on;
fplot(@(t) x_full(1) + x_full(2) * t, [min(t_full), max(t_full)], 'r-');  % 绘制最优拟合线
legend('Data points', 'Linear fit');
xlabel('t');
ylabel('y(t)');
title('Linear Fit with All Data Points');
hold off;

% 输出结果
fprintf('Optimal x1 = %f, Optimal x2 = %f\n', x_full(1), x_full(2));
fprintf('Norm of the optimal residual = %f\n', residual_norm_full);

