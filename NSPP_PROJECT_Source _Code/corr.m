%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Mathan Kumar Moorthy
% Organization: ASU - PhotoVoltaic Reliability Laboratory
% Date: 11/04/2015
% Code details: This code is used for finding   
% correlation results for modules with performance 
% defects excluding safety failures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import data from two separate files
% IV data and Visual Inspection Data

IVdata = importfile('IV data.xlsx');
VisualInspection = importfile6('VI.xlsx');
%% Clean up IV data
G1 = ismissing(IVdata);
IVdata = IVdata(~any(G1,2),:);
IVdata = unique(IVdata,'rows');

G2 = ismissing(VisualInspection);
VisualInspection = VisualInspection(~any(G2,2),:);
VisualInspection = unique(VisualInspection,'rows');

%% Join two files using module data

Data_Common = join(VisualInspection,IVdata,'Keys','Module');

%% Remove Safety failures from the data 

x1 = Data_Common.Frontglasscrack ~= 0;
Data_Common(x1,:) = [];
x2 = Data_Common.Frontglassshattered ~= 0;
Data_Common(x2,:) = [];
x3 = Data_Common.Rearglasscrack ~= 0;
Data_Common(x3,:) = [];
x4 = Data_Common.Rearglassshattered ~= 0;
Data_Common(x4,:) = [];
x5 = Data_Common.Framegroundingseverecorrosion ~= 0;
Data_Common(x5,:) = [];
x6 = Data_Common.Framegroundingminorcorrosion ~= 0;
Data_Common(x6,:) = [];
x7 = Data_Common.Framemajorcorrosion ~= 0;
Data_Common(x7,:) = [];
x8 = Data_Common.Framejointseparation ~= 0;
Data_Common(x8,:) = [];
x9 = Data_Common.Framecracking ~= 0;
Data_Common(x9,:) = [];
x10 = Data_Common.BypassdiodeopencircuitEquipmentneeded ~= 0;
Data_Common(x10,:) = [];
x11 = Data_Common.Junctionboxcrack ~= 0;
Data_Common(x11,:) = [];
x12 = Data_Common.Junctionboxburn~= 0;
Data_Common(x12,:) = [];
x13 = Data_Common.Junctionboxloose ~= 0;
Data_Common(x13,:) = [];
x14 = Data_Common.Junctionboxlidfelloff ~= 0;
Data_Common(x14,:) = [];
x15 = Data_Common.Junctionboxlidcrack ~= 0;
Data_Common(x15,:) = [];
x16 = Data_Common.Wiresinsulationcrackeddisintegrated ~= 0;
Data_Common(x16,:) = [];
x17 = Data_Common.Wiresburnt ~= 0;
Data_Common(x17,:) = [];
x18 = Data_Common.Wiresanimalbitesmarks ~= 0;
Data_Common(x18,:) = [];
x19 = Data_Common.Backsheetpeeling ~= 0;
Data_Common(x19,:) = [];
x20 = Data_Common.Backsheetdelamination ~= 0;
Data_Common(x20,:) = [];
x21 = Data_Common.Backsheetburnmark ~= 0;
Data_Common(x21,:) = [];
x22 = Data_Common.Backsheetcrackcutundercell ~= 0;
Data_Common(x22,:) = [];
x23 = Data_Common.Backsheetcrackcutbetweencells ~= 0;
Data_Common(x23,:) = [];
x24 = Data_Common.StringInterconnectarctracks ~= 0;
Data_Common(x24,:) = [];
x25 = Data_Common.Hotspotover20CEquipmentneeded ~= 0;
Data_Common(x25,:) = [];

%% Delete safety failures from data
% all_data = Data_Common;
Data_Common(:,[17,19,30,31,32,34,42,43,44,47]) = [];

%% Series resistance and Shunt resistance

prompt = 'Enter Module type (Mono-Si/Poly-Si/Amorphous Si/CdTe/CIGS/CIS/HIT): '
str1 = input(prompt,'s');
prompt = 'Enter the type of climate (Hot Dry/Cold Dry/Hot Humid/Temperate): '
str2 = input(prompt,'s');
prompt = 'Enter Powerplant Name: '
str3 = input(prompt,'s');

moduleType1 = 'Mono-Si';
moduleType2 = 'Poly-Si';
moduleType3 = 'Amorphous Si';
moduleType4 = 'CdTe';
moduleType5 = 'CIGS';
moduleType6 = 'CIS';
moduleType7 = 'HIT';

% For HIT modules, there is no coefficients for Cs and Csh, so Cs and Csh for mono Si were considered for calculation purpose

if(strcmpi(str1,moduleType1))
    Cs = 0.32;
    Csh = 4.92;
elseif(strcmpi(str1,moduleType2))
    Cs = 0.34;
    Csh = 5.36;
elseif(strcmpi(str1,moduleType3))
    Cs = 0.59;
    Csh = 0.92;
elseif(strcmpi(str1,moduleType4))
    Cs = 0.59;
    Csh = 0.92;
elseif(strcmpi(str1,moduleType5))
    Cs = 0.59;
    Csh = 0.92;
elseif(strcmpi(str1,moduleType6))
    Cs = 0.59;
    Csh = 0.92
elseif(strcmpi(str1,moduleType7))
    Cs = 0.32;
    Csh = 4.92;
else
    display('Error in moduleType')
    exit;
end
    Data_Common.RatedRs = Cs.*((Data_Common.RatedVoc - Data_Common.RatedVmax)./Data_Common.RatedImax);
    Data_Common.RatedRsh = Csh.*((Data_Common.RatedVoc)./(Data_Common.RatedIsc - Data_Common.RatedImax));
    Data_Common.MeasuredRs = Cs.*((Data_Common.MeasuredVoc - Data_Common.MeasuredVmax)./Data_Common.MeasuredImax);
    Data_Common.MeasuredRsh = Csh.*((Data_Common.MeasuredVoc)./(Data_Common.MeasuredIsc - Data_Common.MeasuredImax));

%% Drop in IV parameters
Data_Common.Iscdrop = (Data_Common.RatedIsc - Data_Common.MeasuredIsc)*100./Data_Common.RatedIsc;
Data_Common.Vocdrop = (Data_Common.RatedVoc - Data_Common.MeasuredVoc)*100./Data_Common.RatedVoc;
Data_Common.Imaxdrop = (Data_Common.RatedImax - Data_Common.MeasuredImax)*100./Data_Common.RatedImax;
Data_Common.Vmaxdrop = (Data_Common.RatedVmax - Data_Common.MeasuredVmax)*100./Data_Common.RatedVmax;
Data_Common.FFdrop = (Data_Common.RatedFF - Data_Common.MeasuredFF)*100./Data_Common.RatedFF;
Data_Common.Iscdrop = (Data_Common.RatedIsc - Data_Common.MeasuredIsc)*100./Data_Common.RatedIsc;
Data_Common.Powerdrop = (Data_Common.RatedPmax - Data_Common.MeasuredPmax)*100./Data_Common.RatedPmax;
Data_Common.Change_in_Rs = (Data_Common.MeasuredRs - Data_Common.RatedRs)*100./Data_Common.RatedRs;
Data_Common.Change_in_Rsh = (Data_Common.RatedRsh - Data_Common.MeasuredRsh)*100./Data_Common.RatedRsh;

