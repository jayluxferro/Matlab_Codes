function lobeSpectrum_struct = SpatialLobeClustering(outStruct,linkData,lobeThreshold,angleRes)
% Extract spatial lobe statistics, based on a predefined lobe power threshold
%
% Inputs:
%   - linkData: structure containing CIR information
%   - lobeThreshold: threshold with respect to strongest angular bin,
%   typically -20 dB.
%   - angleRes: angular resolution, in degrees.%
% Output:
%   - lobeSpectrum_struct: structure containing spatial lobe information 
%
% Copyright © 2016 NYU


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

    linkData = cell2mat(linkData);
    pathPowers = 10.^(linkData(:,2)/10);
    pathAOAAzi =  linkData(:,6);
    pathAOAEl = linkData(:,7); 
    pathDelays = linkData(:,1);

    % rotate the angular spectrum, so that angles are integers
    % (easier processing, and no loss of generality)
    angleOffset_Azi = round(pathAOAAzi(1)) - pathAOAAzi(1);
    pathAOAAzi_int = round(pathAOAAzi+angleOffset_Azi);            
    angleOffset_El = round(pathAOAEl(1)) - pathAOAEl(1);
    pathAOAEl_int = round(pathAOAEl + angleOffset_El);

    % rename angles with the integer angles
    tau_l_temp = pathDelays;
    P_l_temp = pathPowers;
    az_l_temp = pathAOAAzi_int;
    az_l_temp ( az_l_temp >= 180 ) =  az_l_temp ( az_l_temp >= 180 ) - 360;
    zen_l_temp = pathAOAEl_int;

    switch outStruct.dataType
        case 'measurements'
                if angleRes == 0
                    deltaAZ = outStruct.angleRes_deg;
                    deltaZEN = outStruct.angleRes_deg;
                else
                    deltaAZ = angleRes;
                    deltaZEN = angleRes; 
                end
        case 'raytracing'
            deltaAZ = angleRes;
            deltaZEN = angleRes; 
    otherwise
    end

    if strcmp(outStruct.dataType,'raytracing') == true & angleRes == 0
        lobeSpectrum_struct = [];
    elseif angleRes == 0
        lobeSpectrum_struct = [];
    else
    
        % construct the sampled time-integrated spectrum
        az_zen_unique = unique([az_l_temp zen_l_temp],'rows');

        % initialize power array that keeps track of angular bin data
        P_l = zeros(size(az_zen_unique,1),1);

        % compute the bin powers
        for angleCombinationIdx = 1:size(az_zen_unique,1)                
            currentAzi = az_zen_unique(angleCombinationIdx,1);
            currentEl = az_zen_unique(angleCombinationIdx,2);

            indSameAngularBin = az_l_temp == currentAzi & zen_l_temp == currentEl;
            P_l(angleCombinationIdx) = sum(P_l_temp(indSameAngularBin));
        end%%end of angleCombinationIdx

        % sampled bin angles
        az_l = az_zen_unique(:,1);
        zen_l = az_zen_unique(:,2);

        % define lobe threshold (-20 dB below maximum local peak
        % power)
        lobeThreshold_dB = max(10*log10(P_l)) + lobeThreshold;

        % elements above lobe power threshold
        indAboveThreshold = find(10*log10(P_l)>=lobeThreshold_dB);

        % extract angle bins whose powers are above defined lobe
        % threshold
        thresholded3DSpectrum = [10*log10(P_l(indAboveThreshold)) az_l(indAboveThreshold) zen_l(indAboveThreshold)];            

        % extract angles with powers above threshold
        AOAs = thresholded3DSpectrum(:,2);
        AOAs (AOAs >= 180) = AOAs (AOAs >= 180) - 360;
        ZOAs = thresholded3DSpectrum(:,3);

        % limits of angular domain (deg)
        minEL = min(zen_l);
        maxEL = max(zen_l);

        angleArray = unique(mod(AOAs(1):deltaAZ:(AOAs(1)+360-deltaAZ),360)','rows');    
        minAzi = min(angleArray);

        numberOfZOAPlanes = (maxEL - minEL + deltaZEN) / deltaZEN;
        numberOfAOAAngles = 360/deltaAZ;         

        % dummy variable to remove circular 2pi shift ambiguity
        delta_Array = 0:deltaAZ:(360-deltaAZ);

        %%% store all lobe number corresponding to each Delta
        numberOfLobes_temp = zeros(numel(delta_Array),2);
        minEl = min(ZOAs);

        % store the index maps here
        L_struct = struct;

        for deltaIndex = 1:numel(delta_Array)
            % extract current delta (dummy angle)
            delta = delta_Array(deltaIndex);         

            % create a binary map, with 0 or 1, where 1 denotes the presence
            % of a power level above lobe threshold
            binaryMap_Temp = zeros(numberOfZOAPlanes,numberOfAOAAngles);
            for pointIndex = 1:numel(AOAs)
                % extract azi and el
                currentAzi = mod(AOAs(pointIndex)+delta,360);
                currentEl = ZOAs(pointIndex);

                % convert angles to indices
                aziIndex = (currentAzi - minAzi)/deltaAZ + 1;
                elIndex = (currentEl - minEl)/deltaZEN + 1;

                % store
                binaryMap_Temp(elIndex,aziIndex) = 1;
            end%%end of pointIndex for loop

            % convert map to logical map
            binaryMap = logical(binaryMap_Temp);

            % finds the thresholding
            numberOfConnectedObjects = 8;
            L = bwlabel(binaryMap,numberOfConnectedObjects);
            L_struct.(['DeltaShift_',num2str(delta)]) = L;

            % extract the number of 3-D lobes
            numberOf3DLobes_Temp = max(max(L));
            numberOfLobes_temp(deltaIndex,:) = [delta numberOf3DLobes_Temp];

        end%%end of deltaIndex for loop

        % extract number of the optimal number of spatial lobes
        [minVal, minIndex] = min(numberOfLobes_temp(:,2));
        number3DLobes = numberOfLobes_temp(minIndex,2);

        % optimal dummy delta (usual 0 degrees, but not always). 
        delta_opt = numberOfLobes_temp(minIndex,1);

        % structure containing spatial lobe information
        lobeSpectrum_struct = struct;
        lobeSpectrum_struct.NumOfLobes = number3DLobes;

        % for each lobe, find the angular spectrum
        for lobeNumber = 1:number3DLobes
           lobeSpectrum = struct;

           % find location of lobe #lobeNumber 
           [elIndices, aziIndices] = find(L_struct.(['DeltaShift_',num2str(delta_opt)]) == lobeNumber);

           % convert indices back to angles (accounting for optimal
           % delta)
           ElAngles = deltaZEN*(elIndices-1)+minEl;
           AziAngles = deltaAZ*(aziIndices-1)+minAzi-delta_opt;
           AziAngles(AziAngles >= 180) = AziAngles(AziAngles >= 180) - 360;

           % number of segments in the lobe
           numberOfLobeSegments = numel(ElAngles);

           % initialize matrix that contains path powers and angles
           lobeSpectrum_sampled = [];
           lobeSpectrum_perPath = [];
           lobeSpectrum_sampled_int = [];
           lobeSpectrum_int_perPath = [];

           % find the powers for each segment
           for lobeSegmentIndex = 1:numberOfLobeSegments

               % extract azi/el
               currentAzi = AziAngles(lobeSegmentIndex);
               currentAzi (currentAzi >= 180 ) =  currentAzi (currentAzi >= 180 ) - 360;
               currentEl = ElAngles(lobeSegmentIndex);

               % find mathcing indices in the true power array
               indKeep = AOAs == currentAzi & ZOAs == currentEl;

               % extract power
               currentPowers = 10.^(thresholded3DSpectrum(indKeep)/10);

               % construct the angular bin spectrum
               lobeSpectrum_sampled_int = [lobeSpectrum_sampled_int; 10*log10(currentPowers) currentAzi*ones(size(currentPowers)) currentEl*ones(size(currentPowers))];
               lobeSpectrum_sampled = [lobeSpectrum_sampled; 10*log10(currentPowers) (currentAzi-angleOffset_Azi)*ones(size(currentPowers)) (currentEl-angleOffset_El)*ones(size(currentPowers))];

               % construct the per path spectrum
               indPaths = az_l_temp == currentAzi & zen_l_temp == currentEl;
               lobeSpectrum_int_perPath = [lobeSpectrum_int_perPath; 10*log10(P_l_temp(indPaths)) currentAzi*ones(sum(indPaths),1) currentEl*ones(sum(indPaths),1)];
               lobeSpectrum_perPath = [lobeSpectrum_perPath; tau_l_temp(indPaths) 10*log10(P_l_temp(indPaths)) (currentAzi-angleOffset_Azi)*ones(sum(indPaths),1) (currentEl-angleOffset_El)*ones(sum(indPaths),1)];

           end%%% end of lobeSegmentIndex for loop 

           % store the lobe spectrum:
           % the per path spectrum
           % the angular bin spectrum
           lobeSpectrum.lobeSpectrum_perPath = lobeSpectrum_perPath;
           lobeSpectrum.lobeSpectrum_perAngularBin = lobeSpectrum_sampled;

           % store lobe spectrum for output
           lobeSpectrum_struct.(['Lobe_',num2str(lobeNumber)]) = lobeSpectrum;

        end%%end of lobeNumber for loop

    end%% end of if strcmp(outStruct.dataSet,'raytracing)

            
            
end