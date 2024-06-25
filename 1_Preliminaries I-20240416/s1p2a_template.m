% single faulty sensor without noise

clear; close all; clc;

load single_sensor_failure;

m = size(A, 1);

for k = 1 : m
    
%%%%%%%%%%

% Here: check if sensor k is the broken one.A_test = A;
    %disp(k);
    A_test = [A y1];
    A_test_copy = A_test;
    %disp(A_test);
    A_test(k,:) = [];
    %disp(A_test);
    %A(k,:) = [];

    if (rank([A_test]) ~= rank(A))
        fprintf('%d sensor correct\n', k);
    else
        fprintf('%d sensor error\n', k);
    end

%%%%%%%%%%
    
end
