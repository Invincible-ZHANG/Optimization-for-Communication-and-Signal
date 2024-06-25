clear; clc; close all;

cvx_quiet(true);

run s3p2ab_template

cvx_begin
    variable r(8)
    minimize(c' * r)
    subject to
        A * r == b
        0 <= r <= 6
cvx_end