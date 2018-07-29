%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Mathan Kumar Moorthy
% Organization: PhotoVoltaic Reliability Laboratory
% Date: 11/04/2015
% Code details: This code is used for combining  
% results from PeformRPN and SafeRPN codes
% to generate Global RPN rsults
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Safety and Performance RPN
clear;
clc;
SafeRPN;
PerformRPN;
Piechart;

%% Global RPN
C = union(FMECA1,FMECA);
% to remove defects that are not present
toDelete = C.RPN <= 0;
C(toDelete,:) = [];

% to remove data from table C where Average degradation shows NaN
toDelete1 = isnan(C.Average_Degradation);
C(toDelete1,:) = [];
D = C;

% sort rows in table D
[D,index] = sortrows(D,{'Severity'},{'ascend'});

% Export table D as FMECA results in excel spreadsheet format
filename = 'FMECA_results.xlsx';
writetable(D,filename,'Sheet',1); 

%% Calculate total performance RPN 
TotalPerformanceRpn = sum(FMECA.RPN);

%% Get the total Global RPN from the data
GlobalRpn = sum(D.RPN);
GlobalRpn_SO = sum(D.RPN_SO);

%% Calculate the total safety RPN 
TotalSafetyRPN = GlobalRpn - TotalPerformanceRpn;

%% user input data
prompt = 'Enter the type of climate (Hot Dry/Cold Dry/Hot Humid/Temperate): ';
str1 = input(prompt,'s');
prompt = 'Enter Powerplant Name: ';
str2 = input(prompt,'s');
prompt = 'Enter Module type: ';
str3 = input(prompt,'s');
climate1 = 'Hot Dry';
climate2 = 'Cold Dry';
climate3 = 'Hot Humid';
climate4 = 'Temperate';

%% Generate performance RPN plot, Safety RPN plot, Global RPN plot and Global RPN plot without detection rating based on climate
if(strcmpi(str1,climate1))
    % Generate Performance RPN plot
    figure(1);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA.RPN,'FaceColor',[1 0 0],'BarWidth',0.5);
    xlim([0,62]);
    ylim([0,1000]);
    set(gca,'XTick',[1:61]);
    set(gca, 'XTickLabel',FMECA.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',8,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    %Reference: https://en.wikibooks.org/wiki/MATLAB_Programming/Inserting_Newlines_into_Plot_Labels
    title(['Performance RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Performance RPN - ',num2str(TotalPerformanceRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','PerformanceRPN')
    
    % Generate Safety RPN plot
    figure(2);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA1.RPN,'FaceColor',[1 0 0],'BarWidth',0.5);
    xlim([0,26]);
    ylim([0,1000]);
    set(gca,'XTick',[1:25]);
    set(gca, 'XTickLabel',FMECA1.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Safety RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Safety RPN - ',num2str(TotalSafetyRPN)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','SafetyRPN')
    
    % Generate Global RPN plot
    figure(3)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN,'FaceColor',[1 0 0],'BarWidth',0.5);
    ylim([0,1000]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','GlobalRPN')
    
    % Generate Global RPN plot without detection
    figure(7)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN_SO,'FaceColor',[1 0 0],'BarWidth',0.5);
    ylim([0,100]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN using Severity and Occurence - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn_SO)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','GlobalRPNSO')
    
elseif(strcmpi(str1,climate2))
    figure(1);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA.RPN,'FaceColor',[0 0 0.5],'BarWidth',0.5);
    xlim([0,62]);
    ylim([0,1000]);
    set(gca,'XTick',[1:61]);
    set(gca, 'XTickLabel',FMECA.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Performance RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Performance RPN - ',num2str(TotalPerformanceRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Performance RPN')
    
    figure(2);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA1.RPN,'FaceColor',[0 0 0.5],'BarWidth',0.5);
    xlim([0,26]);
    ylim([0,1000]);
    set(gca,'XTick',[1:25]);
    set(gca, 'XTickLabel',FMECA1.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Safety RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Safety RPN - ',num2str(TotalSafetyRPN)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Safety RPN')
    
    figure(3)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN,'FaceColor',[0 0 0.5],'BarWidth',0.5);
    ylim([0,1000]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Global RPN')
    
    figure(7)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN_SO,'FaceColor',[0 0 0.5],'BarWidth',0.5);
    ylim([0,100]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN using Severity and Occurence - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn_SO)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Global RPN using Severity and Occurence')
    
