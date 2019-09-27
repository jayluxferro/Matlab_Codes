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

function [newPowerSpectrum,numberOfClusterSubPaths, SubpathIndex] = getBWPowerSpectrum(powerSpectrum,RFBW)

% minimum time interval between adjacent subpaths in ns
dT = 1/(RFBW/2)*1e3;
newPowerSpectrum = [];
tSubpath = powerSpectrum(:,1);
SubpathIndex = [];
iNSP = 1; 
iSubpath = 0;

while iSubpath(end)+1<=size(powerSpectrum,1)
        iTSP = iSubpath(end)+1;
        iSubpath = find(tSubpath<tSubpath(iTSP)+dT&tSubpath>=tSubpath(iTSP));
        % Record the subpath index
        SubpathIndex = [SubpathIndex;iSubpath(end)+1];
        newPowerSpectrum(iNSP,[1,3:7]) = powerSpectrum(iTSP,[1,3:7]);
        % Amplitude with phase vector sum
        newComplexAmp = sum(sqrt(powerSpectrum(iSubpath,2)).*exp(1i*powerSpectrum(iSubpath,3)));
        newPowerSpectrum(iNSP,2) = abs(newComplexAmp)^2;
        iNSP = iNSP+1;
        
end
   nSubpath = iNSP-1; 
   numberOfClusterSubPaths = nSubpath;
   