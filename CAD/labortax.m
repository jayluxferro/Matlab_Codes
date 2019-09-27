%labor tax 
close all;
clc;
clear;
Data=xlsread('taxdata.xlsx','F2:F86');
hist(Data),title('Labor Tax'), xlabel('x'),ylabel('N'),grid on;