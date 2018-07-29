%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Mathan Kumar Moorthy
% Organization: ASU - PhotoVoltaic Reliability Laboratory
% Date: 11/04/2015
% Code details: This code is used for  
% generating Safety RPN results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import data from two separate files
% IV data and Visual Inspection Data
IVdata = importfile('IV data.xlsx');
VisualInspection = importfile6('VI.xlsx');

%% Clean up IV data

T1 = ismissing(IVdata);
IVdata = IVdata(~any(T1,2),:);
IVdata = unique(IVdata,'rows');

%% Clean up Visual Inspection data

T2 = ismissing(VisualInspection);
VisualInspection = VisualInspection(~any(T2,2),:);
VisualInspection = unique(VisualInspection,'rows');

%% Clean up Safety failures data
Safety_failures = importfile11('VI.xlsx');
T3 = ismissing(Safety_failures);
Safety_failures = Safety_failures(~any(T3,2),:);
Safety_failures = unique(Safety_failures,'rows');

%% Join two files using module data
Safety_IV = join(Safety_failures,IVdata,'Keys','Module');

%%  Degradation rate for safety failures
% Drop in IV parameters
Safety_IV.Iscdrop = (Safety_IV.RatedIsc - Safety_IV.MeasuredIsc)*100./Safety_IV.RatedIsc;
Safety_IV.Vocdrop = (Safety_IV.RatedVoc - Safety_IV.MeasuredVoc)*100./Safety_IV.RatedVoc;
Safety_IV.Imaxdrop = (Safety_IV.RatedImax - Safety_IV.MeasuredImax)*100./Safety_IV.RatedImax;
Safety_IV.Vmaxdrop = (Safety_IV.RatedVmax - Safety_IV.MeasuredVmax)*100./Safety_IV.RatedVmax;
Safety_IV.FFdrop = (Safety_IV.RatedFF - Safety_IV.MeasuredFF)*100./Safety_IV.RatedFF;
Safety_IV.Iscdrop = (Safety_IV.RatedIsc - Safety_IV.MeasuredIsc)*100./Safety_IV.RatedIsc;
Safety_IV.Powerdrop = (Safety_IV.RatedPmax - Safety_IV.MeasuredPmax)*100./Safety_IV.RatedPmax;

% Degradation rates of IV parameters
Safety_IV.RdIsc = Safety_IV.Iscdrop ./ Safety_IV.Age;
Safety_IV.RdVoc = Safety_IV.Vocdrop ./ Safety_IV.Age;
Safety_IV.RdImax = Safety_IV.Imaxdrop ./ Safety_IV.Age;
Safety_IV.RdVmax = Safety_IV.Vmaxdrop ./ Safety_IV.Age;
Safety_IV.RdFF = Safety_IV.FFdrop ./ Safety_IV.Age;
Safety_IV.RdPmax = Safety_IV.Powerdrop ./ Safety_IV.Age;

%% Index for each defects

idx1 = Safety_failures.Frontglasscrack ~= 0;
idx2 = Safety_failures.Frontglassshattered ~= 0;
idx3 = Safety_failures.Rearglasscrack ~= 0;
idx4 = Safety_failures.Rearglassshattered ~= 0;
idx5 = Safety_failures.Framegroundingseverecorrosion ~= 0;
idx6 = Safety_failures.Framegroundingminorcorrosion ~= 0;
idx7 = Safety_failures.Framemajorcorrosion ~= 0;
idx8 = Safety_failures.Framejointseparation ~= 0;
idx9 = Safety_failures.Framecracking ~= 0;
idx10 = Safety_failures.BypassdiodeopencircuitEquipmentneeded ~= 0;
idx11 = Safety_failures.Junctionboxcrack ~= 0;
idx12 = Safety_failures.Junctionboxburn ~= 0;
idx13 = Safety_failures.Junctionboxloose ~= 0;
idx14 = Safety_failures.Junctionboxlidfelloff ~= 0;
idx15 = Safety_failures.Junctionboxlidcrack ~= 0;
idx16 = Safety_failures.Wiresinsulationcrackeddisintegrated ~= 0;
idx17 = Safety_failures.Wiresburnt ~= 0;
idx18 = Safety_failures.Wiresanimalbitesmarks ~= 0;
idx19 = Safety_failures.Backsheetpeeling ~= 0;
idx20 = Safety_failures.Backsheetdelamination ~= 0;
idx21 = Safety_failures.Backsheetburnmark ~= 0;
idx22 = Safety_failures.Backsheetcrackcutundercell ~= 0;
idx23 = Safety_failures.Backsheetcrackcutbetweencells ~= 0;
idx24 = Safety_failures.StringInterconnectarctracks ~= 0;
idx25 = Safety_failures.Hotspotover20CEquipmentneeded ~= 0;

