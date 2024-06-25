clear; close all; clc;

run s6p1_params_template

cvx_begin
    variable x(n_edges)
    variable t 
    maximize(t)
    subject to
        A * x == t * e
        0 <= x <= d
cvx_end

fprintf('The maximum flow from the source to the sink is: %f\n', cvx_optval);
