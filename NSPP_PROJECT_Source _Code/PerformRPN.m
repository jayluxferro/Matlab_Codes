%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Mathan Kumar Moorthy
% Organization: ASU - PhotoVoltaic Reliability Laboratory
% Date: 11/04/2015
% Code details: This code is used for  
% generating Performance RPN results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import data from two separate files
% IV data and Visual Inspection Data
IVdata = importfile('IV data.xlsx');
VisualInspection = importfile6('VI.xlsx');

%% Clean up IV data
TF1 = ismissing(IVdata);
IVdata = IVdata(~any(TF1,2),:);
IVdata = unique(IVdata,'rows');

%% Clean up Visual Inspection data
TF2 = ismissing(VisualInspection);
VisualInspection = VisualInspection(~any(TF2,2),:);
VisualInspection = unique(VisualInspection,'rows');

%% Clean up Performance failures data
Performance_failures = importfile10('VI.xlsx');
TF3 = ismissing(Performance_failures);
Performance_failures = Performance_failures(~any(TF3,2),:);
Performance_failures = unique(Performance_failures,'rows');

%% Join two files using module data
Performance_IV = join(IVdata,Performance_failures,'Keys','Module');

%%  Degradation rate for safety failures
% Drop in IV parameters
Performance_IV.Iscdrop = (Performance_IV.RatedIsc - Performance_IV.MeasuredIsc)*100./Performance_IV.RatedIsc;
Performance_IV.Vocdrop = (Performance_IV.RatedVoc - Performance_IV.MeasuredVoc)*100./Performance_IV.RatedVoc;
Performance_IV.Imaxdrop = (Performance_IV.RatedImax - Performance_IV.MeasuredImax)*100./Performance_IV.RatedImax;
Performance_IV.Vmaxdrop = (Performance_IV.RatedVmax - Performance_IV.MeasuredVmax)*100./Performance_IV.RatedVmax;
Performance_IV.FFdrop = (Performance_IV.RatedFF - Performance_IV.MeasuredFF)*100./Performance_IV.RatedFF;
Performance_IV.Iscdrop = (Performance_IV.RatedIsc - Performance_IV.MeasuredIsc)*100./Performance_IV.RatedIsc;
Performance_IV.Powerdrop = (Performance_IV.RatedPmax - Performance_IV.MeasuredPmax)*100./Performance_IV.RatedPmax;

% Degradation rates of IV parameters
Performance_IV.RdIsc = Performance_IV.Iscdrop ./ Performance_IV.Age;
Performance_IV.RdVoc = Performance_IV.Vocdrop ./ Performance_IV.Age;
Performance_IV.RdImax = Performance_IV.Imaxdrop ./ Performance_IV.Age;
Performance_IV.RdVmax = Performance_IV.Vmaxdrop ./ Performance_IV.Age;
Performance_IV.RdFF = Performance_IV.FFdrop ./ Performance_IV.Age;
Performance_IV.RdPmax = Performance_IV.Powerdrop ./ Performance_IV.Age;

%% Index for each defects

p1 = Performance_failures.Frontglasslightlysoiled ~= 0;
p2 = Performance_failures.Frontglassheavilysoiled ~= 0;
p3 = Performance_failures.Frontglasscrazing ~= 0;
p4 = Performance_failures.Frontglasschip ~= 0;
p5 = Performance_failures.Frontglassmilkydiscoloration ~= 0;
p6 = Performance_failures.Rearglasscrazing ~= 0;
p7 = Performance_failures.Rearglasschipped ~= 0;
p8 = Performance_failures.Edgesealdelamination ~= 0;
p9 = Performance_failures.Edgesealmoisturepenetration ~= 0;
p10 = Performance_failures.Edgesealdiscoloration ~= 0;
p11 = Performance_failures.Edgesealsqueezedpinchedout ~= 0;
p12 = Performance_failures.Framebent ~= 0;
p13 = Performance_failures.Framediscoloration ~= 0;
p14 = Performance_failures.Frameadhesivedegraded ~= 0;
p15 = Performance_failures.Frameadhesiveoozedout ~= 0;
p16 = Performance_failures.Frameadhesivemissinginareas ~= 0;
p17 = Performance_failures.BypassdiodeshortcircuitEquipmentneeded ~= 0;
p18 = Performance_failures.Junctionboxlidloose ~= 0;
p19 = Performance_failures.Junctionboxwarped ~= 0;
p20 = Performance_failures.Junctionboxweathered ~= 0;
p21 = Performance_failures.Junctionboxwireattachmentsloose ~= 0;
p22 = Performance_failures.Junctionboxadhesiveloose ~= 0; 
p23 = Performance_failures.Junctionboxadhesivefelloff ~= 0; 
p24 = Performance_failures.Junctionboxwireattachmentsfelloff ~= 0; 
p25 = Performance_failures.Junctionboxwireattachmentsarced ~= 0; 
p26 = Performance_failures.Wirescorroded ~= 0;
p27 = Performance_failures.Backsheetwavy ~= 0;
p28 = Performance_failures.Backsheetdiscoloration ~= 0;
p29 = Performance_failures.Backsheetbubble ~= 0;
p30 = Performance_failures.Gridlinediscoloration ~= 0;
p31 = Performance_failures.Gridlineblossoming ~= 0;
p32 = Performance_failures.Busbardiscoloration ~= 0;
p33 = Performance_failures.Busbarcorrosion ~= 0;
p34 = Performance_failures.Busbarburnmarks ~= 0;
p35 = Performance_failures.Busbarmisaligned ~= 0;
p36 = Performance_failures.CellInterconnectribbondiscoloration ~= 0;
p37 = Performance_failures.CellInterconnectribboncorrosion ~= 0;
p38 = Performance_failures.CellInterconnectribbonburnmark ~= 0;
p39 = Performance_failures.StringInterconnectdiscoloration ~= 0;
p40 = Performance_failures.StringInterconnectcorrosion ~= 0;
p41 = Performance_failures.CellInterconnectribbonbreak ~= 0;
p42 = Performance_failures.StringInterconnectbreak ~= 0;
p43 = Performance_failures.StringInterconnectburnmark ~= 0;
p44 = Performance_failures.Celldiscoloration ~= 0;
p45 = Performance_failures.CellburnMark ~= 0;
p46 = Performance_failures.Cellchippingcrack ~= 0;
p47 = Performance_failures.Cellmoisturepenetration ~= 0;
p48 = Performance_failures.CellwormmarkSnailTracks ~= 0;
p49 = Performance_failures.Cellforeignparticleembedded ~= 0;
p50 = Performance_failures.Interconnectdiscoloration ~= 0;
p51 = Performance_failures.SolderbondFatigueFailureEquipmentneeded ~= 0;
p52 = Performance_failures.Hotspotlessthan20CEquipmentneeded ~= 0;
p53 = Performance_failures.Encapsulantdelaminationoverthecell ~= 0;
p54 = Performance_failures.Encapsulantdelaminationunderthecell ~= 0;
p55 = Performance_failures.Encapsulantdelaminationoverthejunctionbox ~= 0;
p56 = Performance_failures.Encapsulantdelaminationnearinterconnectorfingers ~= 0;
p57 = Performance_failures.Encapsulantdiscolorationyellowingbrowning ~= 0;
p58 = Performance_failures.ThinFilmModuleDiscoloration ~= 0;
p59 = Performance_failures.ThinFilmModuleDelaminationAbsorberTCOlayer ~= 0;
p60 = Performance_failures.ThinFilmModuleDelaminationARcoating ~= 0;
p61 = Performance_failures.Modulemismatch ~= 0;

