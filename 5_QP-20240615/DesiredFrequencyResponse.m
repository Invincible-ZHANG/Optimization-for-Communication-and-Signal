function [A,b] = DesiredFrequencyResponse(N,D,f_range,gains)
% Calculation of the frequency transform matrix G and the desired frequency
% response for Problem 5.2: FIR filter design with low coefficient variation
%
% INPUT
%   N : filter length
%   D : phase delay
%   f_range : vector of frequency bands for the desired frequency response, take care
%             of the correct order, example: f_range = [0 0.15 0.2 0.4 0.5 1]
%   gains : desired frequency response corresponding to f_range, value in
%           dB, example: gains = [-50 0 -50]
%
% OUTPUT
%   G : frequency transform matrix
%   f_des : desired frequency matrix

% desired frequency response
f_des = []; freq = [];
for k = 1:length(gains)
    f_des = [f_des, 10.^(gains(k)/20) * ...
        exp(-1i*pi*linspace(f_range(2*k-1),f_range(2*k),2^6)*D)];
    freq = [freq, linspace(f_range(2*k-1),f_range(2*k),2^6)];
end;
b = f_des.';
% frequency transform matrix, has different interpretations in other fields.
% For example in regression this would be something like:
% rows "number of measurements", columns "number of regressors"
A = exp(-1i*pi*freq(:)*(0:N-1));
