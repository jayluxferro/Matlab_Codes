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

function numberOfClusterSubPaths = getNumberOfClusterSubPaths(numberOfTimeClusters,sceType)
% Generate the number of intra-cluster subpaths
%
% Inputs:
%   - numberOfTimeClusters: the number of time clusters
% Output:
%   - numberOfClusterSubPaths: an array containing the number of subpaths
%   for each time cluster
%
% Copyright © 2016 NYU

    % Generate number of subpaths in each time cluster
    if strcmp(sceType,'RMa') == false
    numberOfClusterSubPaths = randi([1 30],[numberOfTimeClusters 1]);
    elseif strcmp(sceType,'RMa') == true
        numberOfClusterSubPaths = randi([1 2],[numberOfTimeClusters 1]);
    end

end