%% Total of each individual defects

% Create a new variable Total to store total count of each defects
Total = [length(Performance_failures.Module(p1));length(Performance_failures.Module(p2));length(Performance_failures.Module(p3));length(Performance_failures.Module(p4));length(Performance_failures.Module(p5));length(Performance_failures.Module(p6));length(Performance_failures.Module(p7));length(Performance_failures.Module(p8));length(Performance_failures.Module(p9));length(Performance_failures.Module(p10));length(Performance_failures.Module(p11));length(Performance_failures.Module(p12));length(Performance_failures.Module(p13));length(Performance_failures.Module(p14));length(Performance_failures.Module(p15));length(Performance_failures.Module(p16));length(Performance_failures.Module(p17));length(Performance_failures.Module(p18));length(Performance_failures.Module(p19));length(Performance_failures.Module(p20));length(Performance_failures.Module(p21));length(Performance_failures.Module(p22));length(Performance_failures.Module(p23));length(Performance_failures.Module(p24));length(Performance_failures.Module(p25));length(Performance_failures.Module(p26));length(Performance_failures.Module(p27));length(Performance_failures.Module(p28));length(Performance_failures.Module(p29));length(Performance_failures.Module(p30));length(Performance_failures.Module(p31));length(Performance_failures.Module(p32));length(Performance_failures.Module(p33));length(Performance_failures.Module(p34));length(Performance_failures.Module(p35));length(Performance_failures.Module(p36));length(Performance_failures.Module(p37));length(Performance_failures.Module(p38));length(Performance_failures.Module(p39));length(Performance_failures.Module(p40));length(Performance_failures.Module(p41));length(Performance_failures.Module(p42));length(Performance_failures.Module(p43));length(Performance_failures.Module(p44));length(Performance_failures.Module(p45));length(Performance_failures.Module(p46));length(Performance_failures.Module(p47));length(Performance_failures.Module(p48));length(Performance_failures.Module(p49));length(Performance_failures.Module(p50));length(Performance_failures.Module(p51));length(Performance_failures.Module(p52));length(Performance_failures.Module(p53));length(Performance_failures.Module(p54));length(Performance_failures.Module(p55));length(Performance_failures.Module(p56));length(Performance_failures.Module(p57));length(Performance_failures.Module(p58));length(Performance_failures.Module(p59));length(Performance_failures.Module(p60));length(Performance_failures.Module(p61))]; 

%% Percentage of each defects
% To find percentage of each defects

% Begin For loop
for k = 1:61
    % Find percentage of each defects
    Percentage(k,1) = (Total(k)*100)/length(Performance_failures.Module);
    k = k+1;
end

%% CNF/1000 for each defects
% To find percentage of each defects

% Begin For loop
for k = 1:61
    % Find CNF for each defects
    CNF(k,1) = (Percentage(k)*10)/Performance_IV.Age(1);
    k = k+1;
end

%% Average degradation rate for each performance defects