%% Total of each individual defects

% Create a new varaiable Total to store total count of each defects
Total = [length(Safety_failures.Module(idx1));length(Safety_failures.Module(idx2));length(Safety_failures.Module(idx3));length(Safety_failures.Module(idx4));length(Safety_failures.Module(idx5));length(Safety_failures.Module(idx6));length(Safety_failures.Module(idx7));length(Safety_failures.Module(idx8));length(Safety_failures.Module(idx9));length(Safety_failures.Module(idx10));length(Safety_failures.Module(idx11));length(Safety_failures.Module(idx12));length(Safety_failures.Module(idx13));length(Safety_failures.Module(idx14));length(Safety_failures.Module(idx15));length(Safety_failures.Module(idx16));length(Safety_failures.Module(idx17));length(Safety_failures.Module(idx18));length(Safety_failures.Module(idx19));length(Safety_failures.Module(idx20));length(Safety_failures.Module(idx21));length(Safety_failures.Module(idx22));length(Safety_failures.Module(idx23));length(Safety_failures.Module(idx24));length(Safety_failures.Module(idx25))];

%% Percentage of each defects
% To find percentage of each defects

% Begin For loop
for i = 1:25
    % Find percentage of each defects
    Percentage(i,1) = (Total(i)*100)/length(Safety_failures.Module);
    i = i+1;
end

%% CNF/1000 for each defects
% To find percentage of each defects

% Begin For loop
for i = 1:25
    % Find CNF for each defects
    CNF(i,1) = (Percentage(i)*10)/Safety_IV.Age(1);
    i = i+1;
end

%% Average degradation rate for each safety defects

% Index of defects for average degradation
s1 = Safety_IV.Frontglasscrack ~= 0;
s2 = Safety_IV.Frontglassshattered ~= 0;
s3 = Safety_IV.Rearglasscrack ~= 0;
s4 = Safety_IV.Rearglassshattered ~= 0;
s5 = Safety_IV.Framegroundingseverecorrosion ~= 0;
s6 = Safety_IV.Framegroundingminorcorrosion ~= 0;
s7 = Safety_IV.Framemajorcorrosion ~= 0;
s8 = Safety_IV.Framejointseparation ~= 0;
s9 = Safety_IV.Framecracking ~= 0;
s10 = Safety_IV.BypassdiodeopencircuitEquipmentneeded ~= 0;
s11 = Safety_IV.Junctionboxcrack ~= 0;
s12 = Safety_IV.Junctionboxburn ~= 0;
s13 = Safety_IV.Junctionboxloose ~= 0;
s14 = Safety_IV.Junctionboxlidfelloff ~= 0;
s15 = Safety_IV.Junctionboxlidcrack ~= 0;
s16 = Safety_IV.Wiresinsulationcrackeddisintegrated ~= 0;
s17 = Safety_IV.Wiresburnt ~= 0;
s18 = Safety_IV.Wiresanimalbitesmarks ~= 0;
s19 = Safety_IV.Backsheetpeeling ~= 0;
s20 = Safety_IV.Backsheetdelamination ~= 0;
s21 = Safety_IV.Backsheetburnmark ~= 0;
s22 = Safety_IV.Backsheetcrackcutundercell ~= 0;
s23 = Safety_IV.Backsheetcrackcutbetweencells ~= 0;
s24 = Safety_IV.StringInterconnectarctracks ~= 0;
s25 = Safety_IV.Hotspotover20CEquipmentneeded ~= 0;

