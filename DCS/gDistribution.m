% Gaussian Distribution
close all;
clear;
clc;

k = linspace(-50, 50, 1000);

p = (1/sqrt(2*pi)) .* exp(-(k.^2)/2);
plot(k, p)