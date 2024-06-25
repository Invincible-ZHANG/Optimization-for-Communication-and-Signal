clear; % 清空工作区
close all; % 关闭所有图形窗口
clc; % 清空命令窗口

% 加载通道系数
load channel_imp_response; % 该文件包含向量 h
N = length(h);

% 构建通道矩阵 H，这是一个Toeplitz矩阵
% toeplitz 函数的参数：([第一列], [第一行])
H = toeplitz([h; zeros(N-1, 1)], [h(1); zeros(N-1, 1)]);

% 构建选择矩阵 P
P = zeros(3, 2*N-1);
P(1, N) = 1; % 对应于 k = N-1
P(2, N+1) = 1; % 对应于 k = N
P(3, N+2) = 1; % 对应于 k = N+1

h = P * H;

P = h;

% 构建 A and B 矩阵
A = H' * H;
B = P' * P;

% 计算 A 的平方根 a
% [U, S] = svd(A);
% a = U * sqrt(S) * U';
a = sqrtm(A);

% 计算 B 的平方根 b
[U, S] = svd(B);
b = U * sqrt(S) * U';

% b = sqrtm(B);
% b = C * a
C = b * inv(a);

% 计算 C^T * C
CtC = C' * C;


% 求解最大的特征值和对应的特征向量
[eigVec, eigVal] = eig(CtC);
[maxEigVal, maxIdx] = max(diag(eigVal));
opt_g = eigVec(:, maxIdx);

% 计算最优 g(k)
% g_opt = a = sqrtm(A); / norm(opt_g); % 归一化
% 
g = inv(a) * opt_g;

h_eq = H * g;
E_tot = g' * a * a * g;
E_des = g' * b * b * g;
DTE = E_des / E_tot;

% 显示结果
disp('g(k):');
disp(g);
disp('DTE:');
disp(DTE);

% 绘图展示结果
figure;
subplot(2,1,1);
stem(h_eq);
title('h_{eq}(k)');
xlabel('k');
ylabel('h_{eq}(k)');

subplot(2,1,2);
stem(g);
title('g(k)');
xlabel('k');
ylabel('g(k)');

