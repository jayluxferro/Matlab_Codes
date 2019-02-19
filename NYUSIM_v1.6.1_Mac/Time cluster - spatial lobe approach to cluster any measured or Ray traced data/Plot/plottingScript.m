% Copyright © 2016 NYU

% Plot the PDP and power angular spectrum for given delay and angle
% resolutions


% Extract the unbinned data, keeping only paths with powers -20 dB below
% max peak
linkInfo_Unbinned = outStruct.linkData{linkIdx}.linkData;
pathPowers_Unbinned = linkInfo_Unbinned(:,2);
indKeep = pathPowers_Unbinned >= max(pathPowers_Unbinned) - 20;
aoas_unbinned = linkInfo_Unbinned(indKeep,6);
zoas_unbinned = linkInfo_Unbinned(indKeep,7);


% Time Cluster Plot
linkInfo = outStruct.linkData{linkIdx}.(['Scenario_',num2str(delayRes),'ns_',num2str(angleRes),'deg']);
figure
hold all
box on
numberOfTC = linkInfo.TimeClusterStats.NumOfTimeClusters;       
for clusterIdx = 1:numberOfTC   
    clusterCIR = linkInfo.TimeClusterStats.(['TimeCluster_',num2str(clusterIdx)]);
    pathDelays = clusterCIR.subpathTimes;
    pathPowers = clusterCIR.subpathPowers;    
    plot(pathDelays,10*log10(pathPowers),'x')
end
xlabel('Excess Time Delay (ns)')
ylabel('Multipath Powers (dBm)')
title(['CIR #',num2str(linkIdx),' | Delay Res.: ',num2str(delayRes),' ns | ',num2str(numberOfTC),' Time Clusters'])

% Power Angular Spectrum
figure
hold all
box on
numberOfSL = linkInfo.SpatialLobeStats.NumOfLobes;
for lobeIdx = 1:numberOfSL
    
    lobeSpectrum = linkInfo.SpatialLobeStats.(['Lobe_',num2str(lobeIdx)]).lobeSpectrum_perAngularBin;
    hBinned = plot(lobeSpectrum(:,2),lobeSpectrum(:,3),'x');
    hUnbinned = plot(aoas_unbinned,zoas_unbinned,'.');
end
hLeg = legend([hUnbinned,hBinned],'Unbinned Data','Binned Data','location','northeast');
xlim([-180 180])
ylim([0 180])
xlabel('Azimuth (deg)')
ylabel('Elevation (deg)')
title(['CIR #',num2str(linkIdx),' | Angle Res.: ',num2str(angleRes),' deg. | ',num2str(numberOfSL),' Spatial Lobes'])

