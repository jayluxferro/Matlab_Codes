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

function [Pr_dBm, PL] = getRXPower(f,n,SF,TXPower,dist,d0)
% Generate the omnidirectional received power and path loss
%
% Inputs:
%   - f_str: a string specifying the frequency of interest
%   - n: the frequency-dependent path loss exponent
%   - SF: the shadow factor, in dB
%   - TXPower: the transmit power, typically set to 0 dBm
%   - dist: the T-R separation, in meters
%   - d0: the free space reference distance, typically 1 meter
%   - dynamicRange: the maximum allowable path loss, typically 180 dB in
%   the NYU measurements
% Output:
%   - Pr_dBm: the omnidirectional received power, in dBm
%   - PL: the omnidirectional path loss, in dB
%
% Copyright © 2018 NYU

% switch f_str
%     case '28_GHz'
%         f_ = 28e9;
%     case '73_GHz'
%         f_ = 73e9;
%     otherwise
% end

% constants
c = 3e8; %% speed of light (m/s)
lambda = c/(f*1e9); %% wavelength (m)

% free space path loss at d0 (dB)
PLref = 20*log10(4*pi*d0/lambda);

% absolute path loss at distance dist
% PL = min(PLref + n*10*log10(dist/d0)+SF*randn,dynamicRange);
PL = PLref + n*10*log10(dist/d0)+SF*randn;

% total received power (dBm) at distance dist 
Pr_dBm = TXPower - PL;

end