elseif(strcmpi(str1,climate3))
    figure(1);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA.RPN,'FaceColor',[1 0.5 0],'BarWidth',0.5);
    xlim([0,62]);
    ylim([0,1000]);
    set(gca,'XTick',[1:61]);
    set(gca, 'XTickLabel',FMECA.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Performance RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Performance RPN - ',num2str(TotalPerformanceRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Performance RPN')
    
    figure(2);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA1.RPN,'FaceColor',[1 0.5 0],'BarWidth',0.5);
    xlim([0,26]);
    ylim([0,1000]);
    set(gca,'XTick',[1:25]);
    set(gca, 'XTickLabel',FMECA1.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Safety RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Safety RPN - ',num2str(TotalSafetyRPN)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Safety RPN')
    
    figure(3)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN,'FaceColor',[1 0.5 0],'BarWidth',0.5);
    ylim([0,1000]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Global RPN')
    
    figure(7)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN_SO,'FaceColor',[1 0.5 0],'BarWidth',0.5);
    ylim([0,100]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN using Severity and Occurence - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn_SO)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Global RPN using Severity and Occurence')
    
    
elseif(strcmpi(str1,climate4))
    figure(1);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA.RPN,'FaceColor',[0 1 0],'BarWidth',0.5);
    xlim([0,62]);
    ylim([0,1000]);
    set(gca,'XTick',[1:61]);
    set(gca, 'XTickLabel',FMECA.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Performance RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Performance RPN - ',num2str(TotalPerformanceRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Performance RPN')
    
    figure(2);
    set(gcf,'Color',[1,1,1]);
    bar(FMECA1.RPN,'FaceColor',[0 1 0],'BarWidth',0.5);
    xlim([0,26]);
    ylim([0,1000]);
    set(gca,'XTick',[1:25]);
    set(gca, 'XTickLabel',FMECA1.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Safety RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Safety RPN - ',num2str(TotalSafetyRPN)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Safety RPN')
    
    figure(3)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN,'FaceColor',[0 1 0],'BarWidth',0.5);
    ylim([0,1000]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Global RPN')
    
    figure(7)
    set(gcf,'Color',[1,1,1]);
    bar(D.RPN_SO,'FaceColor',[0 1 0],'BarWidth',0.5);
    ylim([0,100]);
    set(gca, 'XTickLabel',D.Defects,'XTickLabelRotation',45,'FontWeight','bold','FontSize',9,'Position',[0.0556368960468521 0.465635738831615 0.929721815519766 0.464518900343643]);
    xlabel({'Defects/Failures'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    ylabel({'RPN'},'EdgeColor',[0 0 0],'FontSize',10,'Color',[1 0 0]);
    title(['Global RPN using Severity and Occurence - ',str2,10,'Modules - ',num2str(length(Performance_IV.Module)),' ( ',str3,' )','; ',str1,' climate; Field Age - ',num2str(Performance_IV.Age(1)),'; ','Total Global RPN - ',num2str(GlobalRpn_SO)],'FontSize',10,'Color',[1 0 0]);
    orient landscape;
    print('-dpdf','-r0','Global RPN using Severity and Occurence')
else
    disp('No Plots available - Enter climate as shown in paranthesis in prompt');
end


%% Severity, Occurence and Detection plot
u = D.Severity;
v = D.Occurence;
w = D.Detection;
y = D.Defects;

l = [u,v,w];
figure(4);
set(gcf,'Color',[1,1,1]);
bar(l);
set(gca, 'XTickLabel',y,'XTickLabelRotation',45);
xlabel({'Defects'},'FontSize',16,'Color',[1 0 0]);
ylabel({'Ranking'},'FontSize',16,'Color',[1 0 0]);
title(' Defects vs Ranking ','FontSize',20,'Color',[1 0 0]);
legend('Severity','Occurence','Detection','Location','northeastoutside');
print('-dpdf','-r0','Defects Vs Ranking');