q1 = Performance_IV.Frontglasslightlysoiled ~= 0;
q2 = Performance_IV.Frontglassheavilysoiled ~= 0;
q3 = Performance_IV.Frontglasscrazing ~= 0;
q4 = Performance_IV.Frontglasschip ~= 0;
q5 = Performance_IV.Frontglassmilkydiscoloration ~= 0;
q6 = Performance_IV.Rearglasscrazing ~= 0;
q7 = Performance_IV.Rearglasschipped ~= 0;
q8 = Performance_IV.Edgesealdelamination ~= 0;
q9 = Performance_IV.Edgesealmoisturepenetration ~= 0;
q10 = Performance_IV.Edgesealdiscoloration ~= 0;
q11 = Performance_IV.Edgesealsqueezedpinchedout ~= 0;
q12 = Performance_IV.Framebent ~= 0;
q13 = Performance_IV.Framediscoloration ~= 0;
q14 = Performance_IV.Frameadhesivedegraded ~= 0;
q15 = Performance_IV.Frameadhesiveoozedout ~= 0;
q16 = Performance_IV.Frameadhesivemissinginareas ~= 0;
q17 = Performance_IV.BypassdiodeshortcircuitEquipmentneeded ~= 0;
q18 = Performance_IV.Junctionboxlidloose ~= 0;
q19 = Performance_IV.Junctionboxwarped ~= 0;
q20 = Performance_IV.Junctionboxweathered ~= 0;
q21 = Performance_IV.Junctionboxwireattachmentsloose ~= 0;
q22 = Performance_IV.Junctionboxadhesiveloose ~= 0; 
q23 = Performance_IV.Junctionboxadhesivefelloff ~= 0; 
q24 = Performance_IV.Junctionboxwireattachmentsfelloff ~= 0; 
q25 = Performance_IV.Junctionboxwireattachmentsarced ~= 0; 
q26 = Performance_IV.Wirescorroded ~= 0;
q27 = Performance_IV.Backsheetwavy ~= 0;
q28 = Performance_IV.Backsheetdiscoloration ~= 0;
q29 = Performance_IV.Backsheetbubble ~= 0;
q30 = Performance_IV.Gridlinediscoloration ~= 0;
q31 = Performance_IV.Gridlineblossoming ~= 0;
q32 = Performance_IV.Busbardiscoloration ~= 0;
q33 = Performance_IV.Busbarcorrosion ~= 0;
q34 = Performance_IV.Busbarburnmarks ~= 0;
q35 = Performance_IV.Busbarmisaligned ~= 0;
q36 = Performance_IV.CellInterconnectribbondiscoloration ~= 0;
q37 = Performance_IV.CellInterconnectribboncorrosion ~= 0;
q38 = Performance_IV.CellInterconnectribbonburnmark ~= 0;
q39 = Performance_IV.StringInterconnectdiscoloration ~= 0;
q40 = Performance_IV.StringInterconnectcorrosion ~= 0;
q41 = Performance_IV.CellInterconnectribbonbreak ~= 0;
q42 = Performance_IV.StringInterconnectbreak ~= 0;
q43 = Performance_IV.StringInterconnectburnmark ~= 0;
q44 = Performance_IV.Celldiscoloration ~= 0;
q45 = Performance_IV.CellburnMark ~= 0;
q46 = Performance_IV.Cellchippingcrack ~= 0;
q47 = Performance_IV.Cellmoisturepenetration ~= 0;
q48 = Performance_IV.CellwormmarkSnailTracks ~= 0;
q49 = Performance_IV.Cellforeignparticleembedded ~= 0;
q50 = Performance_IV.Interconnectdiscoloration ~= 0;
q51 = Performance_IV.SolderbondFatigueFailureEquipmentneeded ~= 0;
q52 = Performance_IV.Hotspotlessthan20CEquipmentneeded ~= 0;
q53 = Performance_IV.Encapsulantdelaminationoverthecell ~= 0;
q54 = Performance_IV.Encapsulantdelaminationunderthecell ~= 0;
q55 = Performance_IV.Encapsulantdelaminationoverthejunctionbox ~= 0;
q56 = Performance_IV.Encapsulantdelaminationnearinterconnectorfingers ~= 0;
q57 = Performance_IV.Encapsulantdiscolorationyellowingbrowning ~= 0;
q58 = Performance_IV.ThinFilmModuleDiscoloration ~= 0;
q59 = Performance_IV.ThinFilmModuleDelaminationAbsorberTCOlayer ~= 0;
q60 = Performance_IV.ThinFilmModuleDelaminationARcoating ~= 0;
q61 = Performance_IV.Modulemismatch ~= 0;

