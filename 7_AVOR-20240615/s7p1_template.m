% clear; close all; clc;
% 
% load data_robust_regression.mat;
% 
% N = size(Y, 2);
% 
% % your solution here %


clear; close all; clc;

% 加载数据
load data_robust_regression.mat;

% 提取常规数据
t = Y(1, :);
y = Y(2, :);

% 创建设计矩阵
A = [ones(length(t), 1) t'];

% 使用最小二乘法求解
x = A \ y';
x1 = x(1);
x2 = x(2);

% 计算残差和残差范数
residuals = y' - A * x;
residual_norm = norm(residuals);

% 绘制结果
fplot(@(t) x1 + x2 * t , [min(t) max(t)], 'r-');
hold on;
plot(t, y, 'bo');
title('Linear Fit with Data Points');
xlabel('t');
ylabel('y(t)');
legend('Linear fit', 'Data points');
hold off;

% 输出结果
fprintf('Optimal z1 = %f, Optimal z2 = %f\n', x1, x2);
fprintf('Norm of the optimal residual = %f\n', residual_norm);



