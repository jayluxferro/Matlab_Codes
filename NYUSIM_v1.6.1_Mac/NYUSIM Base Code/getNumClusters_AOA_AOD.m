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

function [numberOfTimeClusters,numberOfAOALobes,numberOfAODLobes] = ...
    getNumClusters_AOA_AOD(mu_AOA,mu_AOD,sceType)  
% Generate the number of time clusters, the number of AOD spatial lobes,
% and the number of AOA spatial lobes 
%
% Inputs:
%   - mu_AOA: the mean number of spatial lobes at the RX 
%   - mu_AOD: the mean number of spatial lobes at the TX 
% Output:
%   - numberOfTimeClusters: the number of time clusters
%   - numberOfAOALobes: the number of spatial lobes at the RX
%   - numberOfAODLobes: the number of spatial lobes at the TX
%
% Copyright © 2016 NYU
if strcmp(sceType,'RMa') == false
     numberOfTimeClusters = randi([1,6]);
     aod_instance = poissrnd(mu_AOD);
     numberOfAODLobes = max(1,min(5,aod_instance));
     aoa_instance = poissrnd(mu_AOA);
     numberOfAOALobes = max(1,min(5,aoa_instance));
elseif strcmp(sceType,'RMa') == true
        numberOfTimeClusters = 1;
        numberOfAODLobes = 1;
        numberOfAOALobes = 1;
     
end
end