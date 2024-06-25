clear; clc; close all;

% implement your solution here

% 定义营养含量矩阵 A
A1 = [2 3 7 2 5;
     3 6 7 3 5;]
 
A2 = [5 2 8 2 4];

% 定义营养需求向量 b
b1 = [50;
     50]
 
b2 = 100

% 定义食物成本向量 c
c = [5;
     5;
     10;
     5;
     7];

% 定义食物的可用数量限制
available_amount = [4;
                    6;
                    8;
                    5;
                    5];

% 使用CVX求解
cvx_begin
    variable x(5)
    minimize(c' * x)
    subject to
        A1 * x >= b1
        A2 * x == b2
        x >= 0
        x <= available_amount
cvx_end

% 显示结果
disp('Optimal food quantities:')
disp(x)
disp('Minimum cost:')
disp(c' * x)
