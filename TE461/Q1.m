%{
    Question 1
    Determination fo the average output noise power Pn in terms of
    frequency
%}

%% default
clc; clear; close all;

disp('Output noise power calculation');

%% Taking inputs from user
f = input('Enter the frequency in Hz: ');
N = input('Enter the noise spectral density: ');
Po = (N/2) * pi * f;
fprintf('The output noise power is %.3f W\n', Po);