%% Degradation rates of IV parameters
Data_Common.RdIsc = Data_Common.Iscdrop ./ Data_Common.Age;
Data_Common.RdVoc = Data_Common.Vocdrop ./ Data_Common.Age;
Data_Common.RdImax = Data_Common.Imaxdrop ./ Data_Common.Age;
Data_Common.RdVmax = Data_Common.Vmaxdrop ./ Data_Common.Age;
Data_Common.RdFF = Data_Common.FFdrop ./ Data_Common.Age;
Data_Common.RdPmax = Data_Common.Powerdrop ./ Data_Common.Age;
Data_Common.RdRs = Data_Common.Change_in_Rs ./ Data_Common.Age;
Data_Common.RdRsh = Data_Common.Change_in_Rsh ./ Data_Common.Age;

%% Delete modules which are degrading at higher rates more than 2% deg rate

ToDelete = Data_Common.RdPmax > 2.5;
Data_Common(ToDelete,:) = [];

%% Index for each defects

q1 = Data_Common.Frontglasslightlysoiled ~= 0;
q2 = Data_Common.Frontglassheavilysoiled ~= 0;
q3 = Data_Common.Frontglasscrazing ~= 0;
q4 = Data_Common.Frontglasschip ~= 0;
q5 = Data_Common.Frontglassmilkydiscoloration ~= 0;
q6 = Data_Common.Rearglasscrazing ~= 0;
q7 = Data_Common.Rearglasschipped ~= 0;
q8 = Data_Common.Edgesealdelamination ~= 0;
q9 = Data_Common.Edgesealmoisturepenetration ~= 0;
q10 = Data_Common.Edgesealdiscoloration ~= 0;
q11 = Data_Common.Edgesealsqueezedpinchedout ~= 0;
q12 = Data_Common.Framebent ~= 0;
q13 = Data_Common.Framediscoloration ~= 0;
q14 = Data_Common.Frameadhesivedegraded ~= 0;
q15 = Data_Common.Frameadhesiveoozedout ~= 0;
q16 = Data_Common.Frameadhesivemissinginareas ~= 0;
q17 = Data_Common.BypassdiodeshortcircuitEquipmentneeded ~= 0;
q18 = Data_Common.Junctionboxlidloose ~= 0;
q19 = Data_Common.Junctionboxwarped ~= 0;
q20 = Data_Common.Junctionboxweathered ~= 0;
q21 = Data_Common.Junctionboxwireattachmentsloose ~= 0;
q22 = Data_Common.Junctionboxadhesiveloose ~= 0; 
q23 = Data_Common.Junctionboxadhesivefelloff ~= 0; 
q24 = Data_Common.Junctionboxwireattachmentsfelloff ~= 0; 
q25 = Data_Common.Junctionboxwireattachmentsarced ~= 0; 
q26 = Data_Common.Wirescorroded ~= 0;
q27 = Data_Common.Backsheetwavy ~= 0;
q28 = Data_Common.Backsheetdiscoloration ~= 0;
q29 = Data_Common.Backsheetbubble ~= 0;
q30 = Data_Common.Gridlinediscoloration ~= 0;
q31 = Data_Common.Gridlineblossoming ~= 0;
q32 = Data_Common.Busbardiscoloration ~= 0;
q33 = Data_Common.Busbarcorrosion ~= 0;
q34 = Data_Common.Busbarburnmarks ~= 0;
q35 = Data_Common.Busbarmisaligned ~= 0;
q36 = Data_Common.CellInterconnectribbondiscoloration ~= 0;
q37 = Data_Common.CellInterconnectribboncorrosion ~= 0;
q38 = Data_Common.CellInterconnectribbonburnmark ~= 0;
q39 = Data_Common.StringInterconnectdiscoloration ~= 0;
q40 = Data_Common.StringInterconnectcorrosion ~= 0;
q41 = Data_Common.CellInterconnectribbonbreak ~= 0;
q42 = Data_Common.StringInterconnectbreak ~= 0;
q43 = Data_Common.StringInterconnectburnmark ~= 0;
q44 = Data_Common.Celldiscoloration ~= 0;
q45 = Data_Common.CellburnMark ~= 0;
q46 = Data_Common.Cellchippingcrack ~= 0;
q47 = Data_Common.Cellmoisturepenetration ~= 0;
q48 = Data_Common.CellwormmarkSnailTracks ~= 0;
q49 = Data_Common.Cellforeignparticleembedded ~= 0;
q50 = Data_Common.Interconnectdiscoloration ~= 0;
q51 = Data_Common.SolderbondFatigueFailureEquipmentneeded ~= 0;
q52 = Data_Common.Hotspotlessthan20CEquipmentneeded ~= 0;
q53 = Data_Common.Encapsulantdelaminationoverthecell ~= 0;
q54 = Data_Common.Encapsulantdelaminationunderthecell ~= 0;
q55 = Data_Common.Encapsulantdelaminationoverthejunctionbox ~= 0;
q56 = Data_Common.Encapsulantdelaminationnearinterconnectorfingers ~= 0;
q57 = Data_Common.Encapsulantdiscolorationyellowingbrowning ~= 0;
q58 = Data_Common.ThinFilmModuleDiscoloration ~= 0;
q59 = Data_Common.ThinFilmModuleDelaminationAbsorberTCOlayer ~= 0;
q60 = Data_Common.ThinFilmModuleDelaminationARcoating ~= 0;
q61 = Data_Common.Modulemismatch ~= 0;

%% Average and Median degradation

