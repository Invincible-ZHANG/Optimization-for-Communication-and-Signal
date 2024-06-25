clear; clc; close all;

cvx_quiet(true);

run s3p2ab_template
 
cvx_begin
    variable r(8)
    minimize(c' * r)
    subject to
        A * r == b
        r >= 0
cvx_end