% Create a new varaiable Average_Degradation to store average degradation rate of each defects
Average_Degradation = [mean(Performance_IV.RdPmax(q1));mean(Performance_IV.RdPmax(q2));mean(Performance_IV.RdPmax(q3));mean(Performance_IV.RdPmax(q4));mean(Performance_IV.RdPmax(q5));mean(Performance_IV.RdPmax(q6));mean(Performance_IV.RdPmax(q7));mean(Performance_IV.RdPmax(q8));mean(Performance_IV.RdPmax(q9));mean(Performance_IV.RdPmax(q10));mean(Performance_IV.RdPmax(q11));mean(Performance_IV.RdPmax(q12));mean(Performance_IV.RdPmax(q13));mean(Performance_IV.RdPmax(q14));mean(Performance_IV.RdPmax(q15));mean(Performance_IV.RdPmax(q16));mean(Performance_IV.RdPmax(q17));mean(Performance_IV.RdPmax(q18));mean(Performance_IV.RdPmax(q19));mean(Performance_IV.RdPmax(q20));mean(Performance_IV.RdPmax(q21));mean(Performance_IV.RdPmax(q22));mean(Performance_IV.RdPmax(q23));mean(Performance_IV.RdPmax(q24));mean(Performance_IV.RdPmax(q25));mean(Performance_IV.RdPmax(q26));mean(Performance_IV.RdPmax(q27));mean(Performance_IV.RdPmax(q28));mean(Performance_IV.RdPmax(q29));mean(Performance_IV.RdPmax(q30));mean(Performance_IV.RdPmax(q31));mean(Performance_IV.RdPmax(q32));mean(Performance_IV.RdPmax(q33));mean(Performance_IV.RdPmax(q34));mean(Performance_IV.RdPmax(q35));mean(Performance_IV.RdPmax(q36));mean(Performance_IV.RdPmax(q37));mean(Performance_IV.RdPmax(q38));mean(Performance_IV.RdPmax(q39));mean(Performance_IV.RdPmax(q40));mean(Performance_IV.RdPmax(q41));mean(Performance_IV.RdPmax(q42));mean(Performance_IV.RdPmax(q43));mean(Performance_IV.RdPmax(q44));mean(Performance_IV.RdPmax(q45));mean(Performance_IV.RdPmax(q46));mean(Performance_IV.RdPmax(q47));mean(Performance_IV.RdPmax(q48));mean(Performance_IV.RdPmax(q49));mean(Performance_IV.RdPmax(q50));mean(Performance_IV.RdPmax(q51));mean(Performance_IV.RdPmax(q52));mean(Performance_IV.RdPmax(q53));mean(Performance_IV.RdPmax(q54));mean(Performance_IV.RdPmax(q55));mean(Performance_IV.RdPmax(q56));mean(Performance_IV.RdPmax(q57));mean(Performance_IV.RdPmax(q58));mean(Performance_IV.RdPmax(q59));mean(Performance_IV.RdPmax(q60));mean(Performance_IV.RdPmax(q61))];  
Average_Degradation1 = [mean(Performance_IV.RdVoc(q1));mean(Performance_IV.RdVoc(q2));mean(Performance_IV.RdVoc(q3));mean(Performance_IV.RdVoc(q4));mean(Performance_IV.RdVoc(q5));mean(Performance_IV.RdVoc(q6));mean(Performance_IV.RdVoc(q7));mean(Performance_IV.RdVoc(q8));mean(Performance_IV.RdVoc(q9));mean(Performance_IV.RdVoc(q10));mean(Performance_IV.RdVoc(q11));mean(Performance_IV.RdVoc(q12));mean(Performance_IV.RdVoc(q13));mean(Performance_IV.RdVoc(q14));mean(Performance_IV.RdVoc(q15));mean(Performance_IV.RdVoc(q16));mean(Performance_IV.RdVoc(q17));mean(Performance_IV.RdVoc(q18));mean(Performance_IV.RdVoc(q19));mean(Performance_IV.RdVoc(q20));mean(Performance_IV.RdVoc(q21));mean(Performance_IV.RdVoc(q22));mean(Performance_IV.RdVoc(q23));mean(Performance_IV.RdVoc(q24));mean(Performance_IV.RdVoc(q25));mean(Performance_IV.RdVoc(q26));mean(Performance_IV.RdVoc(q27));mean(Performance_IV.RdVoc(q28));mean(Performance_IV.RdVoc(q29));mean(Performance_IV.RdVoc(q30));mean(Performance_IV.RdVoc(q31));mean(Performance_IV.RdVoc(q32));mean(Performance_IV.RdVoc(q33));mean(Performance_IV.RdVoc(q34));mean(Performance_IV.RdVoc(q35));mean(Performance_IV.RdVoc(q36));mean(Performance_IV.RdVoc(q37));mean(Performance_IV.RdVoc(q38));mean(Performance_IV.RdVoc(q39));mean(Performance_IV.RdVoc(q40));mean(Performance_IV.RdVoc(q41));mean(Performance_IV.RdVoc(q42));mean(Performance_IV.RdVoc(q43));mean(Performance_IV.RdVoc(q44));mean(Performance_IV.RdVoc(q45));mean(Performance_IV.RdVoc(q46));mean(Performance_IV.RdVoc(q47));mean(Performance_IV.RdVoc(q48));mean(Performance_IV.RdVoc(q49));mean(Performance_IV.RdVoc(q50));mean(Performance_IV.RdVoc(q51));mean(Performance_IV.RdVoc(q52));mean(Performance_IV.RdVoc(q53));mean(Performance_IV.RdVoc(q54));mean(Performance_IV.RdVoc(q55));mean(Performance_IV.RdVoc(q56));mean(Performance_IV.RdVoc(q57));mean(Performance_IV.RdVoc(q58));mean(Performance_IV.RdVoc(q59));mean(Performance_IV.RdVoc(q60));mean(Performance_IV.RdVoc(q61))]; 
Average_Degradation2 = [mean(Performance_IV.RdIsc(q1));mean(Performance_IV.RdIsc(q2));mean(Performance_IV.RdIsc(q3));mean(Performance_IV.RdIsc(q4));mean(Performance_IV.RdIsc(q5));mean(Performance_IV.RdIsc(q6));mean(Performance_IV.RdIsc(q7));mean(Performance_IV.RdIsc(q8));mean(Performance_IV.RdIsc(q9));mean(Performance_IV.RdIsc(q10));mean(Performance_IV.RdIsc(q11));mean(Performance_IV.RdIsc(q12));mean(Performance_IV.RdIsc(q13));mean(Performance_IV.RdIsc(q14));mean(Performance_IV.RdIsc(q15));mean(Performance_IV.RdIsc(q16));mean(Performance_IV.RdIsc(q17));mean(Performance_IV.RdIsc(q18));mean(Performance_IV.RdIsc(q19));mean(Performance_IV.RdIsc(q20));mean(Performance_IV.RdIsc(q21));mean(Performance_IV.RdIsc(q22));mean(Performance_IV.RdIsc(q23));mean(Performance_IV.RdIsc(q24));mean(Performance_IV.RdIsc(q25));mean(Performance_IV.RdIsc(q26));mean(Performance_IV.RdIsc(q27));mean(Performance_IV.RdIsc(q28));mean(Performance_IV.RdIsc(q29));mean(Performance_IV.RdIsc(q30));mean(Performance_IV.RdIsc(q31));mean(Performance_IV.RdIsc(q32));mean(Performance_IV.RdIsc(q33));mean(Performance_IV.RdIsc(q34));mean(Performance_IV.RdIsc(q35));mean(Performance_IV.RdIsc(q36));mean(Performance_IV.RdIsc(q37));mean(Performance_IV.RdIsc(q38));mean(Performance_IV.RdIsc(q39));mean(Performance_IV.RdIsc(q40));mean(Performance_IV.RdIsc(q41));mean(Performance_IV.RdIsc(q42));mean(Performance_IV.RdIsc(q43));mean(Performance_IV.RdIsc(q44));mean(Performance_IV.RdIsc(q45));mean(Performance_IV.RdIsc(q46));mean(Performance_IV.RdIsc(q47));mean(Performance_IV.RdIsc(q48));mean(Performance_IV.RdIsc(q49));mean(Performance_IV.RdIsc(q50));mean(Performance_IV.RdIsc(q51));mean(Performance_IV.RdIsc(q52));mean(Performance_IV.RdIsc(q53));mean(Performance_IV.RdIsc(q54));mean(Performance_IV.RdIsc(q55));mean(Performance_IV.RdIsc(q56));mean(Performance_IV.RdIsc(q57));mean(Performance_IV.RdIsc(q58));mean(Performance_IV.RdIsc(q59));mean(Performance_IV.RdIsc(q60));mean(Performance_IV.RdIsc(q61))];
Average_Degradation3 = [mean(Performance_IV.RdFF(q1));mean(Performance_IV.RdFF(q2));mean(Performance_IV.RdFF(q3));mean(Performance_IV.RdFF(q4));mean(Performance_IV.RdFF(q5));mean(Performance_IV.RdFF(q6));mean(Performance_IV.RdFF(q7));mean(Performance_IV.RdFF(q8));mean(Performance_IV.RdFF(q9));mean(Performance_IV.RdFF(q10));mean(Performance_IV.RdFF(q11));mean(Performance_IV.RdFF(q12));mean(Performance_IV.RdFF(q13));mean(Performance_IV.RdFF(q14));mean(Performance_IV.RdFF(q15));mean(Performance_IV.RdFF(q16));mean(Performance_IV.RdFF(q17));mean(Performance_IV.RdFF(q18));mean(Performance_IV.RdFF(q19));mean(Performance_IV.RdFF(q20));mean(Performance_IV.RdFF(q21));mean(Performance_IV.RdFF(q22));mean(Performance_IV.RdFF(q23));mean(Performance_IV.RdFF(q24));mean(Performance_IV.RdFF(q25));mean(Performance_IV.RdFF(q26));mean(Performance_IV.RdFF(q27));mean(Performance_IV.RdFF(q28));mean(Performance_IV.RdFF(q29));mean(Performance_IV.RdFF(q30));mean(Performance_IV.RdFF(q31));mean(Performance_IV.RdFF(q32));mean(Performance_IV.RdFF(q33));mean(Performance_IV.RdFF(q34));mean(Performance_IV.RdFF(q35));mean(Performance_IV.RdFF(q36));mean(Performance_IV.RdFF(q37));mean(Performance_IV.RdFF(q38));mean(Performance_IV.RdFF(q39));mean(Performance_IV.RdFF(q40));mean(Performance_IV.RdFF(q41));mean(Performance_IV.RdFF(q42));mean(Performance_IV.RdFF(q43));mean(Performance_IV.RdFF(q44));mean(Performance_IV.RdFF(q45));mean(Performance_IV.RdFF(q46));mean(Performance_IV.RdFF(q47));mean(Performance_IV.RdFF(q48));mean(Performance_IV.RdFF(q49));mean(Performance_IV.RdFF(q50));mean(Performance_IV.RdFF(q51));mean(Performance_IV.RdFF(q52));mean(Performance_IV.RdFF(q53));mean(Performance_IV.RdFF(q54));mean(Performance_IV.RdFF(q55));mean(Performance_IV.RdFF(q56));mean(Performance_IV.RdFF(q57));mean(Performance_IV.RdFF(q58));mean(Performance_IV.RdFF(q59));mean(Performance_IV.RdFF(q60));mean(Performance_IV.RdFF(q61))];

