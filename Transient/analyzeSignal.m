%{
    Analyze .csv file
%}

%% Defaults
clc; clear; close all;

%% Get data from file
%fileData = input('Enter file name eg: fast.csv: ', 's');
data = readtable('Fast1.CSV');

hEnv = [];
sizeOfData = size(data);
for k = 1:sizeOfData(1)
   hEnv(k) = data{k, 1} ;
end

%% Display signal
%plot(data{:, 1}), xlabel('Time (s)'), ylabel('Amplitude'), title('Waveform');