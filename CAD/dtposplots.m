%DTPOSPLOTS
%
%
clc;
clear; 
close all;
disp('Reading data for 200 vehicles')
A_200=xlsread('DTPOSPLOTS.xlsx','A2:A101');
MT_200_ACO=xlsread('DTPOSPLOTS.xlsx','B2:B101');
MT_200_NO_ACO=xlsread('DTPOSPLOTS.xlsx','C2:C101');
n_arrival_200=A_200.*(200/100);
figure(1)
hold on
plot(n_arrival_200,MT_200_ACO),grid on, xlabel('Number of Vehicles arriving'),ylabel('Mean Travel Time');
plot(n_arrival_200,MT_200_NO_ACO),legend('DTPOSPLOTS-ACO','DTPOSPLOTS-NO-ACO');
hold off





%plotting figure 2
PA_200=xlsread('DTPOSPLOTS.xlsx','E2:E11');
T_200_ACO=xlsread('DTPOSPLOTS.xlsx','F2:F11');
T_200_NO_ACO=xlsread('DTPOSPLOTS.xlsx','G2:G11');
figure(2)
hold on
plot(PA_200,T_200_ACO),grid on, xlabel('Percentage of vehicles arriving(%)'),...
    ylabel('Time(ticks)');
plot(PA_200,T_200_NO_ACO),legend('DTPOSPLOTS-ACO','DTPOSPLOTS-NO-ACO');
hold off

