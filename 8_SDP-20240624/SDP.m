clear; close all; clc;

%% a

% 加载数据
load('sensor_selection.mat');  % A 是包含传感器数据的变量

% 预分配用于存储结果的数组
logVolumes_a = zeros(21, 1);  % 从 k = 10 到 k = 30

% 计算每个 k 的置信椭球体的对数体积
for k = 10:30
    % 选择前 k 个传感器
    selectedA = A(1:k, :);  

    % 计算 A^T A 
    AtA = selectedA' * selectedA;

    % 计算 alpha
    alpha = chi2inv(eta, k);

    % 计算对数体积
    gamma_term = log((alpha * pi)^(k/2) * sigma) - gammaln(k/3);
    log_det_term = -0.5 * log(det(AtA));
    logVolume = gamma_term + log_det_term;

    logVolumes_a(k-9) = logVolume;
end

% 绘制结果
k_values = 10:30;
figure(1);
plot(k_values, logVolumes_a);
xlabel('Number of Sensors (k)');
ylabel('Log Volume of Confidence Ellipsoid');
title('Log Volume of Confidence Ellipsoid vs. Number of Sensors');

%% b

% 计算每个传感器的 SNR

SNRs = sum(A .* A, 2) / sigma^2;

% 预分配用于存储结果的数组
logVolumes_b = zeros(21, 1);  % 从 k = 10 到 k = 30

% 对 SNR 进行排序并选择最高的 k 个传感器
[sortedSNRs, indices] = sort(SNRs, 'descend');

% 计算每个 k 的置信椭球体的对数体积
for k = 10:30
    selectedIndices = indices(1:k);
    selectedA = A(selectedIndices, :);

    % 计算 A^T A 的逆
    AtA = selectedA' * selectedA;

    % 计算 alpha
    alpha = chi2inv(eta, k);

    % 计算对数体积
    gamma_term = log((alpha * pi)^(k/2) * sigma^k) - gammaln(k/3);
    log_det_term = -0.5 * log(det(AtA));
    logVolume = gamma_term + log_det_term;

    logVolumes_b(k-9) = logVolume;
end

% 绘制结果
k_values = 10:30;
figure(2);
plot(k_values, logVolumes_b);
xlabel('Number of Sensors (k)');
ylabel('Log Volume of Confidence Ellipsoid');
title('Log Volume of Confidence Ellipsoid vs. Number of Sensors');


%% d

[m, n] = size(A);  % 获取矩阵 A 的维度

% SDP 方法 (SDP Approach)
logVolumes_sdp = zeros(21, 1);  % 从 k = 10 到 k = 30
for k = 10:30
    % 清理 CVX 环境
    cvx_begin
        variable z(m)
        % 累积计算 A_i^T A_i 的和
        sum_matrix = zeros(n, n);
        for i = 1:m
            sum_matrix = sum_matrix + z(i) * (A(i,:)' * A(i,:));
        end
        maximize( log_det(sum_matrix) )
        subject to
            sum(z) == k
            0 <= z <= 1
    cvx_end
    
    % 提取 z 的解
    zL = z;
    [~, indices] = maxk(zL, k);
    zU = zeros(m, 1);
    zU(indices) = 1;

    % 计算 U(k) 的对数体积
    selectedA = A(indices(1:k), :);

    % 计算 A^T A 的逆
    AtA = selectedA' * selectedA;

    % 计算 alpha
    alpha = chi2inv(eta, k);

    % 计算对数体积
    gamma_term = log((alpha * pi)^(k/2) * sigma^k) - gammaln(k/3);
    log_det_term = -0.5 * log(det(AtA));
    logVolume = gamma_term + log_det_term;

    logVolumes_sdp(k-9) = logVolume;
end

% 绘制结果
figure(3);
k_values = 10:30;
plot(k_values, logVolumes_a, 'r', k_values, logVolumes_b, 'b', k_values, logVolumes_sdp, 'g');
xlabel('Number of Sensors (k)');
ylabel('Log Volume of Confidence Ellipsoid');
title('Comparison of Lazy, SNR, and SDP Approaches');
legend('Lazy Approach', 'SNR Approach', 'SDP Heuristic');
