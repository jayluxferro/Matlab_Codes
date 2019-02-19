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

function [timeArray_Dir multipathArray_Dir] = ...
    getDirPDP_new(powerSpectrum,TX_Dir_Gain_Mat,RX_Dir_Gain_Mat,G_TX,G_RX,TXPower,dynamicRange)

powerSpectrum_Dir = powerSpectrum;

numberOfSubpathComponents = size(powerSpectrum_Dir,1);

%%% apply gains
for subpathIndex = 1:numberOfSubpathComponents
    
    subpathP_Iso = powerSpectrum(subpathIndex,2);
    
    %%% TX-RX gains
    TXGain = TX_Dir_Gain_Mat(subpathIndex);
    RXGain = RX_Dir_Gain_Mat(subpathIndex);
    
    %%% apply directive gains
    subpathP_Dir = subpathP_Iso*TXGain*RXGain;
    
    powerSpectrum_Dir(subpathIndex,2) = subpathP_Dir;
end


h_dir = zeros(numberOfSubpathComponents,2);

for subpathIndex = 1:numberOfSubpathComponents
    
    
    %%% extract subpath delay
    subpath_Delay = powerSpectrum_Dir(subpathIndex,1);
    
    %%% extract subpath power (directional)
    subpath_p = powerSpectrum_Dir(subpathIndex,2);
    
    if 10*log10(subpath_p)<(TXPower-dynamicRange+10*log10(G_TX)+10*log10(G_RX))
        subpath_p = 1e-20;
    else
    end
    
    %%% store
    h_dir(subpathIndex,:) = [subpath_Delay subpath_p];
end%%end of subpathIndex 

%%% build continuous PDP
%%% create timeArray
dt = 1/16;
N = 60000;
timeArray_Dir = (0:(N-1))*dt;
multipathArray_Dir = 1e-20*ones(size(timeArray_Dir));

%%% indices to store
indToStore = round(h_dir(:,1)/dt);

%%% store
multipathArray_Dir(indToStore) = h_dir(:,2);
end