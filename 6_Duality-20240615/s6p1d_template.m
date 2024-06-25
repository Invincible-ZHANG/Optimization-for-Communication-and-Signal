clear; close all; clc;

run s6p1_params_template % Load the network parameters

cvx_begin
    variable mu1(n_nodes)
    variable nu_plus(n_edges)
    variable nu_minus(n_edges)
    minimize(nu_plus' * d)  % Make sure the expression is scalar and logically correct
    subject to
        A' * mu1 + nu_plus - nu_minus == 0  % Check the correctness of A and its transpose
        e' * mu1 == -1
        nu_plus >= 0
        nu_minus >= 0
cvx_end




disp(['The optimal value of the dual problem is: ', num2str(cvx_optval)]);