% Create a new varaiable Average_Degradation to store average degradation rate of each defects
Average_Degradation = [mean(Data_Common.RdPmax(q1));mean(Data_Common.RdPmax(q2));mean(Data_Common.RdPmax(q3));mean(Data_Common.RdPmax(q4));mean(Data_Common.RdPmax(q5));mean(Data_Common.RdPmax(q6));mean(Data_Common.RdPmax(q7));mean(Data_Common.RdPmax(q8));mean(Data_Common.RdPmax(q9));mean(Data_Common.RdPmax(q10));mean(Data_Common.RdPmax(q11));mean(Data_Common.RdPmax(q12));mean(Data_Common.RdPmax(q13));mean(Data_Common.RdPmax(q14));mean(Data_Common.RdPmax(q15));mean(Data_Common.RdPmax(q16));mean(Data_Common.RdPmax(q17));mean(Data_Common.RdPmax(q18));mean(Data_Common.RdPmax(q19));mean(Data_Common.RdPmax(q20));mean(Data_Common.RdPmax(q21));mean(Data_Common.RdPmax(q22));mean(Data_Common.RdPmax(q23));mean(Data_Common.RdPmax(q24));mean(Data_Common.RdPmax(q25));mean(Data_Common.RdPmax(q26));mean(Data_Common.RdPmax(q27));mean(Data_Common.RdPmax(q28));mean(Data_Common.RdPmax(q29));mean(Data_Common.RdPmax(q30));mean(Data_Common.RdPmax(q31));mean(Data_Common.RdPmax(q32));mean(Data_Common.RdPmax(q33));mean(Data_Common.RdPmax(q34));mean(Data_Common.RdPmax(q35));mean(Data_Common.RdPmax(q36));mean(Data_Common.RdPmax(q37));mean(Data_Common.RdPmax(q38));mean(Data_Common.RdPmax(q39));mean(Data_Common.RdPmax(q40));mean(Data_Common.RdPmax(q41));mean(Data_Common.RdPmax(q42));mean(Data_Common.RdPmax(q43));mean(Data_Common.RdPmax(q44));mean(Data_Common.RdPmax(q45));mean(Data_Common.RdPmax(q46));mean(Data_Common.RdPmax(q47));mean(Data_Common.RdPmax(q48));mean(Data_Common.RdPmax(q49));mean(Data_Common.RdPmax(q50));mean(Data_Common.RdPmax(q51));mean(Data_Common.RdPmax(q52));mean(Data_Common.RdPmax(q53));mean(Data_Common.RdPmax(q54));mean(Data_Common.RdPmax(q55));mean(Data_Common.RdPmax(q56));mean(Data_Common.RdPmax(q57));mean(Data_Common.RdPmax(q58));mean(Data_Common.RdPmax(q59));mean(Data_Common.RdPmax(q60));mean(Data_Common.RdPmax(q61))];  
Average_Degradation1 = [mean(Data_Common.RdVoc(q1));mean(Data_Common.RdVoc(q2));mean(Data_Common.RdVoc(q3));mean(Data_Common.RdVoc(q4));mean(Data_Common.RdVoc(q5));mean(Data_Common.RdVoc(q6));mean(Data_Common.RdVoc(q7));mean(Data_Common.RdVoc(q8));mean(Data_Common.RdVoc(q9));mean(Data_Common.RdVoc(q10));mean(Data_Common.RdVoc(q11));mean(Data_Common.RdVoc(q12));mean(Data_Common.RdVoc(q13));mean(Data_Common.RdVoc(q14));mean(Data_Common.RdVoc(q15));mean(Data_Common.RdVoc(q16));mean(Data_Common.RdVoc(q17));mean(Data_Common.RdVoc(q18));mean(Data_Common.RdVoc(q19));mean(Data_Common.RdVoc(q20));mean(Data_Common.RdVoc(q21));mean(Data_Common.RdVoc(q22));mean(Data_Common.RdVoc(q23));mean(Data_Common.RdVoc(q24));mean(Data_Common.RdVoc(q25));mean(Data_Common.RdVoc(q26));mean(Data_Common.RdVoc(q27));mean(Data_Common.RdVoc(q28));mean(Data_Common.RdVoc(q29));mean(Data_Common.RdVoc(q30));mean(Data_Common.RdVoc(q31));mean(Data_Common.RdVoc(q32));mean(Data_Common.RdVoc(q33));mean(Data_Common.RdVoc(q34));mean(Data_Common.RdVoc(q35));mean(Data_Common.RdVoc(q36));mean(Data_Common.RdVoc(q37));mean(Data_Common.RdVoc(q38));mean(Data_Common.RdVoc(q39));mean(Data_Common.RdVoc(q40));mean(Data_Common.RdVoc(q41));mean(Data_Common.RdVoc(q42));mean(Data_Common.RdVoc(q43));mean(Data_Common.RdVoc(q44));mean(Data_Common.RdVoc(q45));mean(Data_Common.RdVoc(q46));mean(Data_Common.RdVoc(q47));mean(Data_Common.RdVoc(q48));mean(Data_Common.RdVoc(q49));mean(Data_Common.RdVoc(q50));mean(Data_Common.RdVoc(q51));mean(Data_Common.RdVoc(q52));mean(Data_Common.RdVoc(q53));mean(Data_Common.RdVoc(q54));mean(Data_Common.RdVoc(q55));mean(Data_Common.RdVoc(q56));mean(Data_Common.RdVoc(q57));mean(Data_Common.RdVoc(q58));mean(Data_Common.RdVoc(q59));mean(Data_Common.RdVoc(q60));mean(Data_Common.RdVoc(q61))]; 
Average_Degradation2 = [mean(Data_Common.RdIsc(q1));mean(Data_Common.RdIsc(q2));mean(Data_Common.RdIsc(q3));mean(Data_Common.RdIsc(q4));mean(Data_Common.RdIsc(q5));mean(Data_Common.RdIsc(q6));mean(Data_Common.RdIsc(q7));mean(Data_Common.RdIsc(q8));mean(Data_Common.RdIsc(q9));mean(Data_Common.RdIsc(q10));mean(Data_Common.RdIsc(q11));mean(Data_Common.RdIsc(q12));mean(Data_Common.RdIsc(q13));mean(Data_Common.RdIsc(q14));mean(Data_Common.RdIsc(q15));mean(Data_Common.RdIsc(q16));mean(Data_Common.RdIsc(q17));mean(Data_Common.RdIsc(q18));mean(Data_Common.RdIsc(q19));mean(Data_Common.RdIsc(q20));mean(Data_Common.RdIsc(q21));mean(Data_Common.RdIsc(q22));mean(Data_Common.RdIsc(q23));mean(Data_Common.RdIsc(q24));mean(Data_Common.RdIsc(q25));mean(Data_Common.RdIsc(q26));mean(Data_Common.RdIsc(q27));mean(Data_Common.RdIsc(q28));mean(Data_Common.RdIsc(q29));mean(Data_Common.RdIsc(q30));mean(Data_Common.RdIsc(q31));mean(Data_Common.RdIsc(q32));mean(Data_Common.RdIsc(q33));mean(Data_Common.RdIsc(q34));mean(Data_Common.RdIsc(q35));mean(Data_Common.RdIsc(q36));mean(Data_Common.RdIsc(q37));mean(Data_Common.RdIsc(q38));mean(Data_Common.RdIsc(q39));mean(Data_Common.RdIsc(q40));mean(Data_Common.RdIsc(q41));mean(Data_Common.RdIsc(q42));mean(Data_Common.RdIsc(q43));mean(Data_Common.RdIsc(q44));mean(Data_Common.RdIsc(q45));mean(Data_Common.RdIsc(q46));mean(Data_Common.RdIsc(q47));mean(Data_Common.RdIsc(q48));mean(Data_Common.RdIsc(q49));mean(Data_Common.RdIsc(q50));mean(Data_Common.RdIsc(q51));mean(Data_Common.RdIsc(q52));mean(Data_Common.RdIsc(q53));mean(Data_Common.RdIsc(q54));mean(Data_Common.RdIsc(q55));mean(Data_Common.RdIsc(q56));mean(Data_Common.RdIsc(q57));mean(Data_Common.RdIsc(q58));mean(Data_Common.RdIsc(q59));mean(Data_Common.RdIsc(q60));mean(Data_Common.RdIsc(q61))];
Average_Degradation3 = [mean(Data_Common.RdFF(q1));mean(Data_Common.RdFF(q2));mean(Data_Common.RdFF(q3));mean(Data_Common.RdFF(q4));mean(Data_Common.RdFF(q5));mean(Data_Common.RdFF(q6));mean(Data_Common.RdFF(q7));mean(Data_Common.RdFF(q8));mean(Data_Common.RdFF(q9));mean(Data_Common.RdFF(q10));mean(Data_Common.RdFF(q11));mean(Data_Common.RdFF(q12));mean(Data_Common.RdFF(q13));mean(Data_Common.RdFF(q14));mean(Data_Common.RdFF(q15));mean(Data_Common.RdFF(q16));mean(Data_Common.RdFF(q17));mean(Data_Common.RdFF(q18));mean(Data_Common.RdFF(q19));mean(Data_Common.RdFF(q20));mean(Data_Common.RdFF(q21));mean(Data_Common.RdFF(q22));mean(Data_Common.RdFF(q23));mean(Data_Common.RdFF(q24));mean(Data_Common.RdFF(q25));mean(Data_Common.RdFF(q26));mean(Data_Common.RdFF(q27));mean(Data_Common.RdFF(q28));mean(Data_Common.RdFF(q29));mean(Data_Common.RdFF(q30));mean(Data_Common.RdFF(q31));mean(Data_Common.RdFF(q32));mean(Data_Common.RdFF(q33));mean(Data_Common.RdFF(q34));mean(Data_Common.RdFF(q35));mean(Data_Common.RdFF(q36));mean(Data_Common.RdFF(q37));mean(Data_Common.RdFF(q38));mean(Data_Common.RdFF(q39));mean(Data_Common.RdFF(q40));mean(Data_Common.RdFF(q41));mean(Data_Common.RdFF(q42));mean(Data_Common.RdFF(q43));mean(Data_Common.RdFF(q44));mean(Data_Common.RdFF(q45));mean(Data_Common.RdFF(q46));mean(Data_Common.RdFF(q47));mean(Data_Common.RdFF(q48));mean(Data_Common.RdFF(q49));mean(Data_Common.RdFF(q50));mean(Data_Common.RdFF(q51));mean(Data_Common.RdFF(q52));mean(Data_Common.RdFF(q53));mean(Data_Common.RdFF(q54));mean(Data_Common.RdFF(q55));mean(Data_Common.RdFF(q56));mean(Data_Common.RdFF(q57));mean(Data_Common.RdFF(q58));mean(Data_Common.RdFF(q59));mean(Data_Common.RdFF(q60));mean(Data_Common.RdFF(q61))];
Average_Degradation4 = [mean(Data_Common.RdRs(q1));mean(Data_Common.RdRs(q2));mean(Data_Common.RdRs(q3));mean(Data_Common.RdRs(q4));mean(Data_Common.RdRs(q5));mean(Data_Common.RdRs(q6));mean(Data_Common.RdRs(q7));mean(Data_Common.RdRs(q8));mean(Data_Common.RdRs(q9));mean(Data_Common.RdRs(q10));mean(Data_Common.RdRs(q11));mean(Data_Common.RdRs(q12));mean(Data_Common.RdRs(q13));mean(Data_Common.RdRs(q14));mean(Data_Common.RdRs(q15));mean(Data_Common.RdRs(q16));mean(Data_Common.RdRs(q17));mean(Data_Common.RdRs(q18));mean(Data_Common.RdRs(q19));mean(Data_Common.RdRs(q20));mean(Data_Common.RdRs(q21));mean(Data_Common.RdRs(q22));mean(Data_Common.RdRs(q23));mean(Data_Common.RdRs(q24));mean(Data_Common.RdRs(q25));mean(Data_Common.RdRs(q26));mean(Data_Common.RdRs(q27));mean(Data_Common.RdRs(q28));mean(Data_Common.RdRs(q29));mean(Data_Common.RdRs(q30));mean(Data_Common.RdRs(q31));mean(Data_Common.RdRs(q32));mean(Data_Common.RdRs(q33));mean(Data_Common.RdRs(q34));mean(Data_Common.RdRs(q35));mean(Data_Common.RdRs(q36));mean(Data_Common.RdRs(q37));mean(Data_Common.RdRs(q38));mean(Data_Common.RdRs(q39));mean(Data_Common.RdRs(q40));mean(Data_Common.RdRs(q41));mean(Data_Common.RdRs(q42));mean(Data_Common.RdRs(q43));mean(Data_Common.RdRs(q44));mean(Data_Common.RdRs(q45));mean(Data_Common.RdRs(q46));mean(Data_Common.RdRs(q47));mean(Data_Common.RdRs(q48));mean(Data_Common.RdRs(q49));mean(Data_Common.RdRs(q50));mean(Data_Common.RdRs(q51));mean(Data_Common.RdRs(q52));mean(Data_Common.RdRs(q53));mean(Data_Common.RdRs(q54));mean(Data_Common.RdRs(q55));mean(Data_Common.RdRs(q56));mean(Data_Common.RdRs(q57));mean(Data_Common.RdRs(q58));mean(Data_Common.RdRs(q59));mean(Data_Common.RdRs(q60));mean(Data_Common.RdRs(q61))];
Average_Degradation5 = [mean(Data_Common.RdRsh(q1));mean(Data_Common.RdRsh(q2));mean(Data_Common.RdRsh(q3));mean(Data_Common.RdRsh(q4));mean(Data_Common.RdRsh(q5));mean(Data_Common.RdRsh(q6));mean(Data_Common.RdRsh(q7));mean(Data_Common.RdRsh(q8));mean(Data_Common.RdRsh(q9));mean(Data_Common.RdRsh(q10));mean(Data_Common.RdRsh(q11));mean(Data_Common.RdRsh(q12));mean(Data_Common.RdRsh(q13));mean(Data_Common.RdRsh(q14));mean(Data_Common.RdRsh(q15));mean(Data_Common.RdRsh(q16));mean(Data_Common.RdRsh(q17));mean(Data_Common.RdRsh(q18));mean(Data_Common.RdRsh(q19));mean(Data_Common.RdRsh(q20));mean(Data_Common.RdRsh(q21));mean(Data_Common.RdRsh(q22));mean(Data_Common.RdRsh(q23));mean(Data_Common.RdRsh(q24));mean(Data_Common.RdRsh(q25));mean(Data_Common.RdRsh(q26));mean(Data_Common.RdRsh(q27));mean(Data_Common.RdRsh(q28));mean(Data_Common.RdRsh(q29));mean(Data_Common.RdRsh(q30));mean(Data_Common.RdRsh(q31));mean(Data_Common.RdRsh(q32));mean(Data_Common.RdRsh(q33));mean(Data_Common.RdRsh(q34));mean(Data_Common.RdRsh(q35));mean(Data_Common.RdRsh(q36));mean(Data_Common.RdRsh(q37));mean(Data_Common.RdRsh(q38));mean(Data_Common.RdRsh(q39));mean(Data_Common.RdRsh(q40));mean(Data_Common.RdRsh(q41));mean(Data_Common.RdRsh(q42));mean(Data_Common.RdRsh(q43));mean(Data_Common.RdRsh(q44));mean(Data_Common.RdRsh(q45));mean(Data_Common.RdRsh(q46));mean(Data_Common.RdRsh(q47));mean(Data_Common.RdRsh(q48));mean(Data_Common.RdRsh(q49));mean(Data_Common.RdRsh(q50));mean(Data_Common.RdRsh(q51));mean(Data_Common.RdRsh(q52));mean(Data_Common.RdRsh(q53));mean(Data_Common.RdRsh(q54));mean(Data_Common.RdRsh(q55));mean(Data_Common.RdRsh(q56));mean(Data_Common.RdRsh(q57));mean(Data_Common.RdRsh(q58));mean(Data_Common.RdRsh(q59));mean(Data_Common.RdRsh(q60));mean(Data_Common.RdRsh(q61))];

