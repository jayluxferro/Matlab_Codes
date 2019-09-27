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
function lobePowerSpectrum_struct = ...
    getLobePowerSpectrum(numberOfLobes,cluster_subpath_lobe_mapping,powerSpectrum,angleType)
% Generate the lobe power angular spectra
%
% Inputs:
%   - numberOfLobes: the number of spatial lobes
%   - cluster_subpath_lobe_mapping: a structure containing the mapping
%   between cluster number, subpath number, and spatial lobe number for
%   each multipath 
%   - powerSpectrum: an array containing all multipath parameters
%   - angleType: 'AOD' or 'AOA'
% Output:
%   - lobePowerSpectrum_struct: a structure containing lobe angular spectra
%

if strcmp(angleType,'AOD') == true
    subpathSpectrum = powerSpectrum(:,1:5);
elseif strcmp(angleType,'AOA') == true
    subpathSpectrum = powerSpectrum(:,[1:3 6:7]);
else
end

%%% initialize lobe power spectrum
lobePowerSpectrum_struct = struct;

for lobeIndex = 1:numberOfLobes
    
   indSameLobe = find(cluster_subpath_lobe_mapping(:,3) == lobeIndex);
   
   %%% subpaths that belong to same lobe
   subpathSpectrum_SameLobe = subpathSpectrum(indSameLobe,:);
    
   %%% store
   lobePowerSpectrum_struct.(['Lobe',num2str(lobeIndex)]) = subpathSpectrum_SameLobe;
    
end



end