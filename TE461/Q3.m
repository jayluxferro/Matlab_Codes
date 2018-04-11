%{
    Question 3
    Rectifier circuit 
%}

%% default
clc; clear; close all;

%% Initializations
t = linspace(0,10,1000);
x = abs(cos(t));
plot(t,x),title('Rectification'),xlabel('t(s)'),ylabel('Amplitude'),...
    grid on, box on;