%{
Name:           Justice Owusu Agyemang
Index Number:   PG9334217
Course Code:    TE 561
Linear phase bandpass fir filter
%}

%% Defaults
clc;
clear;
close all;

%% Design parameters
N = 40;
Wp1 = 0.4;
Wp2 = 0.6;

b = fir1(N,[0.4 0.6]);
freqz(b,1,512)