% Create a new varaiable Average_Degradation to store average degradation rate of each defects
Average_Degradation = [mean(Safety_IV.RdPmax(s1));mean(Safety_IV.RdPmax(s2));mean(Safety_IV.RdPmax(s3));mean(Safety_IV.RdPmax(s4));mean(Safety_IV.RdPmax(s5));mean(Safety_IV.RdPmax(s6));mean(Safety_IV.RdPmax(s7));mean(Safety_IV.RdPmax(s8));mean(Safety_IV.RdPmax(s9));mean(Safety_IV.RdPmax(s10));mean(Safety_IV.RdPmax(s11));mean(Safety_IV.RdPmax(s12));mean(Safety_IV.RdPmax(s13));mean(Safety_IV.RdPmax(s14));mean(Safety_IV.RdPmax(s15));mean(Safety_IV.RdPmax(s16));mean(Safety_IV.RdPmax(s17));mean(Safety_IV.RdPmax(s18));mean(Safety_IV.RdPmax(s19));mean(Safety_IV.RdPmax(s20));mean(Safety_IV.RdPmax(s21));mean(Safety_IV.RdPmax(s22));mean(Safety_IV.RdPmax(s23));mean(Safety_IV.RdPmax(s24));mean(Safety_IV.RdPmax(s25))];

%% Occurence of safety defects in FMECA table
% To create a new varaiable Occurence to store occurence of each defects

% Begin For loop
for j = 1:25
    if(CNF(j) <= 0.01)
        Occurence(j,1) = 1;
    elseif(CNF(j) > 0.01 && CNF(j) <= 0.1)
        Occurence(j,1) = 2;
    elseif(CNF(j) > 0.1 && CNF(j) <= 0.5)
        Occurence(j,1) = 3;
    elseif(CNF(j) > 0.5 && CNF(j) <= 1)
        Occurence(j,1) = 4;
    elseif(CNF(j) > 1 && CNF(j) <= 2)
        Occurence(j,1) = 5;
    elseif(CNF(j) > 2 && CNF(j) <= 5)
        Occurence(j,1) = 6;
    elseif(CNF(j) > 5 && CNF(j) <= 10)
        Occurence(j,1) = 7;
    elseif(CNF(j) > 10 && CNF(j) <= 20)
        Occurence(j,1) = 8;
    elseif(CNF(j) > 20 && CNF(j) <= 50)
        Occurence(j,1) = 9;
    else
        Occurence(j,1) = 10;
    end
    j = j+1;
end

%% Detection in FMECA table
% To create a new varaiable Detection to store detection of each defects
Detection = [2;2;2;2;2;2;2;2;2;6;2;2;2;2;2;2;2;2;2;2;2;2;2;2;4];


%% Severity in FMECA table
% To create a new varaiable Severity to store severity of each defects
% Begin for loop
for i = 1:25
    if(CNF(i) == 0 || isnan(Average_Degradation(i)))
        Severity(i,1) = 0;
    elseif(Average_Degradation(i) > 2 || i == 1 || i == 2 || i==3 || i==4 || i==5 || i==8 || i== 9 || i == 11 || i==12 || i==13 || i==14 || i==15 || i==17 || i==18 || i==19 || i==20 || i==22 || i==23)
        Severity(i,1) = 10;
    elseif(Average_Degradation(i) < 1 || i == 10)
        Severity(i,1) = 8;
    elseif(Average_Degradation(i) > 1 && Average_Degradation(i) <= 2 )
        Severity(i,1) = 9;
    end
    i = i+1;
end

for i=1:25
    % Calculate RPN for each defects
    RPN(i,1) = Severity(i,1)*Detection(i,1)*Occurence(i,1);
    
    % calculate RPN for each failure using Severity and Occurence
    RPN_SO(i,1) = Severity(i,1)*Occurence(i,1);
    
    i = i+1;
end

%% FMECA Safety RPN table
Defects = {'Front glass crack';'Front glass shattered';'Rear glass crack';'Rear glass shattered';'Frame grounding severe corrosion';'Frame grounding minor corrosion';'Frame major corrosion';'Frame joint separation';'Frame cracking';'Bypass diode open circuit (Equipment needed)';'Junction box crack';'Junction box burn';'Junction box loose';'Junction box lid fell off';'Junction box lid crack';'Wires insulation cracked / disintegrated';'Wires burnt';'Wires animal bites / marks';'Backsheet peeling';'Backsheet delamination';'Backsheet burn mark';'Backsheet crack /cut under cell';'Backsheet crack /cut between cells';'String Interconnect arc tracks';'Hotspot over 20 deg C (Equipment needed)'};
FMECA1 = table(Defects,Total,Percentage,Average_Degradation,CNF,Severity,Occurence,Detection,RPN,RPN_SO); 

