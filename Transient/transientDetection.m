%{
    first implementation of transient detection
%}

%% getting the upper envelope
clc; clear; close all;
load('data');

upperEnv = [];
counter = 1;
hEnvMean = mean(hEnv);
maxValue = max(hEnv);
maxPointReached = false;

for k = 1:length(hEnv)
    if hEnv(k) >= hEnvMean
        if hEnv(k) == maxValue
            maxPointReached = true;
        end
        
        if maxPointReached 
           if hEnv(k) >=
        else
            upperEnv(counter) = hEnv(k);
            counter = counter + 1; 
        end
       
    end
end

% trimming off extra data



figure(1);
plot(upperEnv);

figure(2);
plot(hEnv);