% Create a new varaiable Median_Degradation to store Median degradation rate of each defects
Median_Degradation = [median(Performance_IV.RdPmax(q1));median(Performance_IV.RdPmax(q2));median(Performance_IV.RdPmax(q3));median(Performance_IV.RdPmax(q4));median(Performance_IV.RdPmax(q5));median(Performance_IV.RdPmax(q6));median(Performance_IV.RdPmax(q7));median(Performance_IV.RdPmax(q8));median(Performance_IV.RdPmax(q9));median(Performance_IV.RdPmax(q10));median(Performance_IV.RdPmax(q11));median(Performance_IV.RdPmax(q12));median(Performance_IV.RdPmax(q13));median(Performance_IV.RdPmax(q14));median(Performance_IV.RdPmax(q15));median(Performance_IV.RdPmax(q16));median(Performance_IV.RdPmax(q17));median(Performance_IV.RdPmax(q18));median(Performance_IV.RdPmax(q19));median(Performance_IV.RdPmax(q20));median(Performance_IV.RdPmax(q21));median(Performance_IV.RdPmax(q22));median(Performance_IV.RdPmax(q23));median(Performance_IV.RdPmax(q24));median(Performance_IV.RdPmax(q25));median(Performance_IV.RdPmax(q26));median(Performance_IV.RdPmax(q27));median(Performance_IV.RdPmax(q28));median(Performance_IV.RdPmax(q29));median(Performance_IV.RdPmax(q30));median(Performance_IV.RdPmax(q31));median(Performance_IV.RdPmax(q32));median(Performance_IV.RdPmax(q33));median(Performance_IV.RdPmax(q34));median(Performance_IV.RdPmax(q35));median(Performance_IV.RdPmax(q36));median(Performance_IV.RdPmax(q37));median(Performance_IV.RdPmax(q38));median(Performance_IV.RdPmax(q39));median(Performance_IV.RdPmax(q40));median(Performance_IV.RdPmax(q41));median(Performance_IV.RdPmax(q42));median(Performance_IV.RdPmax(q43));median(Performance_IV.RdPmax(q44));median(Performance_IV.RdPmax(q45));median(Performance_IV.RdPmax(q46));median(Performance_IV.RdPmax(q47));median(Performance_IV.RdPmax(q48));median(Performance_IV.RdPmax(q49));median(Performance_IV.RdPmax(q50));median(Performance_IV.RdPmax(q51));median(Performance_IV.RdPmax(q52));median(Performance_IV.RdPmax(q53));median(Performance_IV.RdPmax(q54));median(Performance_IV.RdPmax(q55));median(Performance_IV.RdPmax(q56));median(Performance_IV.RdPmax(q57));median(Performance_IV.RdPmax(q58));median(Performance_IV.RdPmax(q59));median(Performance_IV.RdPmax(q60));median(Performance_IV.RdPmax(q61))];  
Median_Degradation1 = [median(Performance_IV.RdVoc(q1));median(Performance_IV.RdVoc(q2));median(Performance_IV.RdVoc(q3));median(Performance_IV.RdVoc(q4));median(Performance_IV.RdVoc(q5));median(Performance_IV.RdVoc(q6));median(Performance_IV.RdVoc(q7));median(Performance_IV.RdVoc(q8));median(Performance_IV.RdVoc(q9));median(Performance_IV.RdVoc(q10));median(Performance_IV.RdVoc(q11));median(Performance_IV.RdVoc(q12));median(Performance_IV.RdVoc(q13));median(Performance_IV.RdVoc(q14));median(Performance_IV.RdVoc(q15));median(Performance_IV.RdVoc(q16));median(Performance_IV.RdVoc(q17));median(Performance_IV.RdVoc(q18));median(Performance_IV.RdVoc(q19));median(Performance_IV.RdVoc(q20));median(Performance_IV.RdVoc(q21));median(Performance_IV.RdVoc(q22));median(Performance_IV.RdVoc(q23));median(Performance_IV.RdVoc(q24));median(Performance_IV.RdVoc(q25));median(Performance_IV.RdVoc(q26));median(Performance_IV.RdVoc(q27));median(Performance_IV.RdVoc(q28));median(Performance_IV.RdVoc(q29));median(Performance_IV.RdVoc(q30));median(Performance_IV.RdVoc(q31));median(Performance_IV.RdVoc(q32));median(Performance_IV.RdVoc(q33));median(Performance_IV.RdVoc(q34));median(Performance_IV.RdVoc(q35));median(Performance_IV.RdVoc(q36));median(Performance_IV.RdVoc(q37));median(Performance_IV.RdVoc(q38));median(Performance_IV.RdVoc(q39));median(Performance_IV.RdVoc(q40));median(Performance_IV.RdVoc(q41));median(Performance_IV.RdVoc(q42));median(Performance_IV.RdVoc(q43));median(Performance_IV.RdVoc(q44));median(Performance_IV.RdVoc(q45));median(Performance_IV.RdVoc(q46));median(Performance_IV.RdVoc(q47));median(Performance_IV.RdVoc(q48));median(Performance_IV.RdVoc(q49));median(Performance_IV.RdVoc(q50));median(Performance_IV.RdVoc(q51));median(Performance_IV.RdVoc(q52));median(Performance_IV.RdVoc(q53));median(Performance_IV.RdVoc(q54));median(Performance_IV.RdVoc(q55));median(Performance_IV.RdVoc(q56));median(Performance_IV.RdVoc(q57));median(Performance_IV.RdVoc(q58));median(Performance_IV.RdVoc(q59));median(Performance_IV.RdVoc(q60));median(Performance_IV.RdVoc(q61))]; 
Median_Degradation2 = [median(Performance_IV.RdIsc(q1));median(Performance_IV.RdIsc(q2));median(Performance_IV.RdIsc(q3));median(Performance_IV.RdIsc(q4));median(Performance_IV.RdIsc(q5));median(Performance_IV.RdIsc(q6));median(Performance_IV.RdIsc(q7));median(Performance_IV.RdIsc(q8));median(Performance_IV.RdIsc(q9));median(Performance_IV.RdIsc(q10));median(Performance_IV.RdIsc(q11));median(Performance_IV.RdIsc(q12));median(Performance_IV.RdIsc(q13));median(Performance_IV.RdIsc(q14));median(Performance_IV.RdIsc(q15));median(Performance_IV.RdIsc(q16));median(Performance_IV.RdIsc(q17));median(Performance_IV.RdIsc(q18));median(Performance_IV.RdIsc(q19));median(Performance_IV.RdIsc(q20));median(Performance_IV.RdIsc(q21));median(Performance_IV.RdIsc(q22));median(Performance_IV.RdIsc(q23));median(Performance_IV.RdIsc(q24));median(Performance_IV.RdIsc(q25));median(Performance_IV.RdIsc(q26));median(Performance_IV.RdIsc(q27));median(Performance_IV.RdIsc(q28));median(Performance_IV.RdIsc(q29));median(Performance_IV.RdIsc(q30));median(Performance_IV.RdIsc(q31));median(Performance_IV.RdIsc(q32));median(Performance_IV.RdIsc(q33));median(Performance_IV.RdIsc(q34));median(Performance_IV.RdIsc(q35));median(Performance_IV.RdIsc(q36));median(Performance_IV.RdIsc(q37));median(Performance_IV.RdIsc(q38));median(Performance_IV.RdIsc(q39));median(Performance_IV.RdIsc(q40));median(Performance_IV.RdIsc(q41));median(Performance_IV.RdIsc(q42));median(Performance_IV.RdIsc(q43));median(Performance_IV.RdIsc(q44));median(Performance_IV.RdIsc(q45));median(Performance_IV.RdIsc(q46));median(Performance_IV.RdIsc(q47));median(Performance_IV.RdIsc(q48));median(Performance_IV.RdIsc(q49));median(Performance_IV.RdIsc(q50));median(Performance_IV.RdIsc(q51));median(Performance_IV.RdIsc(q52));median(Performance_IV.RdIsc(q53));median(Performance_IV.RdIsc(q54));median(Performance_IV.RdIsc(q55));median(Performance_IV.RdIsc(q56));median(Performance_IV.RdIsc(q57));median(Performance_IV.RdIsc(q58));median(Performance_IV.RdIsc(q59));median(Performance_IV.RdIsc(q60));median(Performance_IV.RdIsc(q61))];
Median_Degradation3 = [median(Performance_IV.RdFF(q1));median(Performance_IV.RdFF(q2));median(Performance_IV.RdFF(q3));median(Performance_IV.RdFF(q4));median(Performance_IV.RdFF(q5));median(Performance_IV.RdFF(q6));median(Performance_IV.RdFF(q7));median(Performance_IV.RdFF(q8));median(Performance_IV.RdFF(q9));median(Performance_IV.RdFF(q10));median(Performance_IV.RdFF(q11));median(Performance_IV.RdFF(q12));median(Performance_IV.RdFF(q13));median(Performance_IV.RdFF(q14));median(Performance_IV.RdFF(q15));median(Performance_IV.RdFF(q16));median(Performance_IV.RdFF(q17));median(Performance_IV.RdFF(q18));median(Performance_IV.RdFF(q19));median(Performance_IV.RdFF(q20));median(Performance_IV.RdFF(q21));median(Performance_IV.RdFF(q22));median(Performance_IV.RdFF(q23));median(Performance_IV.RdFF(q24));median(Performance_IV.RdFF(q25));median(Performance_IV.RdFF(q26));median(Performance_IV.RdFF(q27));median(Performance_IV.RdFF(q28));median(Performance_IV.RdFF(q29));median(Performance_IV.RdFF(q30));median(Performance_IV.RdFF(q31));median(Performance_IV.RdFF(q32));median(Performance_IV.RdFF(q33));median(Performance_IV.RdFF(q34));median(Performance_IV.RdFF(q35));median(Performance_IV.RdFF(q36));median(Performance_IV.RdFF(q37));median(Performance_IV.RdFF(q38));median(Performance_IV.RdFF(q39));median(Performance_IV.RdFF(q40));median(Performance_IV.RdFF(q41));median(Performance_IV.RdFF(q42));median(Performance_IV.RdFF(q43));median(Performance_IV.RdFF(q44));median(Performance_IV.RdFF(q45));median(Performance_IV.RdFF(q46));median(Performance_IV.RdFF(q47));median(Performance_IV.RdFF(q48));median(Performance_IV.RdFF(q49));median(Performance_IV.RdFF(q50));median(Performance_IV.RdFF(q51));median(Performance_IV.RdFF(q52));median(Performance_IV.RdFF(q53));median(Performance_IV.RdFF(q54));median(Performance_IV.RdFF(q55));median(Performance_IV.RdFF(q56));median(Performance_IV.RdFF(q57));median(Performance_IV.RdFF(q58));median(Performance_IV.RdFF(q59));median(Performance_IV.RdFF(q60));median(Performance_IV.RdFF(q61))];

