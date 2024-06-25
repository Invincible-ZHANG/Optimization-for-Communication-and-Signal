%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Session 10 : Compressed sensing vs. Matrix completion %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all; clc;

% n1 : size of the frequency spectrum
n1 = 40;

% n2 : number of CRs
n2 = 5;

% k : sparsity of the spectrum
k = 5;

% m : number of measurements at each CR
m = 14;

n_loops = 20;

orig_carriers = zeros(n1, n_loops);
cs_powers = zeros(n1, n_loops);
mc_powers = zeros(n1, n_loops);

tic;

for l = 1 : n_loops
    
    disp(['iteration no ' num2str(l)]);
    
    % f : spectrum
    f = zeros(n1,1);
    busy_subcarriers = randperm(n1);
    f(busy_subcarriers(1:k)) = 100 * randn(k,1);
    
    % orig. signal
    orig_carriers(f~=0, l) = 1;
    
    % Hi : channel matrices stored in H = [H1 ... Hn2]
    H = zeros(n1,n1*n2);
    
    for i = 1:n2
        
        h = 1 + 0.1 * randn(n1, 1);
        H(:, (i - 1) * n1 + 1 : i * n1) = diag(h);
        
    end
    
    % N : noise matrix N = [n1 ... nn2]
    N = randn(n1, n2);
    
    
    % Received frequency matrix Fr
    Fr = H * kron(eye(n2),f) + N;
    
    % Received time matrix Tr
    Tr = ifft(Fr);
    
    
    %% spectrum sensing
    
    %%% Compressed sensing approach %%%
    
    % <<< fill out here >>>

    
    %%% Matrix completion approach %%%
    
    % <<< fill out here >>>

    
end


%% evaluation

n_threshs = 1000;

% thresholds
min_th = sqrt(min(min([cs_powers, mc_powers])));
max_th = sqrt(max(max([cs_powers, mc_powers])));

thresholds = min_th : (max_th - min_th) / n_threshs : max_th;
thresholds = thresholds(1:end-1);

% probabilities of detection
cs_pds = zeros(n_threshs, 1);
mc_pds = zeros(n_threshs, 1);

% probabilities of false alarm
cs_pfas = zeros(n_threshs, 1);
mc_pfas = zeros(n_threshs, 1);


for th_idx = 1 : n_threshs
    th = thresholds(th_idx)^2;

    cs_carriers = zeros(n1, n_loops);
    mc_carriers = zeros(n1, n_loops);
    
    for l = 1 : n_loops
    
        cs_carriers(cs_powers(:, l) >= th, l) = 1;
        mc_carriers(mc_powers(:, l) >= th, l) = 1;
    
    end
    
    cs_pds(th_idx) = sum(diag(orig_carriers' * cs_carriers)) / (n_loops * k);
    mc_pds(th_idx) = sum(diag(orig_carriers' * mc_carriers)) / (n_loops * k);
    
    cs_pfas(th_idx) = sum(diag(~orig_carriers' * cs_carriers)) / (n_loops * k);
    mc_pfas(th_idx) = sum(diag(~orig_carriers' * mc_carriers)) / (n_loops * k);
    
end

figure('Name', 'ROC');
plot(cs_pfas, cs_pds, 'g');
hold on;
plot(mc_pfas, mc_pds, 'r');
xlabel('pfa');
ylabel('pd');

toc;

