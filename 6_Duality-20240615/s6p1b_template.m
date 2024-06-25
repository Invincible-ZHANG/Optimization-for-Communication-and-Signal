clear; close all; clc;

run s6p1_params_template

cvx_begin
    variable z(n_edges + 1)  
    maximize(z(end))  
    subject to
        A * z(1:end-1) == z(end) * e  
        0 <= z(1:end-1) <= d  
cvx_end


fprintf('The maximum flow from the source to the sink is: %f\n', cvx_optval);
