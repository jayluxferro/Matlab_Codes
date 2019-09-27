% PIT top marginal rate for Germany, Ghana and Greece using the 'taxdata.xlsx' excel sheet.
clc;
clear;
close all;
pit=xlsread('taxdata.xlsx','I24:I26');
figure(1)
pie(pit,{'Germany','Ghana','Greece'}),title('PIT top marginal rate for Germany, Ghana and Greece')
figure(2)
pie3(pit,{'Germany','Ghana','Greece'}),title('PIT top marginal rate for Germany, Ghana and Greece')