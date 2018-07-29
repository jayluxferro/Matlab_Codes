%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Mathan Kumar Moorthy
% Organization: ASU - PhotoVoltaic Reliability Laboratory
% Date: 11/04/2015
% Code details: This code is used for  
% generating pie chart for a PV Power plant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import data from two separate files
% IV data and Visual Inspection Data
IVdata = importfile('IV data.xlsx');
F1 = ismissing(IVdata);
IVdata = IVdata(~any(F1,2),:);
IVdata = unique(IVdata,'rows');

P_failures = importfile10('VI.xlsx');
F2 = ismissing(P_failures);
P_failures = P_failures(~any(F2,2),:);
P_failures = unique(P_failures,'rows');

S_failures = importfile11('VI.xlsx');
F3 = ismissing(S_failures);
S_failures = S_failures(~any(F3,2),:);
S_failures = unique(S_failures,'rows');

%% Join two files using module data
P_IV = join(IVdata,P_failures,'Keys','Module');
S_IV = join(IVdata,S_failures,'Keys','Module');

%% Create a variable totalling the defects to find whether module has any defects

P_IV.Powerdrop = (P_IV.RatedPmax - P_IV.MeasuredPmax)*100./P_IV.RatedPmax;
S_IV.Powerdrop = (S_IV.RatedPmax - S_IV.MeasuredPmax)*100./S_IV.RatedPmax;
P_IV.RdPmax = P_IV.Powerdrop ./ P_IV.Age;
S_IV.RdPmax = S_IV.Powerdrop ./ S_IV.Age;

S_IV.Sum_S = sum(S_IV{:,15:39},2);

%% Remove modules without Safety failures from safety failure imported data

toDelete2 = S_IV.Sum_S <= 0;
S_IV(toDelete2,:) = [];

%% Separate performance defects from safety failures
T1 = P_IV(:,{'Module','RdPmax'});
T2 = S_IV(:,{'Module','RdPmax'});
T3 = setdiff(T1,T2);

%% Reliability, Durability and Safety failures

% Define Variables for Rd < 1 and Rd > 1
Df = T3.RdPmax < 1;
Rf = T3.RdPmax > 1;

% To find length of Reliability, Durability and Safety failures
ReliabilityFailures = length(T3.RdPmax(Rf));
DurabilityFailures = length(T3.RdPmax(Df));
SafetyFailures = length(T2.RdPmax);

Reliability_Failures = (ReliabilityFailures)*100 / length(IVdata.Module);
Durability_Failures = (DurabilityFailures)*100 / length(IVdata.Module);
Safety_Failures = (SafetyFailures)*100 / length(IVdata.Module);
 
%% Create a Pie Chart
% Label pie chart with text and percent values

if (Durability_Failures  == 0)
    Durability_Failures = 0.0001;
end

if(Safety_Failures ~= 0)
    x1 = [Durability_Failures Reliability_Failures Safety_Failures];
  % Color map for pie chart   
m = [0 0.7 0
    0.90 0.90 0
    1 0 0];
  % Generate Pie Chart
    figure(5);
    set(gcf,'Color',[1,1,1]);
    colormap(m);
    h = pie(x1);

    hText = findobj(h,'Type','text'); % text object handles
    percentValues = get(hText,'String'); % percent values
  
    str = {'Durability Loss (<1% dr/yr): ';'Reliability  Failures (>1% dr/yr): ';'Safety Failures: '}; % strings
    combinedstrings = strcat(str,percentValues); % strings and percent values

    oldExtents_cell = get(hText,'Extent'); % cell array
    oldExtents = cell2mat(oldExtents_cell); % numeric array

    hText(1).String = combinedstrings(1);
    hText(2).String = combinedstrings(2);
    hText(3).String = combinedstrings(3);

    newExtents_cell = get(hText,'Extent'); % cell array
    newExtents = cell2mat(newExtents_cell); % numeric array
    width_change = newExtents(:,3)-oldExtents(:,3);

    signValues = sign(oldExtents(:,1));
    offset = signValues.*(width_change/3.5);

    textPositions_cell = get(hText,{'Position'}); % cell array
    textPositions = cell2mat(textPositions_cell); % numeric array
    textPositions(:,1) = textPositions(:,1) + offset; % add offset

    hText(1).Position = textPositions(1,:);
    hText(2).Position = textPositions(2,:);
    hText(3).Position = textPositions(3,:);
    title('Reliability Failures vs Durability Loss vs Safety Failures');
    print('-dpdf','-r0','Pie Chart')
    
elseif(Safety_Failures == 0)
    x1 = [Durability_Failures Reliability_Failures];
    % Color map for pie chart
    m = [0 0.7 0
        0.95 0.95 0];
    % Generate Pie Chart
    figure('Color',[1 1 1])
    colormap(m);
    h = pie(x1);

    hText = findobj(h,'Type','text'); % text object handles
    percentValues = get(hText,'String'); % percent values

    str = {'Durability Loss (<1% dr/yr): ';'Reliability Failures (>1% dr/yr): '}; % strings
    combinedstrings = strcat(str,percentValues); % strings and percent values

    oldExtents_cell = get(hText,'Extent'); % cell array
    oldExtents = cell2mat(oldExtents_cell); % numeric array

    hText(1).String = combinedstrings(1);
    hText(2).String = combinedstrings(2);
    
    newExtents_cell = get(hText,'Extent'); % cell array
    newExtents = cell2mat(newExtents_cell); % numeric array
    width_change = newExtents(:,2)-oldExtents(:,2);

    signValues = sign(oldExtents(:,1));
    offset = signValues.*(width_change/3.5);

    textPositions_cell = get(hText,{'Position'}); % cell array
    textPositions = cell2mat(textPositions_cell); % numeric array
    textPositions(:,1) = textPositions(:,1) + offset; % add offset

    hText(1).Position = textPositions(1,:);
    hText(2).Position = textPositions(2,:);
    title('Reliability Failures vs Durability Loss vs Safety Failures');
    print('-dpdf','-r0','Pie Chart')
end



