% Description: single faulty sensor with noise

clear; close all; clc;

load single_sensor_failure;

yn1 = y1 + n; % add noise to the measurements

m = size(A, 1);

A_pinv = pinv(A);

x = A_pinv * yn1;

R = yn1 - A * x;

R = abs(R);


[~ , index] = max (R);

fprintf('%d error sensor .\n', index);

%%

%[U S V]=svd(A);
%M = svd(A);
svd_array = zeros(1,m);
for k = 1 : m
    A_test = [A yn1];
    A_test(k,:) = [];
    A_svd = svd(A_test);
    svd_array(1,k) = A_svd(end);
end

[~ , index1] = min (svd_array);

fprintf('%d error sensor .\n', index1);

