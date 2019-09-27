% Copyright © 2016 NYU
cd(dataFolder)
outStruct = struct;
outStruct.dataType = 'measurements';
outStruct.bandwidth = 400e6;
outStruct.dataSet = dataSet;

fileNameToUpload = 'RX_To_Process_NYU.txt';
RXIDStruct = importdata(fileNameToUpload);
RXIDs = RXIDStruct.textdata;
linkNumMapping = RXIDStruct.data;        
numOfLocations = numel(linkNumMapping);
outStruct.linkData = cell(numOfLocations,1);
outStruct.delayRes_ns = 2.5; % ns

switch dataSet
    case '28_GHz_NLOS'
        outStruct.angleRes_deg = 10;
    case '28_GHz_LOS' 
        outStruct.angleRes_deg = 10;
    case '73_GHz_NLOS'
        outStruct.angleRes_deg = 8;
    case '73_GHz_LOS'
        outStruct.angleRes_deg = 8;
otherwise
end

for locIdx = 1:numOfLocations
    
    linkInfo = struct;    
    RXID = char(RXIDs(locIdx,:));
    linkNum = linkNumMapping(locIdx);            
    RXIDData = importdata([RXID,'_6D_Vectors.xlsx']);            
    linkData = RXIDData.data;
    delays = linkData(:,1); % use absolute delays
    pathPowers = linkData(:,2);

    pathAODAzi = linkData(:,3);
    pathAODAzi (pathAODAzi > 180) =  pathAODAzi (pathAODAzi > 180) - 360;
    
    pathAODEl = linkData(:,4);
    pathAODEl_adjusted = 90 - pathAODEl; 
    pathAOAAzi = linkData(:,5);
    pathAOAAzi( pathAOAAzi> 180) = pathAOAAzi( pathAOAAzi> 180) - 360; 
    pathAOAEl = linkData(:,6);
    pathAOAEl_adjusted = 90 - pathAOAEl; 
    pathPhases = zeros(numel(delays),1);
    
    numOfPaths = numel(delays);
    linkData = cell(numOfPaths,7);
    for pathIdx = 1:numOfPaths
        linkData{pathIdx,1} = delays(pathIdx); % delay (ns)
        linkData{pathIdx,2} = pathPowers(pathIdx); % power (dBm)
        linkData{pathIdx,3} = 0; % phase (rad)
        linkData{pathIdx,4} = nan; % AOD Azi (deg)
        linkData{pathIdx,5} = nan; % AOD El (deg)
        linkData{pathIdx,6} = pathAOAAzi(pathIdx); % AOA Azi (deg)
        linkData{pathIdx,7} = pathAOAEl_adjusted(pathIdx); % AOA El (deg)
    end%% end of pathIdx
    
    linkInfo.linkData = linkData;
    linkInfo.RXID = RXID;
    linkInfo.TxCoords = [];
    linkInfo.RxCoords = [];
    outStruct.linkData{locIdx} = linkInfo;


end%% end of locIdx
