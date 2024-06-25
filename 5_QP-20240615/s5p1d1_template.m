gammas = [.1, .85, 5];
n_g = length(gammas);

xs_QP = zeros(n, n_g);

for g_idx = 1 : n_g
    gamma = gammas(g_idx);
    
    cvx_begin
    
    % your solution
    
    cvx_end
    
    
    xs_QP(:, g_idx) = x_QP;
    
end

cost_QP = zeros(n_iter, n_g);