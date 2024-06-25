clear; close all; clc;

load data_problem_1.mat;

n      = length(c_bar);
n_iter = 1000;


% LP
cvx_quiet true;
cvx_begin

    variable x_LP(n)  % 定义决策变量 x
    minimize(c_bar' * x_LP)  % 最小化目标函数
    subject to
        G * x_LP >= h  % 线性约束
        x_LP >= 0      % 非负性约束

cvx_end



disp(x_LP);



%% 
% QP
% run s5p1d1


% comparison between LP and QP
cost_LP = zeros(n_iter, 1);

for k = 1 : n_iter
    
    c = c_bar + sqrtm(Sigma) * randn(n,1);
    
    % expected cost with LP design
    cost_LP(k,1) = c' * x_LP;
    
%     run s5p1d2
    
end


save('cost_LP.mat', 'cost_LP');
% run s5p1e