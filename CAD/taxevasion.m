%Tax Evasion
close all;
clc;
clear;
taxEv=xlsread('taxdata.xlsx','P2:P86');
bar(1:length(taxEv),taxEv),xlabel('x'),ylabel('Tax Evasion Value'),title('Tax Evasion'),grid on