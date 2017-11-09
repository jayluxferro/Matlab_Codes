%% Question 1
% It is required to determine the output noise power, develop a
% mathematical model and an accompanying M-File for the determination of
% the average output noise power P_n in terms of freqency
clc;
clear;
No=input('Enter the value for N_o: ');
R=input('Enter the resistance value: ');
C=input('Enter the capacitance value: ');
fc=1/(2*pi*R*C);
Pout=(1/4)*No*fc;
fprintf('The average output noise power Pn is %.3f\n',Pout);