%% Defects names
Defects = {'Front glass lightly soiled';'Front glass heavily soiled';'Front glass crazing';'Front glass chip';'Front glass milky discoloration';'Rear glass crazing';'Rear glass chipped';'Edge seal delamination';'Edge seal moisture penetration';'Edge seal discoloration';'Edge seal squeezed / pinched out';'Frame bent';'Frame discoloration';'Frame adhesive degraded';'Frame adhesive oozed out';'Frame adhesive missing in areas';'Bypass diode short circuit (Equipment needed)';'Junction box lid loose';'Junction box warped';'Junction box weathered';'Junction box wire attachments loose';'Junction box adhesive loose';'Junction box adhesive fell off';'Junction box wire attachments fell off';'Junction box wire attachments arced';'Wires corroded';'Backsheet wavy';'Backsheet discoloration';'Backsheet bubble';'Gridline discoloration';'Gridline blossoming';'Busbar discoloration';'Busbar corrosion';'Busbar burn marks';'Busbar misaligned';'Cell Interconnect ribbon discoloration';'Cell Interconnect ribbon corrosion';'Cell Interconnect ribbon burn mark';'String Interconnect discoloration';'String Interconnect corrosion';'Cell Interconnect ribbon break';'String Interconnect break';'String Interconnect burn mark';'Cell discoloration';'Cell burn mark';'Cell chipping/crack';'Cell moisture penetration';'Cell worm mark (Snail Tracks)';'Cell foreign particle embedded';'Interconnect Discoloration';'Solder bond Fatigue / Failure (Equipment needed)';'Hotspot less than 20 deg C (Equipment needed)';'Encapsulant delamination over the cell';'Encapsulant delamination under the cell';'Encapsulant delamination over the junction box';'Encapsulant delamination near interconnect or fingers';'Encapsulant discoloration (yellowing/browning)';'Thin Film Module Discoloration';'Thin Film Module Delamination - Absorber/TCO layer';'Thin Film Module Delamination - AR coating';'Module mismatch'};


