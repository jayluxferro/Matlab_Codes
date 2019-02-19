%%% NYUSIM - User License %%%

% Copyright (c) 2016-2018 New York University and NYU WIRELESS

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

% NYUSIM_MainCode Version 1.6.1, developed by:
%
% Shihao Ju, Shu Sun, Mathew Samimi - NYU WIRELESS, October 2018
%
% This script shows an example of how to generate output figures of NYUSIM 
% without the need to open the graphical user interface (GUI) of NYUSIM.
% Users can modify this script per their own needs, such as modifying
% channel parameters and creating data files, etc. For more detailed
% information about the code, please refer to the user manual of NYUSIM 
% (http://wireless.engineering.nyu.edu/nyusim/) and references therein.
%
% Note: This code was written on a Mac OS, fontsizes displayed in figures
% may need to be adjusted by the user if operating on a Windows OS.
% 
% See REFERENCES below and the NYUSIM user manual for more information:
%
% [1] S. Sun, G. R. MacCartney, and T. S. Rappaport, "A novel 
% millimeter-wave channel simulator and applications for 5G wireless 
% communications," 2017 IEEE International Conference on Communications 
% (ICC), Paris, France, 2017, pp. 1-7.
%
% [2] M. K. Samimi and T. S. Rappaport, "3-D Millimeter-Wave Statistical 
% Channel Model for 5G Wireless System Design," in IEEE Transactions on 
% Microwave Theory and Techniques, vol. 64, no. 7, pp. 2207-2225, Jul. 2016.
%
% [3] S. Sun et al., "Investigation of Prediction Accuracy, Sensitivity, 
% and Parameter Stability of Large-Scale Propagation Path Loss Models for 
% 5G Wireless Communications," in IEEE Transactions on Vehicular Technology, 
% vol. 65, no. 5, pp. 2843-2860, May 2016.

clear all; close all; tic
% Set the current folder as the running folder
runningFolder = pwd; 
%% Input parameters (subject to change per users' own needs)
% Carrier frequency in GHz (0.5-100 GHz)
f = 28; freq = num2str(f);
% RF bandwidth in MHz (0-1000 MHz)
RFBW = 400; 
% Operating scenario, can be UMi (urban microcell),UMa (urban macrocell),
% or RMa (Rural macrocell)
sceType = 'UMi'; 
% Operating environment, can be LOS (line-of-sight) or NLOS (non-line-of-sight)
envType = 'LOS'; 
% Minimum and maximum T-R separation distance (10-10,000 m)
dmin = 10; dmax = 200; 
% Transmit power in dBm (0-50 dBm)
TXPower = 30;
% Base station height in meters (10-150 m), only used for the RMa scenario
h_BS = 15; 
% Barometric Pressure in mbar (1e-5 to 1013.25 mbar)
p = 1013.25; 
% Humidity in % (0-100%)
u = 50; 
% Temperature in degrees Celsius (-100 to 50 degrees Celsius)
t = 20;
% Rain rate in mm/hr (0-150 mm/hr)
RR = 0; 
% Polarization (Co-Pol or X-Pol)
Pol = 'Co-Pol';
% Foliage loss (Yes or No)
Fol = 'No'; 
% Distance within foliage in meters (0-dmin)
dFol = 0; 
% Foliage attenuation in dB/m (0-10 dB/m)
folAtt = 0.4;
% Number of receiver locations, which is also the number of simulation runs (1-10,000)
N = 1; 
% Transmit array type (ULA or URA)
TxArrayType = 'ULA'; 
% Receive array type (ULA or URA)
RxArrayType = 'ULA'; 
% Number of transmit antenna elements (1-128)
Nt = 1; 
% Number of receive antenna elements (1-64)
Nr = 4; 
% Transmit antenna spacing in wavelengths (0.1-100)
dTxAnt = 0.5; 
% Receive antenna spacing in wavelengths (0.1-100)
dRxAnt = 0.5;
% Number of transmit antenna elements per row for URA
Wt = 1; 
% Number of receive antenna elements per row for URA
Wr = 8; 
% Transmit antenna azimuth half-power beamwidth (HPBW)in degrees (7-360 degrees)
theta_3dB_TX = 10; 
% Transmit antenna elevation HPBW in degrees (7-45 degrees)
phi_3dB_TX = 10;
% Receive antenna azimuth HPBW in degrees (7-360 degrees)
theta_3dB_RX = 10; 
% Receive antenna elevation HPBW in degrees (7-45 degrees)
phi_3dB_RX = 10;
%%% Create an output folder 
if exist('NYUSIM_OutputFolder','dir')==0 
    mkdir NYUSIM_OutputFolder
end
%%% Channel Model Parameters
% Free space reference distance in meters
d0 = 1; 
% Speed of light in m/s
c = 3e8;
% Set channel parameters according to the scenario
% UMi LOS
if strcmp(sceType,'UMi') == true && strcmp(envType,'LOS') == true 
% Path loss exponent (PLE)
n = 2; 
% Shadow fading standard deviation in dB
SF = 4.0; 
% Mean angle of departure (AOD)
mu_AOD = 1.9; 
% Mean angle of arrival (AOA)
mu_AOA = 1.8;
% A number between 0 and 1 for generating intra-cluster delays
X_max = 0.2;
% Mean excess delay in ns
mu_tau = 123; 
% Minimum inter-cluster void interval, typically set to 25 ns for outdoor environments
minVoidInterval = 25;
% Per-cluster shadowing in dB
sigmaCluster = 1;
% Time cluster decay constant in ns
Gamma = 25.9; 
% Per-subpath shadowing in dB
sigmaSubpath = 6; 
% Subpath decay constant in ns
gamma = 16.9; 
% Mean zenith angle of departure (ZOD) in degrees
mean_ZOD = -12.6;
% Standard deviation of the ZOD distribution in degrees
sigma_ZOD = 5.9; 
% Standard deviation of the azimuth offset from the lobe centroid
std_AOD_RMSLobeAzimuthSpread = 8.5;
% Standard deviation of the elevation offset from the lobe centroid
std_AOD_RMSLobeElevationSpread = 2.5;
% A string specifying which distribution to use: 'Gaussian' or 'Laplacian'
distributionType_AOD = 'Gaussian'; 
% Mean zenith angle of arrival (ZOA) in degrees
mean_ZOA = 10.8; 
% Standard deviation of the ZOA distribution in degrees
sigma_ZOA = 5.3;
% Standard deviation of the azimuth offset from the lobe centroid
std_AOA_RMSLobeAzimuthSpread = 10.5;
% Standard deviation of the elevation offset from the lobe centroid
std_AOA_RMSLobeElevationSpread = 11.5;
% A string specifying which distribution to use: 'Gaussian' or 'Laplacian'
distributionType_AOA = 'Laplacian';   
% UMi NLOS
elseif strcmp(sceType,'UMi') == true && strcmp(envType,'NLOS') == true
% See the parameter definitions for UMi LOS
n = 3.2; 
SF = 7.0; 
mu_AOD = 1.5; 
mu_AOA = 2.1; 
X_max = 0.5; 
mu_tau = 83;
minVoidInterval = 25; 
sigmaCluster = 3; 
Gamma = 51.0; 
sigmaSubpath = 6;
gamma = 15.5; 
mean_ZOD = -4.9; 
sigma_ZOD = 4.5; 
std_AOD_RMSLobeAzimuthSpread = 11.0;
std_AOD_RMSLobeElevationSpread = 3.0; 
distributionType_AOD = 'Gaussian'; 
mean_ZOA = 3.6; 
sigma_ZOA = 4.8; 
std_AOA_RMSLobeAzimuthSpread = 7.5;
std_AOA_RMSLobeElevationSpread = 6.0; 
distributionType_AOA = 'Laplacian';
% UMa LOS
elseif strcmp(sceType,'UMa') == true && strcmp(envType,'LOS') == true 
% See the parameter definitions for UMi LOS
n = 2; 
SF = 4.0; 
mu_AOD = 1.9; 
mu_AOA = 1.8;
X_max = 0.2; 
mu_tau = 123; 
minVoidInterval = 25; 
sigmaCluster = 1;
Gamma = 25.9; 
sigmaSubpath = 6; 
gamma = 16.9; 
mean_ZOD = -12.6;
sigma_ZOD = 5.9; 
std_AOD_RMSLobeAzimuthSpread = 8.5;
std_AOD_RMSLobeElevationSpread = 2.5;
distributionType_AOD = 'Gaussian'; 
mean_ZOA = 10.8; 
sigma_ZOA = 5.3;
std_AOA_RMSLobeAzimuthSpread = 10.5;
std_AOA_RMSLobeElevationSpread = 11.5;
distributionType_AOA = 'Laplacian'; 
% UMa NLOS
elseif strcmp(sceType,'UMa') == true && strcmp(envType,'NLOS') == true 
% See the parameter definitions for UMi LOS
n = 2.9; 
SF = 7.0; 
mu_AOD = 1.5; 
mu_AOA = 2.1; 
X_max = 0.5; 
mu_tau = 83;
minVoidInterval = 25; 
sigmaCluster = 3; 
Gamma = 51.0; 
sigmaSubpath = 6;
gamma = 15.5; 
mean_ZOD = -4.9; 
sigma_ZOD = 4.5; 
std_AOD_RMSLobeAzimuthSpread = 11.0;
std_AOD_RMSLobeElevationSpread = 3.0; 
distributionType_AOD = 'Gaussian'; 
mean_ZOA = 3.6; 
sigma_ZOA = 4.8; 
std_AOA_RMSLobeAzimuthSpread = 7.5;
std_AOA_RMSLobeElevationSpread = 6.0; 
distributionType_AOA = 'Laplacian';
% RMa LOS
elseif strcmp(sceType,'RMa') == true && strcmp(envType,'LOS') == true
% See the parameter definitions for UMi LOS
SF = 1.7; 
mu_AOD = 1; 
mu_AOA = 1;
X_max = 0.2; 
mu_tau = 123; 
minVoidInterval = 25; 
sigmaCluster = 1;
Gamma = 25.9; 
sigmaSubpath = 6; 
gamma = 16.9; 
mean_ZOD = -12.6;
sigma_ZOD = 5.9; 
std_AOD_RMSLobeAzimuthSpread = 8.5;
std_AOD_RMSLobeElevationSpread = 2.5;
distributionType_AOD = 'Gaussian'; 
mean_ZOA = 10.8; 
sigma_ZOA = 5.3;
std_AOA_RMSLobeAzimuthSpread = 10.5;
std_AOA_RMSLobeElevationSpread = 11.5;
distributionType_AOA = 'Laplacian';
% RMa NLOS
elseif strcmp(sceType,'RMa') == true && strcmp(envType,'NLOS') == true
% See the parameter definitions for UMi LOS
SF = 6.7; 
mu_AOD = 1; 
mu_AOA = 1; 
X_max = 0.5; 
mu_tau = 83;
minVoidInterval = 25; 
sigmaCluster = 3; 
Gamma = 51.0; 
sigmaSubpath = 6;
gamma = 15.5; 
mean_ZOD = -4.9; 
sigma_ZOD = 4.5; 
std_AOD_RMSLobeAzimuthSpread = 11.0;
std_AOD_RMSLobeElevationSpread = 3.0; 
distributionType_AOD = 'Gaussian'; 
mean_ZOA = 3.6; 
sigma_ZOA = 4.8; 
std_AOA_RMSLobeAzimuthSpread = 7.5;
std_AOA_RMSLobeElevationSpread = 6.0; 
distributionType_AOA = 'Laplacian';
end
%% Initialize various settings and parameters
% Structure containing generated CIRs
CIR_SISO_Struct = struct; 
CIR_MIMO_Struct = struct;
% Set plot status
plotStatus = true; 
% Set plot rotation status
plotRotate = false; 
% Determine if spatial plot is needed 
plotSpatial = true;
% Number of multipath components
nPath = zeros(N,1); 
% Best (i.e., smallest) directional path loss
PL_dir_best = zeros(N,1); 
% Directional PDP information
DirPDPInfo = []; 
% Omnidirectional PDP information
OmniPDPInfo = zeros(N,5);
% Run for each RX location, i.e., each channel realization
for CIRIdx = 1:N
clear powerSpectrum PL_dir DirRMSDelaySpread;

    %% Step 1: Generate T-R Separation distance (m) ranging from dmin - dmax.
    clear TRDistance; TRDistance = getTRSep(dmin,dmax);
    % Set dynamic range, i.e., maximum possible omnidirectional path loss 
    % in dB, according to T-R separation distance. If T-R separation 
    % distance is no larger than 500 m, then set dynamic range as 190 dB, 
    % otherwise set it to 220 dB.
    if TRDistance <= 500
        % Dynamic range in dB
        DR = 190;
    else
        DR = 220;
    end
    % Received power threshod in dBm
    Th = TXPower - DR;
    
    %% Step 2: Generate the total received omnidirectional power (dBm) and 
    % omnidirectional path loss (dB) 
    % non RMa, i.e., UMi or UMa
    if strcmp(sceType,'RMa') == false
    [Pr_dBm, PL_dB]= getRXPower(f,n,SF,TXPower,TRDistance,d0);
    % RMa LOS
    elseif strcmp(sceType,'RMa') == true && strcmp(envType,'LOS') == true 
        PL_dB = 20*log10(4*pi*d0*f*1e9/c) + 23.1*(1-0.03*((h_BS-35)/35))*log10(TRDistance) + SF*randn;
    % RMa NLOS
    elseif strcmp(sceType,'RMa') == true && strcmp(envType,'NLOS') == true 
        PL_dB = 20*log10(4*pi*d0*f*1e9/c) + 30.7*(1-0.049*((h_BS-35)/35))*log10(TRDistance) + SF*randn;
    end
    % Atmospheric attenuation factor
    attenFactor = mpm93_forNYU(f,p,u,t,RR);
    % Path loss incorporating atmospheric attenuation
    PL_dB = getAtmosphericAttenuatedPL(PL_dB,attenFactor,TRDistance);
    % Incorporating cross-polarization
    if strcmp(Pol,'X-Pol') == true
        PL_dB = PL_dB+25;
    end
    % Incorporating foliage loss
    if strcmp(Fol,'Yes') == true
        PL_dB = getFoliageAttenuatedPL(PL_dB,folAtt,dFol);
    end      
    % Calculate received power based on transmit power and path loss
    Pr_dBm = TXPower - PL_dB;
    % Free space path loss
    FSPL = 20*log10(4*pi*d0*f*1e9/c);
    % PLE
    PLE = (PL_dB-FSPL)/(10*log10(TRDistance/d0));
    
    %% Step 3: Generate the number of time clusters N, and number of AOD and
    % AOA spatial lobes
    [numberOfTimeClusters,numberOfAOALobes,numberOfAODLobes] = ...
        getNumClusters_AOA_AOD(mu_AOA,mu_AOD,sceType);
    
    %% Step 4: Generate the number of cluster subpaths M_n for each time cluster
    numberOfClusterSubPaths = getNumberOfClusterSubPaths(numberOfTimeClusters,sceType);
    
    %% Step 5: Generate the intra-cluster subpath delays rho_mn (ns)
    rho_mn = getIntraClusterDelays(numberOfClusterSubPaths,X_max);
    
    %% Step 6: Generate the phases (rad) for each cluster
    phases_mn = getSubpathPhases(rho_mn);
    
    %% Step 7: Generate the cluster excess time delays tau_n (ns)
    tau_n = getClusterExcessTimeDelays(mu_tau,rho_mn,minVoidInterval);
    
    %% Step 8: Generate temporal cluster powers (mW)
    clusterPowers = getClusterPowers(tau_n,Pr_dBm,Gamma,sigmaCluster,Th);
    
    %% Step 9: Generate the cluster subpath powers (mW)
    subpathPowers = ...
        getSubpathPowers(rho_mn,clusterPowers,gamma,sigmaSubpath,envType,Th);
    
    %% Step 10: Recover absolute propagation times t_mn (ns) of each subpath 
    % component
    t_mn = getAbsolutePropTimes(TRDistance,tau_n,rho_mn);
    
    %% Step 11: Recover AODs and AOAs of the multipath components
    [subpath_AODs, cluster_subpath_AODlobe_mapping] = ...
        getSubpathAngles(numberOfAODLobes,numberOfClusterSubPaths,mean_ZOD,...
        sigma_ZOD,std_AOD_RMSLobeElevationSpread,std_AOD_RMSLobeAzimuthSpread,...
        distributionType_AOD);
    [subpath_AOAs, cluster_subpath_AOAlobe_mapping] = ...
        getSubpathAngles(numberOfAOALobes,numberOfClusterSubPaths,mean_ZOA,...
        sigma_ZOA,std_AOA_RMSLobeElevationSpread,std_AOA_RMSLobeAzimuthSpread,...
        distributionType_AOA);
    
    %% Step 12: Construct the multipath parameters
    powerSpectrumOld = getPowerSpectrum_v1_1(numberOfClusterSubPaths,t_mn,subpathPowers,phases_mn,...
        subpath_AODs,subpath_AOAs,Th);
    %%
    % Adjust power spectrum according to RF bandwidth
    
    %%%%%%%%%% Modification in v 1.6.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % One more output variable "SubpathIndex" is added, which is not being
    % used currently. It is saved for possible future use.
    
    [powerSpectrum,numberOfClusterSubPaths, SubpathIndex] = ...
        getNewPowerSpectrum(powerSpectrumOld,RFBW);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % For LOS environment, adjust subpath AoDs and AoAs such that the AoD
    % and AoA of the LOS component are aligned properly
    if strcmp(envType,'LOS') == true
        % Calculate the correct azimuth AoA for LOS component, which should
        % differ from its azimuth AoD by 180 degrees
        % powerSpectrum(1,4) denotes the azimuth AoD for LOS component
        clear correctAzAOA;
        if powerSpectrum(1,4) - 180 > 0
            correctAzAOA = powerSpectrum(1,4) - 180;
        else
            correctAzAOA = powerSpectrum(1,4) + 180;
        end
        % Calculate the difference between the generated azimuth AoA and
        % the correct azimuth AoA
        % powerSpectrum(1,6) is the generated azimuth AoA for LOS component
        clear dAzAOA;
        dAzAOA = powerSpectrum(1,6) - correctAzAOA;
        % Do a global shift of azimuth AoAs
        powerSpectrum(:,6) = powerSpectrum(:,6) - dAzAOA;
        clear azAOA_temp;
        azAOA_temp = powerSpectrum(:,6);
        azAOA_temp(azAOA_temp < 0) = azAOA_temp(azAOA_temp < 0) + 360;
        powerSpectrum(:,6) = azAOA_temp; 
        % Calculate the correct elevation AoA for LOS component, which
        % should be the additive inverse of the corresponding elevation AoD
        clear correctElAOA;
        correctElAOA = -powerSpectrum(1,5); 
        % Calculate the difference between the generated elevation AoA and
        % the correct elevation AoA
        % powerSpectrum(1,7) is the generated elevation AoA for LOS component
        clear dElAOA;
        dElAOA = powerSpectrum(1,7) - correctElAOA;
        % Do a global shift of elevation AoAs
        powerSpectrum(:,7) = powerSpectrum(:,7) - dElAOA;
    end
    
    %% Construct the 3-D lobe power spectra at TX and RX
    %%%%%%%%%% Modification in v 1.6.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % In earlier versions, the program crashed when less than 800 MHz
    % bandwidth was specified by the user.
    %
    % v 1.6.1 fixed the problem of previous versions such that the number 
    % of resolvable MPCs decreases as the RF bandwidth is set to be
    % narrower than 800 MHz.
    %
    % However, the v 1.6.1 keeps the spatial resolution (angular information)
    % using 800 MHz RF channel bandwidth despite the user input. 
    % Here PowerSpectrumOld is used for plotting AOAs and AODs of all 
    % resolved MPCs of 800 MHz RF bandwidth regardless of the user bandwidth
    % input in v1.6.1.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    AOD_LobePowerSpectrum = getLobePowerSpectrum(numberOfAODLobes,cluster_subpath_AODlobe_mapping,powerSpectrumOld,'AOD');
    AOA_LobePowerSpectrum = getLobePowerSpectrum(numberOfAOALobes,cluster_subpath_AOAlobe_mapping,powerSpectrumOld,'AOA');

    %% Store CIR parameters
    % Multipath delay
    CIR.pathDelays = powerSpectrumOld(:,1);
    % Multipath power
    pathPower = powerSpectrumOld(:,2);
    clear indNaN; indNaN = find(pathPower<=10^(Th/10));
    pathPower(indNaN,:) = 10^(Th/10);
    CIR.pathPowers = pathPower;
    % Multipath phase
    CIR.pathPhases = powerSpectrumOld(:,3);
    % Multipath AOD
    CIR.AODs = powerSpectrumOld(:,4);
    % Multipath ZOD
    CIR.ZODs = powerSpectrumOld(:,5);
    % Multipath AOA
    CIR.AOAs = powerSpectrumOld(:,6);
    % Multipath ZOA
    CIR.ZOAs = powerSpectrumOld(:,7);
    % Various global information for this CIR
    % Carrier frequency
    CIR.frequency = freq;
    % Transmit power
    CIR.TXPower = TXPower;
    % Omnidirectional received power in dBm
    CIR.OmniPower = Pr_dBm;
    % Omnidirectional path loss in dB
    CIR.OmniPL = PL_dB;
    % T-R separation distance in meters
    CIR.TRSep = TRDistance;
    % Environment, LOS or NLOS
    CIR.environment = envType;
    % Scenario, UMi, UMa, or RMa
    CIR.scenario = sceType;
    % TX HPBW
    CIR.HPBW_TX = [theta_3dB_TX phi_3dB_TX];
    % RX HPBW
    CIR.HPBW_RX = [theta_3dB_RX phi_3dB_RX];  
    % Store
    CIR_SISO_Struct.(['CIR_SISO_',num2str(CIRIdx)]) = CIR;
    
    %%%%%%%%%%%%%% Modification in v1.6.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % getLocalCIR_new is modified to generate MIMO channel impulse
    % responses that is stored in CIR_MIMO. H_MIMO stores the CIRs of
    % MPCs resolved at user-specified bandwidth. H is the CIRs of all MPCs
    % resolved at 800 MHz (the widest bandwidth). 
    %
    % In the previous versions of NYUSIM, only the first TX antenna element
    % was used to generate H matrix. In v. 1.6.1, all TX antenna elements 
    % are used, and the H matrix is extended to have a size of Nt x Nr for 
    % each multipath.

    [CIR_MIMO,H,HPowers,HPhases,H_ensemble] = getLocalCIR_new(CIR,powerSpectrumOld,TxArrayType,RxArrayType,Nt,Nr,Wt,Wr,dTxAnt,dRxAnt,RFBW);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    CIR_MIMO_Struct.(['CIR_MIMO_',num2str(CIRIdx)]) = CIR_MIMO; H_MIMO = CIR_MIMO.H;
  
% Show the output figures for the first simulation run
    if CIRIdx == 1 
        FigVisibility = 'on'; 
    else 
        FigVisibility = 'off'; 
    end
%% Plotting    
if plotStatus == true
    AODPower_SphericalSpectrum = getSphericalSpectrum(powerSpectrumOld,'AOD',Th);
    AOAPower_SphericalSpectrum = getSphericalSpectrum(powerSpectrumOld,'AOA',Th);
    if plotSpatial == true
        %% Fig1: AOD Spherical Plot
        titleName = ['3-D AOD Power Spectrum - ',num2str(f),' GHz, ' sceType, ' ' envType, ', ',...
            num2str(TRDistance,'%.1f'),' m T-R Separation'];
        h1 = plotSpherical_Modular1(AODPower_SphericalSpectrum,titleName,envType,FigVisibility,Th); 
        
        %% Fig2: AOA Spherical Plot
        titleName = ['3-D AOA Power Spectrum - ',num2str(f),' GHz, ' sceType, ' ' envType, ', ',...
                    num2str(TRDistance,'%.1f'),' m T-R Separation'];
        h2 = plotSpherical_Modular1(AOAPower_SphericalSpectrum,titleName,envType,FigVisibility,Th);  
    else
    end
% Find time and power arrays                
timeArray = powerSpectrum(:,1); multipathArray = powerSpectrum(:,2); 
% Calculate the K-factor in dB for either LOS or NLOS
KFactor = 10*log10(max(multipathArray)/(sum(multipathArray)-max(multipathArray)));

%% Fig3: omnidirectional PDP
h3 = plotPDP(FigVisibility,timeArray,multipathArray,TRDistance,f,sceType,envType,PL_dB,PLE,Th);
% Total received power in linear
Pr_Lin = sum(multipathArray);
% Mean time delay
meanTau = sum(timeArray.*multipathArray)/sum(multipathArray);
% Mean squared time delay
meanTau_Sq=sum(timeArray.^2.*multipathArray)/sum(multipathArray);
% RMS delay spread
RMSDelaySpread = sqrt(meanTau_Sq-meanTau^2);
% Create rotational plot
if plotRotate == true
    xlabel('x')
    ylabel('y')
    zlabel('z')
    el = 10;
    aziArray = 0:1:360;
    for index = 1:length(aziArray)
        currentAzi = aziArray(index);
        set(hGca_AOA,'view',[currentAzi el])
        pause(0.01)
    end
else
end

%% Fig4: Directional PDP with the strongest received power

% Find TX-RX combination index with maximum received power
[maxP, maxIndex] = max(powerSpectrum(:,2));

% Desired TX-RX pointing angles
theta_TX_d = powerSpectrum(:,4);
phi_TX_d = powerSpectrum(:,5);
theta_RX_d = powerSpectrum(:,6);
phi_RX_d = powerSpectrum(:,7);

% Number of multiapth components
nPath(CIRIdx) = size(powerSpectrum,1);

% Compute directive gains for each multipath component
PL_dir = zeros(nPath(CIRIdx),1); 

% Directional PLE
PLE_dir = zeros(nPath(CIRIdx),1);

% Directional RMS delay spread
DirRMSDelaySpread = zeros(nPath(CIRIdx),1);
for q = 1:nPath(CIRIdx)
    % See the parameter definitions above
    [TX_Dir_Gain_Mat, RX_Dir_Gain_Mat, G_TX, G_RX] = ...
    getDirectiveGains(theta_3dB_TX,phi_3dB_TX,theta_3dB_RX,phi_3dB_RX,...
    theta_TX_d(q),phi_TX_d(q),theta_RX_d(q),phi_RX_d(q),powerSpectrum);
    [timeArray_Dir, multipathArray_Dir] = getDirPDP_v1_1(powerSpectrum,...
        TX_Dir_Gain_Mat,RX_Dir_Gain_Mat,G_TX,G_RX,TXPower);
    Pr_Lin_Dir = sum(multipathArray_Dir);
    meanTau = sum(timeArray_Dir.*multipathArray_Dir)/sum(multipathArray_Dir);
    meanTau_Sq=sum(timeArray_Dir.^2.*multipathArray_Dir)/sum(multipathArray_Dir);
    DirRMSDelaySpread(q) = sqrt(meanTau_Sq-meanTau^2);
    % Obtain directional path loss
    PL_dir(q) = TXPower-10*log10(Pr_Lin_Dir)+10*log10(G_TX)+10*log10(G_RX);
    % Obtain directional PLE
    PLE_dir(q) = (PL_dir(q)-FSPL)/(10*log10(TRDistance/d0));
end
Pr_Lin = sum(multipathArray);

% Get directive antenna gains
[TX_Dir_Gain_Mat, RX_Dir_Gain_Mat, G_TX, G_RX] = getDirectiveGains(theta_3dB_TX,...
    phi_3dB_TX,theta_3dB_RX,phi_3dB_RX,theta_TX_d(maxIndex),phi_TX_d(maxIndex),...
    theta_RX_d(maxIndex),phi_RX_d(maxIndex),powerSpectrum);

% Recover the directional PDP
[timeArray_Dir, multipathArray_Dir] = getDirPDP_v1_1(powerSpectrum,...
    TX_Dir_Gain_Mat,RX_Dir_Gain_Mat,G_TX,G_RX,TXPower);
Pr_Lin_Dir = sum(multipathArray_Dir);
meanTau = sum(timeArray_Dir.*multipathArray_Dir)/sum(multipathArray_Dir);
meanTau_Sq=sum(timeArray_Dir.^2.*multipathArray_Dir)/sum(multipathArray_Dir);

% Directional PDP
DirPDP = [timeArray_Dir', 10*log10(multipathArray_Dir')];
clear indNaN; indNaN = find(10.*log10(multipathArray_Dir')<=Th);
DirPDP(indNaN,:) = NaN;
h4 = plotDirPDP(FigVisibility,timeArray,timeArray_Dir,multipathArray_Dir,...
    Th,TRDistance,f,sceType,envType,maxIndex,DirRMSDelaySpread,Pr_Lin_Dir,...
    PL_dir,PLE_dir,theta_3dB_TX,phi_3dB_TX,theta_3dB_RX,phi_3dB_RX,TX_Dir_Gain_Mat,...
    RX_Dir_Gain_Mat);

%% Fig5: Small-scale PDPs        
figure('Visible',FigVisibility);
% Fontsize
FS = 12; 
% Time delay of multipath components
timeDelay = powerSpectrum(:,1); 

%%%%%%%%% Modification in v1.6.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Even though v 1.6.1 uses all TX antenna elements to generate H matrix, 
% for plotting purpose, only CIRs of the first TX antenna element with 
% all RX antenna elements are plotted in the small-scale PDP as in earlier 
% versions. We use H_MIMO_Plot here, not H_MIMO.

H_MIMO_Plot = zeros(length(H_MIMO),size(H_MIMO{1,1},1));
for i = 1:length(H_MIMO)
   H_temp = H_MIMO{i,1}; 
   H_MIMO_Plot(i,:) = H_temp(:,1);
end

Pr_H = 10.*log10((abs(H_MIMO_Plot)).^2) + TXPower; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If the received power is smaller than the threshold, set it to the threshold
Pr_H(Pr_H<Th) = Th;
% Create time delay axis
fakeTime = [min(timeDelay)+1:1:1.1*max(timeDelay)]'; 
fakePr = Th.*ones(length(fakeTime),Nr);
% fakePr = NaN.*ones(length(fakeTime),Nr);
allTime = [timeDelay;fakeTime]; 
allPr = [Pr_H;fakePr];
% Sort time and power for plotting purposes
[allTime_sort,I] = sort(allTime,'ascend'); 
allPr_sort = allPr(I,:);
X = (repmat([1:Nr],length(allTime_sort),1)-1)./2; Y = repmat(allTime_sort,1,Nr);
if max(max(allPr)) > Th
stem3(X,Y,allPr_sort,'BaseValue',Th,'LineStyle','-','Marker','none',...
    'linewidth',1.5,'color','b');
else
    text(0.18,0.6,['No Detectable Multipath Components',char(10),'above the Threshold of ',num2str(Th),' dBm'],...
        'Units','normalized','fontsize',15,'fontweight','bold');
end
xlabel('Increment (# of Wavelengths)','fontsize',FS); 
ylabel('Propagation Time Delay (ns)','fontsize',FS);
zlabel('Received Power (dBm)','fontsize',FS);
xh = get(gca,'XLabel'); set(xh, 'Units', 'Normalized'); 
pos = get(xh, 'Position'); set(xh, 'Position',pos.*[1.1,-0.5,0],'Rotation',15);
yh = get(gca,'YLabel'); set(yh, 'Units', 'Normalized'); 
pos = get(yh, 'Position'); set(yh, 'Position',pos.*[0.7,-0.6,0],'Rotation',-25);
set(gca,'Ydir','reverse'); 
set(gca,'fontsize',FS); 
zlim([Th max(max(max(allPr)),Th)+1]);
title(['Small Scale PDPs - ',num2str(f),' GHz, ' num2str(RFBW),' MHz, ', sceType,' ',envType,' ',...
    num2str(TRDistance,'%.1f'),' m T-R Separation']); 
h5 = gcf;  

else
end

%% Save output figures
cd NYUSIM_OutputFolder;
saveas(h1,['AOD_Run',num2str(CIRIdx),'.png']);
saveas(h2,['AOA_Run',num2str(CIRIdx),'.png']); 
saveas(h3,['OmniPDP_Run',num2str(CIRIdx),'.png']); 
saveas(h4,['DirPDP_Run',num2str(CIRIdx),'.png']);
saveas(h5,['SmallScalePDP_Run',num2str(CIRIdx),'.png']);
OmniPDP = [timeArray,10.*log10(multipathArray)];
clear indNaN; indNaN = find(10.*log10(multipathArray)<=Th);
OmniPDP(indNaN,:) = NaN;
% Close the figure files for all simulation runs except the first one
if CIRIdx > 1
    close(h1); close(h2); close(h3); close(h4); close(h5);
end
%%% Save output data on directional information in both .txt and .mat
%%% formats for each simulation run
SNames = fieldnames(AOD_LobePowerSpectrum); 
for m = 1:numberOfAODLobes
    dlmwrite(['AODLobePowerSpectrum' sprintf('%d',CIRIdx) '_Lobe' sprintf('%d',m) '.txt'],...
        AOD_LobePowerSpectrum.(SNames{m}),'delimiter', '\t', 'newline', 'pc');
    save(['AODLobePowerSpectrum' sprintf('%d',CIRIdx)],'AOD_LobePowerSpectrum');
end
clear SNames m; SNames = fieldnames(AOA_LobePowerSpectrum); 
for m = 1:numberOfAOALobes
    dlmwrite(['AOALobePowerSpectrum' sprintf('%d',CIRIdx) '_Lobe' sprintf('%d',m) '.txt'],...
        AOA_LobePowerSpectrum.(SNames{m}),'delimiter', '\t', 'newline', 'pc');
    save(['AOALobePowerSpectrum' sprintf('%d',CIRIdx)],'AOA_LobePowerSpectrum');
end
dlmwrite(['OmniPDP' sprintf('%d',CIRIdx) '.txt'],OmniPDP,'delimiter', '\t', 'newline', 'pc');
dlmwrite(['DirectionalPDP' sprintf('%d',CIRIdx) '.txt'],DirPDP,'delimiter', '\t', 'newline', 'pc');
Tra = reshape(X,[],1); Delay = reshape(Y,[],1); traPr = reshape(allPr_sort,[],1);
smallScalePDP = [Tra Delay traPr];
clear indNaN; indNaN = find(traPr<=Th);
smallScalePDP(indNaN,2:3) = NaN;
dlmwrite(['SmallScalePDP' sprintf('%d',CIRIdx) '.txt'],smallScalePDP,'delimiter', '\t', 'newline', 'pc');
save(['OmniPDP' sprintf('%d',CIRIdx)],'OmniPDP');
save(['DirectionalPDP' sprintf('%d',CIRIdx)],'DirPDP');
save(['SmallScalePDP' sprintf('%d',CIRIdx)],'smallScalePDP');
% Obtain omnidirectional PDP information for this simulation run
OmniPDPInfo(CIRIdx,1:5) = [TRDistance Pr_dBm PL_dB RMSDelaySpread,KFactor];
if PL_dB > DR
    OmniPDPInfo(CIRIdx,2:5) = NaN;
end
% Convert the received power from linear to dB
powerSpectrum(:,2) = 10.*log10(powerSpectrum(:,2));
if CIRIdx == 1
    DirPDPInfo(1:nPath(CIRIdx),1:11) = [CIRIdx*ones(nPath(CIRIdx),1) TRDistance*ones(nPath(CIRIdx),1) powerSpectrum PL_dir DirRMSDelaySpread];
else
    DirPDPInfo(sum(nPath(1:CIRIdx-1))+1:sum(nPath(1:CIRIdx)),1:11) = ...
        [CIRIdx*ones(nPath(CIRIdx),1) TRDistance*ones(nPath(CIRIdx),1) powerSpectrum PL_dir DirRMSDelaySpread];
end
PL_dir_best(CIRIdx) = min(PL_dir);
if PL_dir_best(CIRIdx) >= DR
    PL_dir_best(CIRIdx) = 0;
end
cd(runningFolder);
end % end of CIRIdx
% Find the index of omnidirectional path loss no larger than the dynamic
% range
indOmniPL = find(~isnan(OmniPDPInfo(:,3)));
% Find the index of directional path loss larger than the dynamic range
IndDirNaN = find(DirPDPInfo(:,4)<=Th);
DirPDPInfo(IndDirNaN,3:11) = NaN;
indDirPL = find(~isnan(DirPDPInfo(:,10)));
% if numel(indOmniPL) ~= 0
% T-R separation distance
omniDist = OmniPDPInfo(indOmniPL,1); 
% Omnidirectional path loss
omniPL = OmniPDPInfo(indOmniPL,3);
% end
% T-R separation distance
dirDist = DirPDPInfo(indDirPL,2);
% Directional path loss
dirPL = DirPDPInfo(indDirPL,10);
% Smallest directional path loss
% PL_dir_best = PL_dir_best(indDirPL);
%%% Plot omnidirectional and directional path loss for all continuous
%%% simulation runs performed
h7 = plotPL(FSPL,omniPL,omniDist,dirPL,dirDist,PL_dir_best,f,sceType,envType,d0,theta_3dB_TX,...
    phi_3dB_TX,TX_Dir_Gain_Mat,theta_3dB_RX,phi_3dB_RX,RX_Dir_Gain_Mat,Th);
cd NYUSIM_OutputFolder;
saveas(h7,['PathLossPlot.png']); 
%%% Save output data on omnidirectional information in both .txt and .mat
%%% formats for all continuous simulation runs performed
save('OmniPDPInfo','OmniPDPInfo'); 
%%% Save output data on directional information in both .txt and .mat
%%% formats for all continuous simulation runs performed
save('DirPDPInfo','DirPDPInfo');
% Basic channel parameters; the parameters have the same definitions as the input parameters
BasicParameters = struct;
BasicParameters.Frequency = f; 
BasicParameters.Bandwidth = RFBW; 
BasicParameters.TXPower = TXPower;
BasicParameters.Environment = envType; 
BasicParameters.Scenario = sceType;
if strcmp(sceType,'RMa') == true
    BasicParameters.TXHeight = h_BS;
end
BasicParameters.Pressure = p; 
BasicParameters.Humidity = u;
BasicParameters.Temperature = t; 
BasicParameters.RainRate = RR;
BasicParameters.Polarization = Pol; 
BasicParameters.Foliage = Fol;
BasicParameters.DistFol = dFol; 
BasicParameters.FoliageAttenuation = folAtt;
BasicParameters.TxArrayType = TxArrayType; 
BasicParameters.RxArrayType = RxArrayType;
BasicParameters.NumberOfTxAntenna = Nt; 
BasicParameters.NumberOfRxAntenna = Nr;
BasicParameters.NumberOfTxAntennaPerRow = Wt; 
BasicParameters.NumberOfRxAntennaPerRow = Wr;
BasicParameters.TxAntennaSpacing = dTxAnt; 
BasicParameters.RxAntennaSpacing = dRxAnt; 
BasicParameters.TxAzHPBW = theta_3dB_TX; 
BasicParameters.TxElHPBW = phi_3dB_TX; 
BasicParameters.RxAzHPBW = theta_3dB_RX; 
BasicParameters.RxElHPBW = phi_3dB_RX;
% Save BasicParameters as .mat file
save(['BasicParameters.mat'],'BasicParameters');
% Save BasicParameters as .txt file
file_name = ['BasicParameters.txt'];
fid = fopen(file_name,'wt');
if strcmp(sceType,'RMa') == true
fprintf(fid, '%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t',...
    'Frequency (GHz)','Bandwidth (MHz)','TXPower (dBm)',...
    'Environment','Scenario','TXHeight',...
    'Pressure (mBar)','Humidity','Temperature (Celsius)','RainRate (mm/hr)','Polarization','Foliage','DistFol (m)','FoliageAttenuation (dB)',...
    'TxArrayType','RxArrayType','#TXElements','#RXElements','TXAziHPBW','TXElvHPBW','RXAziHPBW','RXElvHPBW'); 
fprintf(fid,'\n%12.1f\t%12.0f\t%12.1f\t%12s\t%13s\t%13.2f\t%13.2f\t%12.0f\t%12.1f\t%12.1f\t%12s\t%12s\t%12.1f\t%12.0f\t%12s\t%12s\t%12.0f\t%12.0f\t%12.0f\t%12.0f\t%12.0f\t%12.0f',...
    f,RFBW,TXPower,envType,sceType,h_BS,p,u,t,RR,Pol,Fol,dFol,folAtt,...
    TxArrayType,RxArrayType,Nt,Nr,theta_3dB_TX,phi_3dB_TX,theta_3dB_RX,phi_3dB_RX);
else
    fprintf(fid, '%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t',...
    'Frequency (GHz)','Bandwidth (MHz)','TXPower (dBm)',...
    'Environment','Scenario',...
    'Pressure (mBar)','Humidity','Temperature (Celsius)','RainRate (mm/hr)','Polarization','Foliage','DistFol (m)','FoliageAttenuation (dB)',...
    'TxArrayType','RxArrayType','#TXElements','#RXElements','TXAziHPBW','TXElvHPBW','RXAziHPBW','RXElvHPBW'); 
    fprintf(fid,'\n%12.1f\t%12.0f\t%12.1f\t%12s\t%13s\t%13.2f\t%12.0f\t%12.1f\t%12.1f\t%12s\t%12s\t%12.1f\t%12.0f\t%12s\t%12s\t%12.0f\t%12.0f\t%12.0f\t%12.0f\t%12.0f\t%12.0f',...
    f,RFBW,TXPower,envType,sceType,p,u,t,RR,Pol,Fol,dFol,folAtt,...
    TxArrayType,RxArrayType,Nt,Nr,theta_3dB_TX,phi_3dB_TX,theta_3dB_RX,phi_3dB_RX);
end
fclose(fid);
% Save OmniPDPInfo as .txt file
file_name = ['OmniPDPInfo.txt'];
fid = fopen(file_name,'wt');
fprintf(fid, '%12s\t%12s\t%12s\t%12s\t%12s\t',...
    'T-R Separation Distance (m)','Received Power (dBm)','Path Loss (dB)','RMS Delay Spread (ns)','K-Factor (dB)'); 
fprintf(fid,'\n%15.1f\t%25.1f\t%15.1f\t%15.1f\t%20.1f',OmniPDPInfo.'); 
fclose(fid);
% Save DirPDPInfo as .txt file
file_name = ['DirPDPInfo.txt'];
fid = fopen(file_name,'wt');
fprintf(fid, '%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t%12s\t',...
    'Simulation Run Number','T-R Separation Distance (m)','Time Delay (ns)','Received Power (dBm)','Phase (rad)',...
    'Azimuth AoD (degree)','Elevation AoD (degree)','Azimuth AoA (degree)','Elevation AoA (degree)',...
    'Path Loss (dB)','RMS Delay Spread (ns)'); 
fprintf(fid,'\n%15.1f\t%15.1f\t%20.0f\t%17.1f\t%13.1f\t%15.0f\t%17.1f\t%17.1f\t%17.0f\t%17.1f\t%17.1f',...
    DirPDPInfo.'); 
fclose(fid);
cd(runningFolder)
%%%
toc