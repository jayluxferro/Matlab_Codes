%{
    Analyze .csv file
%}

%% Defaults
clc; clear; close all;

%% Get data from file
fileData = input('Enter file name eg: fast.csv: ', 's');
data = readtable(fileData);

%% Display signal
plot(data{:, 1}), xlabel('Time (s)'), ylabel('Amplitude'), title('Waveform');