%% Occurence of safety defects in FMECA table
% To create a new varaiable Occurence to store occurence of each defects
% Begin For loop
for k = 1:61
    if(CNF(k) <= 0.01)
        Occurence(k,1) = 1;
    elseif(CNF(k) > 0.01 && CNF(k) <= 0.1)
        Occurence(k,1) = 2;
    elseif(CNF(k) > 0.1 && CNF(k) <= 0.5)
        Occurence(k,1) = 3;
    elseif(CNF(k) > 0.5 && CNF(k) <= 1)
        Occurence(k,1) = 4;
    elseif(CNF(k) > 1 && CNF(k) <= 2)
        Occurence(k,1) = 5;
    elseif(CNF(k) > 2 && CNF(k) <= 5)
        Occurence(k,1) = 6;
    elseif(CNF(k) > 5 && CNF(k) <= 10)
        Occurence(k,1) = 7;
    elseif(CNF(k) > 10 && CNF(k) <= 20)
        Occurence(k,1) = 8;
    elseif(CNF(k) > 20 && CNF(k) <= 50)
        Occurence(k,1) = 9;
    else
        Occurence(k,1) = 10;
    end
    k = k+1;
end

%% Detection in FMECA table
% To create a new varaiable Detection to store detection of each defects
Detection = [2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;6;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;8;2;2;2;2;2;2;2;2;2;8];

%% Severity in FMECA table
% To create a new varaiable Severity to store severity of each defects
% Begin for loop
for k = 1:61
    if(Average_Degradation(k) < 0.3)
        Severity(k,1) = 1;
    elseif(Average_Degradation(k) == 0.3)
        Severity(k,1) = 2;
    elseif(Average_Degradation(k) > 0.3 && Average_Degradation(k) < 0.5)
        Severity(k,1) = 3;
    elseif(Average_Degradation(k) >= 0.5 && Average_Degradation(k) < 0.6)
        Severity(k,1) = 4;
    elseif(Average_Degradation(k) >= 0.6 && Average_Degradation(k) < 0.8)
        Severity(k,1) = 5;
    elseif(Average_Degradation(k) >= 0.8 && Average_Degradation(k) <= 1)
        Severity(k,1) = 6;
    elseif(Average_Degradation(k) > 1 && Average_Degradation(k) <= 1.5)
        Severity(k,1) = 7;
    elseif(Average_Degradation(k) > 1.5 && Average_Degradation(k) <= 2 )
        Severity(k,1) = 8;
    elseif(Average_Degradation(k) > 2)
        Severity(k,1) = 9;
    else
        Severity(k,1) = 0;
    end
  k = k+1;
end

