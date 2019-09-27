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

function rho_mn = getIntraClusterDelays(numberOfClusterSubPaths,X_max)
% Generate intra-cluster subpath delays in ns.
%
% Inputs:
%   - numberOfClusterSubPaths: array containing the number of subpaths for
%   each time cluster
%   - X_max: a number between 0 and 1
% Output:
%   - rho_mn: a structure containing intra-cluster subpath delays, in ns
%
% Copyright © 2018 NYU



    %%% initialize the structure that will contain the intra cluster delays
    rho_mn = struct;
    
    %%% number of clusters
    numberOfClusters = size(numberOfClusterSubPaths,1);

    %%% for loop iterates N times for each cluster
    for clusterIndex=1:numberOfClusters

        %%% number of sub-paths in current cluster
        numberOfComponents = numberOfClusterSubPaths(clusterIndex);

        %%% generate a set of component delays
%         arrayTemp = 2.5*(1:numberOfComponents);
arrayTemp = 1/(800/2)*1e3*(1:numberOfComponents);

        %%% field name
        str = ['c',num2str(clusterIndex)];

        %%% sort the array
        sortedArray = sort(arrayTemp - min(arrayTemp));
        
        %%% store the components
        X = X_max*rand;
        rho_mn.(str) = sortedArray.^(1+X);        

    end

end