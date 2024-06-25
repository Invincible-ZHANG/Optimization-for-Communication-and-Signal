%% 0.1
clc;
clear;
a = 1;
b = 2;
c = a + b;
d = cos(a);
e = 3 + 4i;



%% 0.2
f = [1 2 3 4 5];
g = 1:5;
h = [3,4,5];
i = [3;4;5];
J = [1,2;3,4];
k = 0:0.1:5;
M = [1 2; 3 4] + [1 1; 1 1] * 1i;
n = 3;


%% 0.3
t = sin(2 * pi * k);
plot (k, t);
surf(J);
surf(t'*t);

% help cos;
% doc plot;
% doc size;

%% 0.4
diag(J);
diag(1:5);

A = rand(7);
% A(2,3);
% A(1:3,5:end);





































