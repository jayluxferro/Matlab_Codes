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

function t_mn = getAbsolutePropTimes(dist,tau_n,rho_mn)
% Generates absolute time of multipath components.
%
% Inputs:
%   - dist: T-R separation distance in meters
%   - tau_n: array of time cluster delays in ns
%   - rho_mn: structure of intra-cluster subpath delays in ns
% Ouput:
%   - t_mn: structre of intra-cluster subpath absolute times of arrival in
%   ns
%
% Copyright © 2016 NYU

    %%% initialize structure that will contain propagatin times
    t_mn = struct;

    %%% number of clusters
    numberOfClusters = size(tau_n,2);

    %%% speed of light (m/s)
    c = 3e8;
    
    %%% absolute propagation time of first arrival in ns
    t0 = dist/c*1e9;

    for clusterIndex = 1:numberOfClusters

        %%% cluster excess delay       
        tau = tau_n(clusterIndex);

        %%% intra cluster excess delays
        rho = rho_mn.(['c',num2str(clusterIndex)]);

        %%% recover absolute propagation times of arrival
        t_mn.(['c',num2str(clusterIndex)]) = t0+tau+rho;

    end



end