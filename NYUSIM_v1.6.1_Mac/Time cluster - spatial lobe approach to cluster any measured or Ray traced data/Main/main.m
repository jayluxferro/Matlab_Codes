% This script runs the TCSL algorithm on the Intel grid and route data
% sets.
%
% Developed by Mathew K. Samimi - NYU WIRELESS, 16 February 2016
%
% Note: the user can place the measurement data files in the 'TCSL
% Clustering\Files' folder, and write a script that uploads the data into
% MATLAB in appropriate format, similar to TCSL
% Clustering\ReadFiles\nyu_dataUpload.m
%
% The provided MATLAB code operates on 28 GHz and 73 GHz channel
% measurement data collected by NYU. More information on these measurements
% can be found in the references below.
%
% Variable inputs to this script:
%   dataSet, numOfSamples, lobeThreshold, minVoidInterval
%
% Output of this script:
% [dataSet,'_TCSL.mat']
%
% Copyright © 2016 NYU
%
% [1] M. Samimi et al., "28 GHz Angle of Arrival and Angle of Departure 
% Analysis for Outdoor Cellular Communications Using Steerable Beam 
% Antennas in New York City," in 2013 IEEE  Vehicular Technology 
% Conference (VTC Spring), pp.1-6, 2-5 June 2013.
% URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6691812&isnumber=6691801
% 
% [2] M. K. Samimi, T. S. Rappaport, "Ultra-wideband statistical channel
% model for non line of sight millimeter-wave urban channels," in 2014
% IEEE Global Communications Conference (GLOBECOM), pp. 3483-3489, 8-12
% Dec. 2014.
% URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7037347&isnumber=7036769
% 
% [3] M. K. Samimi, T. S. Rappaport, "3-D statistical channel model for
% millimeter-wave outdoor mobile broadband communications," 2015 IEEE 
% International Conference on in Communications (ICC), pp.2430-2436, 
% 8-12 June 2015.
% URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7248689&isnumber=7248285
% 
% [4] M. K. Samimi, T. S. Rappaport, “Statistical Channel Model with 
% Multi-Frequency and Arbitrary Antenna Beamwidth for Millimeter-Wave
% Outdoor Communications,” in 2015 IEEE Global Communications Conference,
% Exhibition & Industry Forum (GLOBECOM) Workshop, Dec. 6-10, 2015.
% URL: http://arxiv.org/abs/1510.03081
% 
% [5] M. K. Samimi, T. S. Rappaport, “28 GHz Millimeter-Wave Ultrawideband 
% Small-Scale Fading Models in Wireless Channels,” in 2016 IEEE 
% Vehicular Technology Conference (VTC2016-Spring), 15-18 May, 2016.
% URL: http://arxiv.org/abs/1511.06938
% 
% [6] M. K. Samimi, S. Sun, and T. S. Rappaport, “MIMO Channel Modeling 
% and Capacity Analysis for 5G Millimeter-Wave Wireless Systems,” in 
% the 10th European Conference on Antennas and Propagation (EuCAP’2016), 
% April 2016.
% URL: http://arxiv.org/abs/1511.06940
% 
% [7] M. K. Samimi, T. S. Rappaport, “Local Multipath Model Parameters for 
% Generating 5G Millimeter-Wave 3GPP-like Channel Impulse Response,”
% in the 10th European Conference on Antennas and Propagation (EuCAP’2016),
% April 2016.
% URL: http://arxiv.org/abs/1511.06941

clear 
clc
close all

% master folder, and add path to all underlying subfolders
runningFolder = pwd;
wordToFind = 'TCSL Clustering - 160216';
indStop = strfind(runningFolder,wordToFind)+length(wordToFind)-1;
masterFolder = runningFolder(1:indStop);
cd(masterFolder)
addpath(genpath(masterFolder));

% folder where resulting matlab file is placed
resultsFolder = [masterFolder,'\Results'];

% valid inputs for dataSet: 
%   - '28_GHz_NLOS'
%   - '28_GHz_LOS'
%   - '73_GHz_NLOS'
%   - '73_GHz_LOS'
dataSet = '73_GHz_NLOS';
dataFolder = [masterFolder,'\Files\NYU data\',dataSet];
disp('Load Data.')

delayResolution_Array = [0 2 10 20]; %% ns
angleResolution_Array = [0 5 10 20]; %% deg 
% Note: (0 ns, 0 deg) corresponds to the un-binned scenario,
% in other words, the measurement resolution (2.5 ns, 10 deg)

tic
% Number of links to process
% setting numOfSamples = 0 loads all available data
numOfSamples = 0; 
nyu_dataUpload
disp('Load Data Done.')
%% Perform the binning
disp('Begin the binning.')
       
for resIdx = 1:numel(delayResolution_Array)

    % perform binning
    delayRes = delayResolution_Array(resIdx);
    angleRes = angleResolution_Array(resIdx);
    [delayRes angleRes]
      
    outStruct = DelayAngleBinning(outStruct,delayRes,angleRes);

end%%end of resIdx       
disp('Binning Done.')

%% Extract TC and SL statistics
clc
close all
disp('Extract TC-SL Statistics.')
numberOfLinks = numel(outStruct.linkData);

% minimum inter-cluster void interval (ns)
minVoidInterval = 25;

% lobe threshold (dB)
lobeThreshold = -20;

for resIdx = 1:numel(delayResolution_Array)
    
    delayRes = delayResolution_Array(resIdx);
    angleRes = angleResolution_Array(resIdx);

    for linkIdx = 1:numberOfLinks
        
        if mod(linkIdx,100) == 0
            linkIdx
        else
        end

        % extract link parameters
        linkData = outStruct.linkData{linkIdx}.(['linkData_Binned_',num2str(delayRes),'ns_',num2str(angleRes),'deg']);
                 
        % extract TC stats
        PDP_Info_Struct = TimeClustering(linkData,minVoidInterval);
        outStruct.linkData{linkIdx}.(['Scenario_',num2str(delayRes),'ns_',num2str(angleRes),'deg']).TimeClusterStats = PDP_Info_Struct;
        
        % generate and store the lobe spectra here for output
        lobeSpectra_struct = SpatialLobeClustering(outStruct,linkData,lobeThreshold,angleRes);
        outStruct.linkData{linkIdx}.(['Scenario_',num2str(delayRes),'ns_',num2str(angleRes),'deg']).SpatialLobeStats = lobeSpectra_struct;
        
    end%%end of linkIdx
       
end%% end of resIdx
disp('Extract TC-SL Statistics, Done.')
toc
%% Save structure for later processing of statistics
prompt = 'Would you like to save the results? Y/N\n';
str = input(prompt,'s');
switch str
    case 'Y'
        disp('Saving Data...')
        cd(resultsFolder) 
        saveName = [dataSet,'_TCSL'];
        save(saveName,'outStruct','-v7.3')
        disp('Data Saved.')
    case 'N'
        disp('Data Not Saved.')
otherwise 
end