% Create a new varaiable Median_Degradation to store Median degradation rate of each defects
Median_Degradation = [median(Data_Common.RdPmax(q1));median(Data_Common.RdPmax(q2));median(Data_Common.RdPmax(q3));median(Data_Common.RdPmax(q4));median(Data_Common.RdPmax(q5));median(Data_Common.RdPmax(q6));median(Data_Common.RdPmax(q7));median(Data_Common.RdPmax(q8));median(Data_Common.RdPmax(q9));median(Data_Common.RdPmax(q10));median(Data_Common.RdPmax(q11));median(Data_Common.RdPmax(q12));median(Data_Common.RdPmax(q13));median(Data_Common.RdPmax(q14));median(Data_Common.RdPmax(q15));median(Data_Common.RdPmax(q16));median(Data_Common.RdPmax(q17));median(Data_Common.RdPmax(q18));median(Data_Common.RdPmax(q19));median(Data_Common.RdPmax(q20));median(Data_Common.RdPmax(q21));median(Data_Common.RdPmax(q22));median(Data_Common.RdPmax(q23));median(Data_Common.RdPmax(q24));median(Data_Common.RdPmax(q25));median(Data_Common.RdPmax(q26));median(Data_Common.RdPmax(q27));median(Data_Common.RdPmax(q28));median(Data_Common.RdPmax(q29));median(Data_Common.RdPmax(q30));median(Data_Common.RdPmax(q31));median(Data_Common.RdPmax(q32));median(Data_Common.RdPmax(q33));median(Data_Common.RdPmax(q34));median(Data_Common.RdPmax(q35));median(Data_Common.RdPmax(q36));median(Data_Common.RdPmax(q37));median(Data_Common.RdPmax(q38));median(Data_Common.RdPmax(q39));median(Data_Common.RdPmax(q40));median(Data_Common.RdPmax(q41));median(Data_Common.RdPmax(q42));median(Data_Common.RdPmax(q43));median(Data_Common.RdPmax(q44));median(Data_Common.RdPmax(q45));median(Data_Common.RdPmax(q46));median(Data_Common.RdPmax(q47));median(Data_Common.RdPmax(q48));median(Data_Common.RdPmax(q49));median(Data_Common.RdPmax(q50));median(Data_Common.RdPmax(q51));median(Data_Common.RdPmax(q52));median(Data_Common.RdPmax(q53));median(Data_Common.RdPmax(q54));median(Data_Common.RdPmax(q55));median(Data_Common.RdPmax(q56));median(Data_Common.RdPmax(q57));median(Data_Common.RdPmax(q58));median(Data_Common.RdPmax(q59));median(Data_Common.RdPmax(q60));median(Data_Common.RdPmax(q61))];  
Median_Degradation1 = [median(Data_Common.RdVoc(q1));median(Data_Common.RdVoc(q2));median(Data_Common.RdVoc(q3));median(Data_Common.RdVoc(q4));median(Data_Common.RdVoc(q5));median(Data_Common.RdVoc(q6));median(Data_Common.RdVoc(q7));median(Data_Common.RdVoc(q8));median(Data_Common.RdVoc(q9));median(Data_Common.RdVoc(q10));median(Data_Common.RdVoc(q11));median(Data_Common.RdVoc(q12));median(Data_Common.RdVoc(q13));median(Data_Common.RdVoc(q14));median(Data_Common.RdVoc(q15));median(Data_Common.RdVoc(q16));median(Data_Common.RdVoc(q17));median(Data_Common.RdVoc(q18));median(Data_Common.RdVoc(q19));median(Data_Common.RdVoc(q20));median(Data_Common.RdVoc(q21));median(Data_Common.RdVoc(q22));median(Data_Common.RdVoc(q23));median(Data_Common.RdVoc(q24));median(Data_Common.RdVoc(q25));median(Data_Common.RdVoc(q26));median(Data_Common.RdVoc(q27));median(Data_Common.RdVoc(q28));median(Data_Common.RdVoc(q29));median(Data_Common.RdVoc(q30));median(Data_Common.RdVoc(q31));median(Data_Common.RdVoc(q32));median(Data_Common.RdVoc(q33));median(Data_Common.RdVoc(q34));median(Data_Common.RdVoc(q35));median(Data_Common.RdVoc(q36));median(Data_Common.RdVoc(q37));median(Data_Common.RdVoc(q38));median(Data_Common.RdVoc(q39));median(Data_Common.RdVoc(q40));median(Data_Common.RdVoc(q41));median(Data_Common.RdVoc(q42));median(Data_Common.RdVoc(q43));median(Data_Common.RdVoc(q44));median(Data_Common.RdVoc(q45));median(Data_Common.RdVoc(q46));median(Data_Common.RdVoc(q47));median(Data_Common.RdVoc(q48));median(Data_Common.RdVoc(q49));median(Data_Common.RdVoc(q50));median(Data_Common.RdVoc(q51));median(Data_Common.RdVoc(q52));median(Data_Common.RdVoc(q53));median(Data_Common.RdVoc(q54));median(Data_Common.RdVoc(q55));median(Data_Common.RdVoc(q56));median(Data_Common.RdVoc(q57));median(Data_Common.RdVoc(q58));median(Data_Common.RdVoc(q59));median(Data_Common.RdVoc(q60));median(Data_Common.RdVoc(q61))]; 
Median_Degradation2 = [median(Data_Common.RdIsc(q1));median(Data_Common.RdIsc(q2));median(Data_Common.RdIsc(q3));median(Data_Common.RdIsc(q4));median(Data_Common.RdIsc(q5));median(Data_Common.RdIsc(q6));median(Data_Common.RdIsc(q7));median(Data_Common.RdIsc(q8));median(Data_Common.RdIsc(q9));median(Data_Common.RdIsc(q10));median(Data_Common.RdIsc(q11));median(Data_Common.RdIsc(q12));median(Data_Common.RdIsc(q13));median(Data_Common.RdIsc(q14));median(Data_Common.RdIsc(q15));median(Data_Common.RdIsc(q16));median(Data_Common.RdIsc(q17));median(Data_Common.RdIsc(q18));median(Data_Common.RdIsc(q19));median(Data_Common.RdIsc(q20));median(Data_Common.RdIsc(q21));median(Data_Common.RdIsc(q22));median(Data_Common.RdIsc(q23));median(Data_Common.RdIsc(q24));median(Data_Common.RdIsc(q25));median(Data_Common.RdIsc(q26));median(Data_Common.RdIsc(q27));median(Data_Common.RdIsc(q28));median(Data_Common.RdIsc(q29));median(Data_Common.RdIsc(q30));median(Data_Common.RdIsc(q31));median(Data_Common.RdIsc(q32));median(Data_Common.RdIsc(q33));median(Data_Common.RdIsc(q34));median(Data_Common.RdIsc(q35));median(Data_Common.RdIsc(q36));median(Data_Common.RdIsc(q37));median(Data_Common.RdIsc(q38));median(Data_Common.RdIsc(q39));median(Data_Common.RdIsc(q40));median(Data_Common.RdIsc(q41));median(Data_Common.RdIsc(q42));median(Data_Common.RdIsc(q43));median(Data_Common.RdIsc(q44));median(Data_Common.RdIsc(q45));median(Data_Common.RdIsc(q46));median(Data_Common.RdIsc(q47));median(Data_Common.RdIsc(q48));median(Data_Common.RdIsc(q49));median(Data_Common.RdIsc(q50));median(Data_Common.RdIsc(q51));median(Data_Common.RdIsc(q52));median(Data_Common.RdIsc(q53));median(Data_Common.RdIsc(q54));median(Data_Common.RdIsc(q55));median(Data_Common.RdIsc(q56));median(Data_Common.RdIsc(q57));median(Data_Common.RdIsc(q58));median(Data_Common.RdIsc(q59));median(Data_Common.RdIsc(q60));median(Data_Common.RdIsc(q61))];
Median_Degradation3 = [median(Data_Common.RdFF(q1));median(Data_Common.RdFF(q2));median(Data_Common.RdFF(q3));median(Data_Common.RdFF(q4));median(Data_Common.RdFF(q5));median(Data_Common.RdFF(q6));median(Data_Common.RdFF(q7));median(Data_Common.RdFF(q8));median(Data_Common.RdFF(q9));median(Data_Common.RdFF(q10));median(Data_Common.RdFF(q11));median(Data_Common.RdFF(q12));median(Data_Common.RdFF(q13));median(Data_Common.RdFF(q14));median(Data_Common.RdFF(q15));median(Data_Common.RdFF(q16));median(Data_Common.RdFF(q17));median(Data_Common.RdFF(q18));median(Data_Common.RdFF(q19));median(Data_Common.RdFF(q20));median(Data_Common.RdFF(q21));median(Data_Common.RdFF(q22));median(Data_Common.RdFF(q23));median(Data_Common.RdFF(q24));median(Data_Common.RdFF(q25));median(Data_Common.RdFF(q26));median(Data_Common.RdFF(q27));median(Data_Common.RdFF(q28));median(Data_Common.RdFF(q29));median(Data_Common.RdFF(q30));median(Data_Common.RdFF(q31));median(Data_Common.RdFF(q32));median(Data_Common.RdFF(q33));median(Data_Common.RdFF(q34));median(Data_Common.RdFF(q35));median(Data_Common.RdFF(q36));median(Data_Common.RdFF(q37));median(Data_Common.RdFF(q38));median(Data_Common.RdFF(q39));median(Data_Common.RdFF(q40));median(Data_Common.RdFF(q41));median(Data_Common.RdFF(q42));median(Data_Common.RdFF(q43));median(Data_Common.RdFF(q44));median(Data_Common.RdFF(q45));median(Data_Common.RdFF(q46));median(Data_Common.RdFF(q47));median(Data_Common.RdFF(q48));median(Data_Common.RdFF(q49));median(Data_Common.RdFF(q50));median(Data_Common.RdFF(q51));median(Data_Common.RdFF(q52));median(Data_Common.RdFF(q53));median(Data_Common.RdFF(q54));median(Data_Common.RdFF(q55));median(Data_Common.RdFF(q56));median(Data_Common.RdFF(q57));median(Data_Common.RdFF(q58));median(Data_Common.RdFF(q59));median(Data_Common.RdFF(q60));median(Data_Common.RdFF(q61))];
Median_Degradation4 = [median(Data_Common.RdRs(q1));median(Data_Common.RdRs(q2));median(Data_Common.RdRs(q3));median(Data_Common.RdRs(q4));median(Data_Common.RdRs(q5));median(Data_Common.RdRs(q6));median(Data_Common.RdRs(q7));median(Data_Common.RdRs(q8));median(Data_Common.RdRs(q9));median(Data_Common.RdRs(q10));median(Data_Common.RdRs(q11));median(Data_Common.RdRs(q12));median(Data_Common.RdRs(q13));median(Data_Common.RdRs(q14));median(Data_Common.RdRs(q15));median(Data_Common.RdRs(q16));median(Data_Common.RdRs(q17));median(Data_Common.RdRs(q18));median(Data_Common.RdRs(q19));median(Data_Common.RdRs(q20));median(Data_Common.RdRs(q21));median(Data_Common.RdRs(q22));median(Data_Common.RdRs(q23));median(Data_Common.RdRs(q24));median(Data_Common.RdRs(q25));median(Data_Common.RdRs(q26));median(Data_Common.RdRs(q27));median(Data_Common.RdRs(q28));median(Data_Common.RdRs(q29));median(Data_Common.RdRs(q30));median(Data_Common.RdRs(q31));median(Data_Common.RdRs(q32));median(Data_Common.RdRs(q33));median(Data_Common.RdRs(q34));median(Data_Common.RdRs(q35));median(Data_Common.RdRs(q36));median(Data_Common.RdRs(q37));median(Data_Common.RdRs(q38));median(Data_Common.RdRs(q39));median(Data_Common.RdRs(q40));median(Data_Common.RdRs(q41));median(Data_Common.RdRs(q42));median(Data_Common.RdRs(q43));median(Data_Common.RdRs(q44));median(Data_Common.RdRs(q45));median(Data_Common.RdRs(q46));median(Data_Common.RdRs(q47));median(Data_Common.RdRs(q48));median(Data_Common.RdRs(q49));median(Data_Common.RdRs(q50));median(Data_Common.RdRs(q51));median(Data_Common.RdRs(q52));median(Data_Common.RdRs(q53));median(Data_Common.RdRs(q54));median(Data_Common.RdRs(q55));median(Data_Common.RdRs(q56));median(Data_Common.RdRs(q57));median(Data_Common.RdRs(q58));median(Data_Common.RdRs(q59));median(Data_Common.RdRs(q60));median(Data_Common.RdRs(q61))];
Median_Degradation5 = [median(Data_Common.RdRsh(q1));median(Data_Common.RdRsh(q2));median(Data_Common.RdRsh(q3));median(Data_Common.RdRsh(q4));median(Data_Common.RdRsh(q5));median(Data_Common.RdRsh(q6));median(Data_Common.RdRsh(q7));median(Data_Common.RdRsh(q8));median(Data_Common.RdRsh(q9));median(Data_Common.RdRsh(q10));median(Data_Common.RdRsh(q11));median(Data_Common.RdRsh(q12));median(Data_Common.RdRsh(q13));median(Data_Common.RdRsh(q14));median(Data_Common.RdRsh(q15));median(Data_Common.RdRsh(q16));median(Data_Common.RdRsh(q17));median(Data_Common.RdRsh(q18));median(Data_Common.RdRsh(q19));median(Data_Common.RdRsh(q20));median(Data_Common.RdRsh(q21));median(Data_Common.RdRsh(q22));median(Data_Common.RdRsh(q23));median(Data_Common.RdRsh(q24));median(Data_Common.RdRsh(q25));median(Data_Common.RdRsh(q26));median(Data_Common.RdRsh(q27));median(Data_Common.RdRsh(q28));median(Data_Common.RdRsh(q29));median(Data_Common.RdRsh(q30));median(Data_Common.RdRsh(q31));median(Data_Common.RdRsh(q32));median(Data_Common.RdRsh(q33));median(Data_Common.RdRsh(q34));median(Data_Common.RdRsh(q35));median(Data_Common.RdRsh(q36));median(Data_Common.RdRsh(q37));median(Data_Common.RdRsh(q38));median(Data_Common.RdRsh(q39));median(Data_Common.RdRsh(q40));median(Data_Common.RdRsh(q41));median(Data_Common.RdRsh(q42));median(Data_Common.RdRsh(q43));median(Data_Common.RdRsh(q44));median(Data_Common.RdRsh(q45));median(Data_Common.RdRsh(q46));median(Data_Common.RdRsh(q47));median(Data_Common.RdRsh(q48));median(Data_Common.RdRsh(q49));median(Data_Common.RdRsh(q50));median(Data_Common.RdRsh(q51));median(Data_Common.RdRsh(q52));median(Data_Common.RdRsh(q53));median(Data_Common.RdRsh(q54));median(Data_Common.RdRsh(q55));median(Data_Common.RdRsh(q56));median(Data_Common.RdRsh(q57));median(Data_Common.RdRsh(q58));median(Data_Common.RdRsh(q59));median(Data_Common.RdRsh(q60));median(Data_Common.RdRsh(q61))];

