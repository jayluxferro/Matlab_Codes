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

function [CIR,H,HPowers,HPhases,H_total] = getLocalCIR_new(CIR,powerSpectrumOld,TxArrayType,RxArrayType,Nt,Nr,Wt,Wr,dTxAnt,dRxAnt,RFBW) 
% This function generates the local area CIRs. TxArrayType is the type of 
% Tx antenna array (e.g., ULA, URA), RxArrayType is the type of Rx antenna 
% array, Nt is the number of Tx antennas, Nr is the number of Rx antennas, 
% Wt is # of Tx antennas in the azimuth dimention, Wr is # of Rx antennas 
% in the azimuth dimention, dTxAnt is the spacing between adjacent Tx 
% antennas in terms of wavelength, dRxAnt is the spacing between adjacent 
% Rx antennas in terms of wavelength

% Example input parameters (for test purpose only): 
% TxArrayType = 'ULA'; RxArrayType = 'URA'; Nt = 4; Nr = 10; dTxAnt = 1/2; dRxAnt = 1/2; Wt = 1; Wr = 2;

j = sqrt(-1); % imaginary unit
c = 3e8; % speed of light
f = str2num(CIR.frequency(1:2))*1e9; % carrier frequency
wl = c/f; % carrier wavelength
Phase = powerSpectrumOld(:,3);
n_BS = [1:1:Nt]'; n_MS = [1:1:Nr]'; 
aziAOD = powerSpectrumOld(:,4); aziAOA = powerSpectrumOld(:,6);
eleAOD = powerSpectrumOld(:,5); eleAOA = powerSpectrumOld(:,7);

nTap = size(powerSpectrumOld,1); % number of paths
timeDelay = CIR.pathDelays.*1e-9; % absolute propagation time delay of each path
Pr_lin = powerSpectrumOld(:,2); % received power in mW of each path
Pt_lin = 10^(CIR.TXPower/10);

for i = 1:length(n_BS)
    for k = 1:length(aziAOD)
        a_BS_ULA(i,k) = exp(j.*(n_BS(i)-1).*2.*pi./wl.*dTxAnt.*cos(aziAOD(k)));
    end
end
for i = 1:length(n_MS)
    for k = 1:length(aziAOA)
        a_MS_ULA(i,k) = exp(j.*(n_MS(i)-1).*2.*pi./wl.*dRxAnt.*cos(aziAOA(k)));
    end
end
for i = 1:length(n_BS)
    for k = 1:length(aziAOD)
        a_BS_URA(i,k) = exp(j.*2.*pi./wl.*dTxAnt.*(abs(mod(n_BS(i),Wt)-mod(1,Wt)).*cos(aziAOD(k)).*cos(eleAOD(k))+...
            abs(fix(n_BS(i)/Wt)-fix(1/Wt)).*sin(eleAOD(k))));
    end
end
for i = 1:length(n_MS)
    for k = 1:length(aziAOA)
        a_MS_URA(i,k) = exp(j.*2.*pi./wl.*dRxAnt.*(abs(mod(n_MS(i),Wr)-mod(1,Wr)).*cos(aziAOA(k)).*cos(eleAOA(k))+...
            abs(fix(n_MS(i)/Wr)-fix(1/Wr)).*sin(eleAOA(k))));
    end
end

% Calculate local area CIRs and the corresponding parameters 
H = cell(nTap,1); HPhases = cell(nTap,1); HPowers = cell(nTap,1); H_total = zeros(Nr,Nt);
for a = 1:nTap
% Determine the Tx and Rx antenna array types
    if strcmp(TxArrayType,'ULA') == true && strcmp(RxArrayType,'ULA') == true 
H{a,1} = sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_ULA(:,a)*a_BS_ULA(:,a)';
H_total = H_total+sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_ULA(:,a)*a_BS_ULA(:,a)';
% Determine the Tx and Rx antenna array types
elseif strcmp(TxArrayType,'ULA') == true && strcmp(RxArrayType,'URA') == true 
H{a,1} = sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_URA(:,a)*a_BS_ULA(:,a)';
H_total = H_total+sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_URA(:,a)*a_BS_ULA(:,a)';
% Determine the Tx and Rx antenna array types
elseif strcmp(TxArrayType,'URA') == true && strcmp(RxArrayType,'ULA') == true
H{a,1} = sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_ULA(:,a)*a_BS_URA(:,a)';
H_total = H_total+sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_ULA(:,a)*a_BS_URA(:,a)';
% Determine the Tx and Rx antenna array types
elseif strcmp(TxArrayType,'URA') == true && strcmp(RxArrayType,'URA') == true
H{a,1} = sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_URA(:,a)*a_BS_URA(:,a)';
H_total = H_total+sqrt(Pr_lin(a)/Pt_lin)*exp(j*Phase(a))*a_MS_URA(:,a)*a_BS_URA(:,a)';
    end
    
CIR.HDelays{a,1} = CIR.pathDelays(a); % time delay for the ath path
CIR.HPowers{a,1} = abs(H{a,1}).^2; % received power between each Tx antenna and each Rx antenna for the ath path
CIR.HPhases{a,1} = CIR.pathPhases(a)+angle(H{a,1}); % phase between each Tx antenna and each Rx antenna for the ath path
% CIR.HComplex(a,1) = CIR.HPowers{a,1}.*exp(j.*CIR.HPhases{a,1});
CIR.HAODs{a,1} = CIR.AODs(a); % AOD for the ath path
CIR.HZODs{a,1} = CIR.ZODs(a); % ZOD for the ath path
CIR.HAOAs{a,1} = CIR.AOAs(a); % AOA for the ath path
CIR.HZOAs{a,1} = CIR.ZOAs(a); % ZOA for the ath path

H_Temp = H{a,1}; HPhases_Temp = CIR.HPhases{a,1};

%%%%%%%%%% Modification in v1.6.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The size of CIR.HComplex{a,1} is set to be the # of TX antennas times # of 
% RX antennas. For both TX and RX antenna elements, the phase difference 
% between two elements is deterministically calculated using the antenna 
% spacing and angles.

CIR.HComplex{a,1} = H_Temp.*exp(j.*HPhases_Temp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

HPowers{a,1} = abs(H{a,1}).^2;
HPhases{a,1} = CIR.pathPhases(a)+angle(H{a,1});
end
%%% Scale MPCs per RFBW

%%%%%%%%%%%% Modification in v1.6.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize HSmallScale as a cell, and do the MPCs combination based on
% the user-specified bandwidth. Previously, HSmallScale only stored the 
% CIRs of the first TX antenna element with all RX antenna elements (SIMO).

HSmallScale = {};
dT = 1/(RFBW/2)*1e3;
tSubpath = powerSpectrumOld(:,1);
iNSP = 1; 
iSubpath = 0;
while iSubpath(end)+1<=size(powerSpectrumOld,1)
    iTSP = iSubpath(end)+1;
    iSubpath = find(tSubpath<tSubpath(iTSP)+dT&tSubpath>=tSubpath(iTSP));
    temp = 0;
    for k = 1:length(iSubpath)
        temp = temp + CIR.HComplex{iSubpath(k),1};
    end
    HSmallScale{iNSP,1} = temp;
    iNSP = iNSP+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%
CIR.NumOfTxElements = Nt; % number of antenna elements in the Tx array
CIR.NumOfRxElements = Nr; % number of antenna elements in the Rx array
CIR.H = HSmallScale; % H matrix
