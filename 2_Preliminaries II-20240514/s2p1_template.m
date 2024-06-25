clear; clc; close all;

% implement your solution here

c = [2 -3 1];
G = [1 1 -1; -1 0 0; 0 -1 0; 0 0 -1];
h = [7; 0; 0; 0];
A = [1 4 2; -2 1 4];
b = [3; 1];
cvx_begin
    variable x(3);
    minimize (c*x);
    subject to
        G*x <= h;
        A*x == b;
cvx_end
