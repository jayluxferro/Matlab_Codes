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

function tau_n = getClusterExcessTimeDelays(mu_tau,rho_mn,minVoidInterval)
% Generate time cluster delays.
%
% Inputs:
%   - mu_tau: mean excess delay in ns
%   - rho_mn: structure of intra-cluster subpath delays in ns
%   - minVoidInterval: minimum inter-cluster void interval, typically set
%   to 25 ns for outdoor environments
% Output:
%   - tau_n: array of time cluster excess delays in ns
%
% Copyright © 2016 NYU

    %%% number of time clusters
    numberOfTimeClusters = size(fieldnames(rho_mn),1);

    %%% initialize cluster delays
    tau_n = zeros(1,numberOfTimeClusters);
        
    %%% void interval between consecutive clusters
    clusterVoidInterval = minVoidInterval+1/(800/2)*1e3;
    
    %%%% generate cluster delays as exponential
    tau_n_prime = exprnd(mu_tau,[1 numberOfTimeClusters]);
        
    %%% normalize
    tau_n_double_prime = sort(tau_n_prime - min(tau_n_prime));
    
    temp = rho_mn.c1(end);
    %%% this for loop starts at the 2nd cluster index because the first
    %%% cluster index is always 0
    for clusterIndex = 2:numberOfTimeClusters        
        
        %%% add the last cluster sub-path delay of the previous cluster to
        %%% the current cluster delay for no overlap in multipath
        %%% components. 
        
        tau_n(clusterIndex) = tau_n_double_prime(clusterIndex)+temp+clusterVoidInterval;        
        
        %%% cluster sub-path delays of the previous cluster
        rho_m = rho_mn.(['c',num2str(clusterIndex)]);
        
        %%% keep track of the last intra-cluster delay
        temp = tau_n(clusterIndex)+rho_m(end);
        
    end
    
        

end




