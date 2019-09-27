function outStruct = DelayAngleBinning(outStruct,delayRes,angleRes)
% Applying a binning algorithm upon the unbinned data, in delay and angle 
% (azimuth and elevation).
%
% Inputs:
%   - outStruct: structure containing CIR link information
%   - delayRes: delay resolution, in ns
%   - angleRes: angular resolution, in degrees
% Output: 
%   - outStruct: structure containing the binned data for the specified
%   delay and angular resolutions (delayRes,angleRes)
%
% Copyright © 2016 NYU

    numOfLinks = numel(outStruct.linkData);

    for locIdx = 1:numOfLinks
                       
        linkInfo = cell2mat(outStruct.linkData{locIdx}.linkData);
        
        % extract delays, pathPowers, angles
        delays_temp = linkInfo(:,1);
        pathPowers_temp = 10.^(linkInfo(:,2)/10);
        pathPhases_temp = linkInfo(:,3);
        pathAODAzi_temp = linkInfo(:,4);
        pathAODEl_temp = linkInfo(:,5);
        pathAOAAzi_temp = linkInfo(:,6);
        pathAOAEl_temp = linkInfo(:,7);        
        
        % create array of delays for binning
        delays_binned = 0:delayRes:(max(delays_temp)+delayRes);      
        
        % find strongest Azi/El angle
        [maxVal, maxIdx] = max(pathPowers_temp);
        strongestAziAngle = pathAOAAzi_temp(maxIdx);
        strongestElAngle = pathAOAEl_temp(maxIdx); 

        % create the array of azimuth angles, centered around the
        % strongest azimuth angle
        aziAngles_binned = unique(mod((strongestAziAngle:angleRes:(strongestAziAngle+360))',360),'rows');   
        aziAngles_binned(aziAngles_binned > 180) = aziAngles_binned(aziAngles_binned > 180) - 360;        
        
        % create the array of elevation angles, centered around the
        % strongest elevation angle
        elAngles_binned = unique(mod(strongestElAngle:angleRes:(strongestElAngle+180),180)','rows');
        
        % initialize a 3-D array, that contains the voltage information
        % for each bin, where a bin is described by a delay bin, an
        % azimuth angle bin, and an elevation angle bin)
        voltageSpectrum = zeros(numel(delays_binned),numel(aziAngles_binned),numel(elAngles_binned));
        
        % for each path 
        for pathIdx = 1:numel(pathPowers_temp)            
            currentPathPower = pathPowers_temp(pathIdx);
            currentPathDelay = delays_temp(pathIdx);
            currentPathAzi = pathAOAAzi_temp(pathIdx);
            currentPathEl = pathAOAEl_temp(pathIdx);
            currentPathPhase = pathPhases_temp(pathIdx);
            
            %%% find indices of closest bin for the current path
            [minVal,minAziIdx] = min(abs(currentPathAzi-aziAngles_binned));
            [minVal,minElIdx] = min(abs(currentPathEl-elAngles_binned));
            [minVal,minTimeIdx] = min(abs(delays_binned-currentPathDelay));
            
            %%% update and store voltage information in the correct bin
            previousBinVoltage = voltageSpectrum(minTimeIdx,minAziIdx,minElIdx);
            currentBinVoltage = previousBinVoltage + sqrt(currentPathPower).*exp(1i*currentPathPhase);
            voltageSpectrum(minTimeIdx,minAziIdx,minElIdx) = currentBinVoltage;
        end
        
        % find indices of non-zero elements
        ind = find(voltageSpectrum);
        [i1, i2, i3] = ind2sub(size(voltageSpectrum), ind);        
        
        numOfPaths = numel(i1);
        linkData_Binned = zeros(numOfPaths,7);

        % construct the binned data set array
        for pathIdx = 1:numOfPaths            
            currentDelay = delays_binned(i1(pathIdx));
            currentAzi = aziAngles_binned(i2(pathIdx));
            currentEl = elAngles_binned(i3(pathIdx));            
            currentPower = abs(voltageSpectrum(i1(pathIdx),i2(pathIdx),i3(pathIdx)))^2;
            currentPhase = angle(voltageSpectrum(i1(pathIdx),i2(pathIdx),i3(pathIdx)));
            linkData_Binned(pathIdx,:) = [currentDelay 10*log10(currentPower) currentPhase nan nan currentAzi currentEl];
        end
        
        % store and output
        if delayRes == 0 && angleRes == 0
            linkData_Binned = linkInfo;
        else
        end
        outStruct.linkData{locIdx}.(['linkData_Binned_',num2str(delayRes),'ns_',num2str(angleRes),'deg']) = num2cell(linkData_Binned);
        outStruct.linkData{locIdx}.StrongestAziEl = [strongestAziAngle strongestElAngle]; 
        
    end%% end of locIdx


end