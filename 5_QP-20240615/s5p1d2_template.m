% your solution

clear; clc; close all;


run s5p1a_template.m

gammas = [0.1, 0.85, 1000];  % 三个不同的风险厌恶参数
n_g = length(gammas);


xs_QP = zeros(n, n_g);  % 用于存储每个风险级别下的最优解

% 解决三个风险敏感优化问题
for g_idx = 1 : n_g
    gamma = gammas(g_idx);
    
    cvx_begin
        variable x(n)
        % 风险敏感目标函数，负号是因为我们是在最小化问题中
        minimize(c_bar' * x + gamma * (x' * Sigma * x))  
        subject to
            G * x >= h
            x >= 0
    cvx_end
    
    xs_QP(:, g_idx) = x;  % 存储优化解
end

cost_QP = zeros(n_iter, n_g);  % 初始化成本存储矩阵

% 使用相同的1000个成本向量实现计算实际成本
for k = 1:n_iter
    c_k = c_bar + sqrtm(Sigma) * randn(n, 1);  % 生成随机成本向量
    for g_idx = 1:n_g
        cost_QP(k, g_idx) = c_k' * xs_QP(:, g_idx);  % 计算每个配置的实际成本
    end
end

% 保存成本数据
save('cost_QP.mat', 'cost_QP');
