%%% NYUSIM - User License %%%

% Copyright (c) 2018 New York University and NYU WIRELESS

% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the “Software”),
% to deal in the Software without restriction, including without limitation 
% the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, and to permit persons to whom the 
% Software is furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software. Users shall cite 
% NYU WIRELESS publications regarding this work.

% THE SOFTWARE IS PROVIDED “AS IS”, WITHOUTWARRANTY OF ANY KIND, EXPRESS OR 
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
% THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
% OTHER LIABILITY, WHETHER INANACTION OF CONTRACT TORT OR OTHERWISE, 
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
% OTHER DEALINGS IN THE SOFTWARE.

function clusterPowers = getClusterPowers(tau_n,Pr_dBm,Gamma,sigmaCluster,Th)
% Generate time cluster powers (relative to Pr).
%
% Inputs:
%   - tau_n: array of time cluster excess delays, in ns
%   - Pr_dBm: omnidirectional received power, in dBm
%   - Gamma: time cluster decay constant, in ns
%   - sigmaCluster: per-cluster shadowing, in dB
% Output:
%   - clusterPowers: array of time cluster powers, relative to 1 mW
%
% Copyright © 2016 NYU

Pr_Lin = 10^(Pr_dBm/10);

%%% number of clusters
numberOfTimeClusters = size(tau_n,2);

%%% minimum cluster power in dBm
minClusterPower_dB = Th;   

%%% generate per-cluster shadowing
Z = sigmaCluster*randn([1 numberOfTimeClusters]); 

%%% cluster ratios
clusterPowerRatios_temp = exp(-tau_n/Gamma).*10.^(Z/10);

%%% normalize cluster ratios such that their sum equals 1
clusterPowerRatios = clusterPowerRatios_temp/sum(clusterPowerRatios_temp);

%%% multiply the ratios by the total received power (in linear units)
clusterPowers_Lin_Temp = Pr_Lin*clusterPowerRatios;

%%% make sure the lowest possible cluster power is minClusterPower_dB
% clusterPowers = max(clusterPowers_Lin_Temp,10^(minClusterPower_dB/10));
clusterPowers = clusterPowers_Lin_Temp;

end