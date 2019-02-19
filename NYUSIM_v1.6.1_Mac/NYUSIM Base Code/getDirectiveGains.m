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

function [TX_Dir_Gain_Mat RX_Dir_Gain_Mat G_TX G_RX] = ...
    getDirectiveGains(theta_3dB_TX,phi_3dB_TX,theta_3dB_RX,phi_3dB_RX,...
    theta_TX,phi_TX,theta_RX,phi_RX,powerSpectrum)


eta = 0.7;
%%% parameters for the G_TX
alphaTX = 4*log(2)/theta_3dB_TX^2;
betaTX = 4*log(2)/phi_3dB_TX^2;
G_TX = eta*41253/((theta_3dB_TX)*(phi_3dB_TX));

%%% parametres for G_RX
alphaRX = 4*log(2)/theta_3dB_RX^2;
betaRX = 4*log(2)/phi_3dB_RX^2;
G_RX = eta*41253/((theta_3dB_RX)*(phi_3dB_RX));

%%% number of directive gains
Omega_TX_RX = size(powerSpectrum,1);

%%% initialize TX and RX directive gains to 0
TX_Dir_Gain_Mat = zeros(Omega_TX_RX,1);
RX_Dir_Gain_Mat = zeros(Omega_TX_RX,1);

for linkIndex = 1:Omega_TX_RX
    
    %%% extract current AOD-AOA combination
    TX_Azi = powerSpectrum(linkIndex,4);
    TX_El = powerSpectrum(linkIndex,5);
    
    RX_Azi = powerSpectrum(linkIndex,6);
    RX_El = powerSpectrum(linkIndex,7);
    
    %%% TX Directive Gain
    deltaTheta_TX = theta_TX-TX_Azi;
    deltaPhi_TX = phi_TX-TX_El;
    TX_Dir_Gain = G_TX*exp(-deltaTheta_TX^2*alphaTX)*exp(-deltaPhi_TX^2*betaTX);
    
    TX_Dir_Gain_Mat(linkIndex) = max(TX_Dir_Gain,G_TX/10000);
% TX_Dir_Gain_Mat(linkIndex) = max(TX_Dir_Gain,1);
% TX_Dir_Gain_Mat(linkIndex) = TX_Dir_Gain;
    
    %%% RX Directive Gain
    deltaTheta_RX = theta_RX-RX_Azi;
    deltaPhi_RX = phi_RX-RX_El;
    RX_Dir_Gain = G_RX*exp(-deltaTheta_RX^2*alphaRX)*exp(-deltaPhi_RX^2*betaRX);
    
%     RX_Dir_Gain_Mat(linkIndex) = max(RX_Dir_Gain,G_RX/100);
RX_Dir_Gain_Mat(linkIndex) = max(RX_Dir_Gain,1);
    
end%%end of linkIndex


end