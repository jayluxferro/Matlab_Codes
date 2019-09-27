function PDP_Info_Struct = TimeClustering(linkData,minVoidInterval)
% Extract time cluster statistics, based on a pre-defined minimum
% inter-cluster time interval
%
% Inputs:
%   - linkData: structure containing CIR link information
%   - minVoidInterval: minimum inter-cluster void interval (ns)
% Output: 
%   - PDP_Info_Struct: structure contaning time cluster statistics
%
% Copyright © 2016 NYU
%
% For outdoor UMi data, we recommend minVoidInterval = 25 ns
% For indoor data, we recommend minVoidInterval = 5 ns

%%% structure array: PDP_Info_Struct: 
%%%%%%%%%% Fieldnames:
%%%%%%%%%%%%%% NumOfTimeClusters: number time clusters
%%%%%%%%%%%%%% TimeCluster_k.numOfSubpaths: number of subpaths in cluster k
%%%%%%%%%%%%%% TimeCluster_k.subpathTimes: column vector of cluster subpath
%%%%%%%%%%%%%% time delays (ns)
%%%%%%%%%%%%%% TimeCluster_k.subpathTimes: column vector of cluster subpath
%%%%%%%%%%%%%% powers (mW)
%%%%%%%%%%%%%% TimeCluster_k.subpathAOAs: column vector of cluster subpath
%%%%%%%%%%%%%% azimuth angles of arrival (degrees)
%%%%%%%%%%%%%% TimeCluster_k.subpathZOAs: column vector of cluster subpath
%%%%%%%%%%%%%% zenith angles of arrival (degrees)
%%%%%%%%%%%%%% TimeCluster_k.subpathPhases: column vector of cluster subpath
%%%%%%%%%%%%%% phases (radians)

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
    % extract multipath parameters
    tau_l_temp = linkData(:,1);
    P_l_temp = 10.^(linkData(:,2)/10);
    phase_l_temp = linkData(:,3);
    aoa_l_temp = linkData(:,6);
    zoa_l_temp = linkData(:,7);

    % sort input data from smallest to greatest time delays
    tau_p_aoa_zoa_mat = sortrows([tau_l_temp P_l_temp aoa_l_temp zoa_l_temp phase_l_temp] ,1);

    % extract sorted tau_l and P_l
    tau_l = tau_p_aoa_zoa_mat(:,1);
    P_l = tau_p_aoa_zoa_mat(:,2);
    aoa_l = tau_p_aoa_zoa_mat(:,3);
    zoa_l = tau_p_aoa_zoa_mat(:,4);
    phase_l = tau_p_aoa_zoa_mat(:,5);

    % index elements delimiting time clusters in the
    % omnidirectional profile
    consecutiveElements = find(diff(tau_l) > minVoidInterval);            
    indicesToKeep = sort([1;numel(tau_l);consecutiveElements;consecutiveElements+1]);

    % reformat indices in 2 columns, where col1:start, col2:end
    % limits
    temp = reshape(indicesToKeep',2,[]);
    clusterLimits_indices = temp';

    % number of time clusters in profile
    numberOfTimeClusters = size(clusterLimits_indices,1);

    % initialize structure where data is stored
    PDP_Info_Struct = struct;
    PDP_Info_Struct.NumOfTimeClusters = numberOfTimeClusters;

    for clusterIndex = 1:numberOfTimeClusters

        % indices delimiting start and stop of time cluster
        clusterStart = clusterLimits_indices(clusterIndex,1);
        clusterStop = clusterLimits_indices(clusterIndex,2);

        % time delays of cluster subpaths
        clusterSubpathTimes = tau_l(clusterStart:clusterStop);
        subpathAOAs = aoa_l(clusterStart:clusterStop);
        subpathZOAs = zoa_l(clusterStart:clusterStop);
        subpathPhases = phase_l(clusterStart:clusterStop);

        % power of cluster subpaths
        clusterSubpathPowers = P_l(clusterStart:clusterStop);

        % number of cluster subpaths
        numberOfSubpaths = numel(clusterSubpathTimes);                

        % store information for output
        PDP_Info_Struct.(['TimeCluster_',num2str(clusterIndex)]).numOfSubpaths = numberOfSubpaths;
        PDP_Info_Struct.(['TimeCluster_',num2str(clusterIndex)]).subpathTimes = clusterSubpathTimes;
        PDP_Info_Struct.(['TimeCluster_',num2str(clusterIndex)]).subpathPowers = clusterSubpathPowers;
        PDP_Info_Struct.(['TimeCluster_',num2str(clusterIndex)]).subpathAOAs = subpathAOAs;
        PDP_Info_Struct.(['TimeCluster_',num2str(clusterIndex)]).subpathZOAs = subpathZOAs;
        PDP_Info_Struct.(['TimeCluster_',num2str(clusterIndex)]).subpathPhases = subpathPhases;
    end%%end of clusterIndex for loop

end