%% Comparison of Rd of Module Parameters
figure(1)
set(gcf,'Color',[1,1,1])
boxplot([Data_Common.RdIsc,Data_Common.RdVoc,Data_Common.RdFF,Data_Common.RdPmax]);
title(['Box Plot of IV parameter degradation rates (%/year) - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
xlabel({'IV parameters'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
ax = gca;
ax.XTickLabel = {'Isc','Voc','FF','Pmax'};
colormap winter
% To turn on datacursor
datacursormode on
orient landscape;
print('-dpdf','-r0','Box Plot of IV parameter degradation rates')


%% Linear Relation between Pmax, Isc, Voc and FF
figure(2)
set(gcf,'Color',[1,1,1])

subplot(1,3,1)
scatter(Data_Common.RdPmax,Data_Common.RdIsc);
ylabel({'Isc degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
xlabel({'Pmax degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
lsline;
axis([-1 3 -1 3])
subplot(1,3,2)
scatter(Data_Common.RdPmax,Data_Common.RdVoc);
ylabel({'Voc degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
xlabel({'Pmax degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
lsline;
axis([-1 3 -1 3])
subplot(1,3,3)
scatter(Data_Common.RdPmax,Data_Common.RdFF);
ylabel({'FF degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
xlabel({'Pmax degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
lsline;
axis([-1 3 -1 3])
orient landscape;
print('-dpdf','-r0','Linear Relation between Pmax, Isc, Voc and FF')

%% Linear relation between Pmax drop and Voc drop, Isc drop and FF drop
figure(3)
set(gcf,'Color',[1,1,1])

subplot(1,3,1)
scatter(Data_Common.Powerdrop,Data_Common.Iscdrop);
ylabel({'Isc drop'},'FontSize',12,'Color',[0 0 0]);
xlabel({'Pmax drop'},'FontSize',12,'Color',[0 0 0]);
lsline;
axis([0 100 0 100])
subplot(1,3,2)
scatter(Data_Common.Powerdrop,Data_Common.Vocdrop);
ylabel({'Voc drop'},'FontSize',12,'Color',[0 0 0]);
xlabel({'Pmax drop'},'FontSize',12,'Color',[0 0 0]);
lsline;
axis([0 100 0 100])
subplot(1,3,3)
scatter(Data_Common.Powerdrop,Data_Common.FFdrop);
ylabel({'FF drop'},'FontSize',12,'Color',[0 0 0]);
xlabel({'Pmax drop'},'FontSize',12,'Color',[0 0 0]);
lsline;
axis([0 100 0 100])
orient landscape;
print('-dpdf','-r0','Linear Relation between Pmax drop, Isc drop, Voc drop and FF drop')


%% Histogram for Pmax Rd
nBins = 30;
figure(4)
set(gcf,'Color',[1,1,1])
hist(Data_Common.RdPmax, nBins);
title(['Histogram of Pmax degradation rate - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1)),10,'Mean: ',num2str(mean(Data_Common.RdPmax)),'; ','Median: ',num2str(median(Data_Common.RdPmax)),'; ','Standard Deviation: ',num2str(std(Data_Common.RdPmax))],'FontSize',10,'Color',[1 0 0]);
xlabel({'Pmax degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
ylabel({'Frequency'},'FontSize',12,'Color',[0 0 0]);
% To turn on datacursor
datacursormode on
orient landscape;
print('-dpdf','-r0','Histogram of Pmax degradation rate')

%% Histogram for Pmax Rd with frequency in percentage
%Reference: http://stackoverflow.com/questions/21063026/normalizing-a-histogram-and-having-the-y-axis-in-percentages-in-matlab
nBins = 30;
[histFreq, histDegrate] = hist(Data_Common.RdPmax, nBins);
figure(5)
set(gcf,'Color',[1,1,1])
bar(histDegrate, histFreq/sum(histFreq)*100,'FaceColor',[0 0.3 0],'EdgeColor','k');
xlabel({'Pmax Degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
ylabel({'Frequency (%)'},'FontSize',12,'Color',[0 0 0]);
title(['Pmax Degradation rate (%/year) VS Frequency (%) - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1)),10,'Mean: ',num2str(mean(Data_Common.RdPmax)),'; ','Median: ',num2str(median(Data_Common.RdPmax)),'; ','Standard Deviation: ',num2str(std(Data_Common.RdPmax))],'FontSize',10,'Color',[1 0 0]);
orient landscape;
print('-dpdf','-r0','Histogram of Pmax degradation rate in percentage')

%% combined histogram #1
figure(6)
set(gcf,'Color',[1,1,1])
nBins = 70;
h1 = histogram(Data_Common.RdIsc,nBins,'FaceAlpha',0.5,'FaceColor','y');
h1.BinWidth = 0.05;

hold on
h2 = histogram(Data_Common.RdPmax,nBins,'FaceAlpha',0.5,'FaceColor','g');
h2.BinWidth = 0.05;

xlabel({'Degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
ylabel({'Frequency'},'FontSize',12,'Color',[0 0 0]);
title(['Combined Isc and Pmax degradation rate (%/year) Vs Frequency - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
legend('Isc degradation rate (%/year)','Pmax degradation rate (%/year)','Location','northeastoutside','Orientation','vertical');
orient landscape;
print('-dpdf','-r0','Combined histogram of Isc and Pmax degradation rate')

%% combined histogram #2
figure(7)
set(gcf,'Color',[1,1,1])
nBins = 70;
h1 = histogram(Data_Common.RdVoc,nBins,'FaceAlpha',0.5,'FaceColor','r');
h1.BinWidth = 0.05;

hold on
h2 = histogram(Data_Common.RdPmax,nBins,'FaceAlpha',0.5,'FaceColor','g');
h2.BinWidth = 0.05;

xlabel({'Degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
ylabel({'Frequency'},'FontSize',12,'Color',[0 0 0]);
title(['Combined Voc and Pmax degradation rate (%/year) Vs Frequency - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
legend('Voc degradation rate (%/year)','Pmax degradation rate (%/year)','Location','northeastoutside','Orientation','vertical');
orient landscape;
print('-dpdf','-r0','Combined histogram of Voc and Pmax degradation rate')
%% combined histogram #3
figure(8)
set(gcf,'Color',[1,1,1])
nBins = 70;
h1 = histogram(Data_Common.RdFF,nBins,'FaceAlpha',0.5,'FaceColor','b');
h1.BinWidth = 0.05;

hold on
h2 = histogram(Data_Common.RdPmax,nBins,'FaceAlpha',0.5,'FaceColor','g');
h2.BinWidth = 0.05;

xlabel({'Degradation rate (%/year)'},'FontSize',12,'Color',[0 0 0]);
ylabel({'Frequency'},'FontSize',12,'Color',[0 0 0]);
title(['Combined FF and Pmax Degradation rate (%/year) Vs Frequency - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
legend('FF degradation rate (%/year)','Pmax degradation rate (%/year)','Location','northeastoutside','Orientation','vertical');
orient landscape;
print('-dpdf','-r0','Combined histogram of FF and Pmax degradation rate')

%% Defects and deg rate for each defects table

Defects = {'Front glass lightly soiled';'Front glass heavily soiled';'Front glass crazing';'Front glass chip';'Front glass milky discoloration';'Rear glass crazing';'Rear glass chipped';'Edge seal delamination';'Edge seal moisture penetration';'Edge seal discoloration';'Edge seal squeezed / pinched out';'Frame bent';'Frame discoloration';'Frame adhesive degraded';'Frame adhesive oozed out';'Frame adhesive missing in areas';'Bypass diode short circuit (Equipment needed)';'Junction box lid loose';'Junction box warped';'Junction box weathered';'Junction box wire attachments loose';'Junction box adhesive loose';'Junction box adhesive fell off';'Junction box wire attachments fell off';'Junction box wire attachments arced';'Wires corroded';'Backsheet wavy';'Backsheet discoloration';'Backsheet bubble';'Gridline discoloration';'Gridline blossoming';'Busbar discoloration';'Busbar corrosion';'Busbar burn marks';'Busbar misaligned';'Cell Interconnect ribbon discoloration';'Cell Interconnect ribbon corrosion';'Cell Interconnect ribbon burn mark';'String Interconnect discoloration';'String Interconnect corrosion';'Cell Interconnect ribbon break';'String Interconnect break';'String Interconnect burn mark';'Cell discoloration';'Cell burn mark';'Cell chipping/crack';'Cell moisture penetration';'Cell worm mark (Snail Tracks)';'Cell foreign particle embedded';'Interconnect Discoloration';'Solder bond Fatigue / Failure (Equipment needed)';'Hotspot less than 20 deg C (Equipment needed)';'Encapsulant delamination over the cell';'Encapsulant delamination under the cell';'Encapsulant delamination over the junction box';'Encapsulant delamination near interconnect or fingers';'Encapsulant discoloration (yellowing / browning)';'Thin Film Module Discoloration';'Thin Film Module Delamination - Absorber/TCO layer';'Thin Film Module Delamination - AR coating';'Module mismatch'};
Defects_DegRate = table(Defects,Average_Degradation,Average_Degradation1,Average_Degradation2,Average_Degradation3,Average_Degradation4,Average_Degradation5,Median_Degradation,Median_Degradation1,Median_Degradation2,Median_Degradation3,Median_Degradation4,Median_Degradation5);

%% to remove defects that are not present
toDelete = isnan(Defects_DegRate.Average_Degradation);
Defects_DegRate(toDelete,:) = [];

%% Bar plot for comparing average degradation of IV parameters for all available defects

s = Defects_DegRate.Defects;

c1 = Defects_DegRate.Average_Degradation;
c2 = Defects_DegRate.Average_Degradation1;
c3 = Defects_DegRate.Average_Degradation2;
c4 = Defects_DegRate.Average_Degradation3;
c5 = Defects_DegRate.Average_Degradation4;
c6 = Defects_DegRate.Average_Degradation5;

c = [c1,c2,c3,c4,c5,c6];
figure(9);
set(gcf,'Color',[1,1,1]);
bar(c);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Average degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
title(['Comparison of Average degradation rate (%/year) of IV parameters for performance defects - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
legend('Pmax','Voc','Isc','FF','Rs','Rsh','Location','northeastoutside');
orient landscape;
print('-dpdf','-r0','Comparison of Average degradation rate')

%% Bar plot for comparing median degradation of IV parameters for all available defects

d1 = Defects_DegRate.Median_Degradation;
d2 = Defects_DegRate.Median_Degradation1;
d3 = Defects_DegRate.Median_Degradation2;
d4 = Defects_DegRate.Median_Degradation3;
d5 = Defects_DegRate.Median_Degradation4;
d6 = Defects_DegRate.Median_Degradation5;

d = [d1,d2,d3,d4,d5,d6];
figure(10);
set(gcf,'Color',[1,1,1]);
bar(d);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Median degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
title(['Comparison of Median degradation rate (%/year) of IV parameters for performance defects - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
legend('Pmax','Voc','Isc','FF','Rs','Rsh','Location','northeastoutside');
orient landscape;
print('-dpdf','-r0','Comparison of Median degradation rate')

%% Comparison of median degradation of Voc for each defects
figure(11);
set(gcf,'Color',[1,1,1]);
bar(d2);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Median Voc degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
title(['Comparison of Median Voc degradation rate (%/year) for performance defects - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
orient landscape;
print('-dpdf','-r0','Comparison of Voc Median degradation rate')

%% Comparison of median degradation of Isc

figure(12);
set(gcf,'Color',[1,1,1]);
bar(d3);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Median Isc degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
title(['Comparison of Median Isc degradation rate (%/year) for performance defects - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
orient landscape;
print('-dpdf','-r0','Comparison of Isc Median degradation rate')

%% Comparison of median degradation of FF

figure(13);
set(gcf,'Color',[1,1,1]);
bar(d4);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Median FF degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
title(['Comparison of Median FF degradation rate (%/year) for performance defects - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
orient landscape;
print('-dpdf','-r0','Comparison of FF Median degradation rate')

%% Comparison of median degradation of Rs

figure(14);
set(gcf,'Color',[1,1,1]);
bar(d5);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Median Rs degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
title(['Comparison of Median Rs degradation rate (%/year) for performance defects - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
orient landscape;
print('-dpdf','-r0','Comparison of Rs Median degradation rate')

%% Comparison of median degradation of Rsh

figure(15);
set(gcf,'Color',[1,1,1]);
bar(d6);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',12,'Color',[1 0 0]);
ylabel({'Median Rsh degradation rate (%/year)'},'FontSize',12,'Color',[1 0 0]);
title(['Comparison of Median Rsh degradation rate (%/year) for performance defects - ',str3,10,'Modules - ',num2str(length(Data_Common.Module)),' ( ',str1,' )','; ',str2,' climate; Field Age - ',num2str(Data_Common.Age(1))],'FontSize',10,'Color',[1 0 0]);
orient landscape;
print('-dpdf','-r0','Comparison of Rsh Median degradation rate')

%% table of average and median degradation rates

Defects_DegRate.Properties.VariableNames{'Average_Degradation'} = 'Avg_RdPmax';
Defects_DegRate.Properties.VariableNames{'Average_Degradation1'} = 'Avg_RdVoc';
Defects_DegRate.Properties.VariableNames{'Average_Degradation2'} = 'Avg_RdIsc';
Defects_DegRate.Properties.VariableNames{'Average_Degradation3'} = 'Avg_RdFF';
Defects_DegRate.Properties.VariableNames{'Average_Degradation4'} = 'Avg_RdRs';
Defects_DegRate.Properties.VariableNames{'Average_Degradation5'} = 'Avg_RdRsh';
Defects_DegRate.Properties.VariableNames{'Median_Degradation'} = 'Median_RdPmax';
Defects_DegRate.Properties.VariableNames{'Median_Degradation1'} = 'Median_RdVoc';
Defects_DegRate.Properties.VariableNames{'Median_Degradation2'} = 'Median_RdIsc';
Defects_DegRate.Properties.VariableNames{'Median_Degradation3'} = 'Median_RdFF';
Defects_DegRate.Properties.VariableNames{'Median_Degradation4'} = 'Median_RdRs';
Defects_DegRate.Properties.VariableNames{'Median_Degradation5'} = 'Median_RdRsh';

%% export results to excel

filename1 = fullfile(pwd, '\Datacorrelation.xlsx');
writetable(Data_Common,filename1);

filename2 = fullfile(pwd, '\Correlation.xlsx');
writetable(Defects_DegRate,filename2);








