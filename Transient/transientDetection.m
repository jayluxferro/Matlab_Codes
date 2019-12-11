%{
    first implementation of transient detection
%}

% getting the upper envelope
clc; clear; close all;
load('data');

upperEnv = [];
counter = 1;
hEnvMean = mean(hEnv);
for k = 1:length(hEnv)
    if hEnv(k) >= hEnvMean
       upperEnv(counter) = hEnv(k);
       counter = counter + 1;
    end
end

figure(1);
plot(upperEnv);

figure(2);
plot(hEnv);