for k = 1:61
    if(Average_Degradation1(k) < 0.3)
        Severity1(k,1) = 1;
    elseif(Average_Degradation1(k) == 0.3)
        Severity1(k,1) = 2;
    elseif(Average_Degradation1(k) >= 0.3 && Average_Degradation1(k) < 0.5)
        Severity1(k,1) = 3;
    elseif(Average_Degradation1(k) >= 0.5 && Average_Degradation1(k) < 0.6)
        Severity1(k,1) = 4;
    elseif(Average_Degradation1(k) >= 0.6 && Average_Degradation1(k) < 0.8)
        Severity1(k,1) = 5;
    elseif(Average_Degradation1(k) >= 0.8 && Average_Degradation1(k) <= 1)
        Severity1(k,1) = 6;
    elseif(Average_Degradation1(k) > 1)
        Severity1(k,1) = 7; 
    elseif(Average_Degradation1(k) > 1 && Average_Degradation1(k) <= 1.5)
        Severity1(k,1) = 7;
    elseif(Average_Degradation1(k) > 1.5 && Average_Degradation1(k) <= 2 )
        Severity1(k,1) = 8;
    elseif(Average_Degradation1(k) > 2)
        Severity1(k,1) = 9;
    else
        Severity1(k,1) = 0;
    end
  k = k+1;
end

for k = 1:61
    if(Average_Degradation2(k) < 0.3)
        Severity2(k,1) = 1;
    elseif(Average_Degradation2(k) == 0.3)
        Severity2(k,1) = 2;
    elseif(Average_Degradation2(k) >= 0.3 && Average_Degradation2(k) < 0.5)
        Severity2(k,1) = 3;
    elseif(Average_Degradation2(k) >= 0.5 && Average_Degradation2(k) < 0.6)
        Severity2(k,1) = 4;
    elseif(Average_Degradation2(k) >= 0.6 && Average_Degradation2(k) < 0.8)
        Severity2(k,1) = 5;
    elseif(Average_Degradation2(k) >= 0.8 && Average_Degradation2(k) <= 1)
        Severity2(k,1) = 6;
    elseif(Average_Degradation2(k) > 1)
        Severity2(k,1) = 7; 
    elseif(Average_Degradation2(k) > 1 && Average_Degradation2(k) <= 1.5)
        Severity2(k,1) = 7;
    elseif(Average_Degradation2(k) > 1.5 && Average_Degradation2(k) <= 2 )
        Severity2(k,1) = 8;
    elseif(Average_Degradation2(k) > 2)
        Severity2(k,1) = 9;
    else
        Severity2(k,1) = 0;
    end
  k = k+1;
end

for k = 1:61
    if(Average_Degradation3(k) < 0.3)
        Severity3(k,1) = 1;
    elseif(Average_Degradation3(k) == 0.3)
        Severity3(k,1) = 2;
    elseif(Average_Degradation3(k) >= 0.3 && Average_Degradation3(k) < 0.5)
        Severity3(k,1) = 3;
    elseif(Average_Degradation3(k) >= 0.5 && Average_Degradation3(k) < 0.6)
        Severity3(k,1) = 4;
    elseif(Average_Degradation3(k) >= 0.6 && Average_Degradation3(k) < 0.8)
        Severity3(k,1) = 5;
    elseif(Average_Degradation3(k) >= 0.8 && Average_Degradation3(k) <= 1)
        Severity3(k,1) = 6;
    elseif(Average_Degradation3(k) > 1)
        Severity3(k,1) = 7; 
    elseif(Average_Degradation3(k) > 1 && Average_Degradation3(k) <= 1.5)
        Severity3(k,1) = 7;
    elseif(Average_Degradation3(k) > 1.5 && Average_Degradation3(k) <= 2 )
        Severity3(k,1) = 8;
    elseif(Average_Degradation3(k) > 2)
        Severity3(k,1) = 9;
    else
        Severity3(k,1) = 0;
    end
  k = k+1;
end

for k=1:61
    % Calculate RPN for each defects
    RPN(k,1) = Severity(k,1)*Detection(k,1)*Occurence(k,1);
    RPN_Voc(k,1) = Severity1(k,1)*Detection(k,1)*Occurence(k,1);
    RPN_Isc(k,1) = Severity2(k,1)*Detection(k,1)*Occurence(k,1);
    RPN_FF(k,1) = Severity3(k,1)*Detection(k,1)*Occurence(k,1);
    k = k+1;
end

for k=1:61
    % calculate RPN using severity and occurence
    RPN_SO(k,1) = Severity(k,1)*Occurence(k,1);
    k = k+1;
end

%% FMECA table

FMECA2 = table(Defects,Total,Percentage,Average_Degradation,Average_Degradation1,Average_Degradation2,Average_Degradation3,Median_Degradation,Median_Degradation1,Median_Degradation2,Median_Degradation3,CNF,Severity,Occurence,Detection,RPN,RPN_Voc,RPN_Isc,RPN_FF);
FMECA = table(Defects,Total,Percentage,Average_Degradation,CNF,Severity,Occurence,Detection,RPN,RPN_SO);


%% Performance RPN due to Average degradation rates of Pmax, Voc, Isc, FF
% to remove defects that are not present
toDelete = FMECA2.RPN <= 0;
FMECA2(toDelete,:) = [];

% to plot different performance RPN together
o = FMECA2.RPN;
p = FMECA2.RPN_Voc;
q = FMECA2.RPN_Isc;
r = FMECA2.RPN_FF;
s = FMECA2.Defects;

f = [o,p,q,r];
figure(6);
set(gcf,'Color',[1,1,1]);
bar(f);
set(gca, 'XTickLabel',s,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',16,'Color',[1 0 0]);
ylabel({'Performance RPN'},'FontSize',16,'Color',[1 0 0]);
ylim([0,1000]);
title(' Performance RPN comparison using degradation rates of Pmax, Voc, Isc, FF ','FontSize',20,'Color',[1 0 0]);
legend('Pmax','Voc','Isc','FF','Location','northeastoutside');
orient landscape;
print('Performance RPN comparison','-dpdf','-r0')












