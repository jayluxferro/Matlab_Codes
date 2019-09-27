%write a matlab m-file to plot the function
%z=x^2ln(x^2+y^2)
close all
clc;
clear;
x=linspace(-10,10,1000);
y=linspace(-10,10,1000);
z=x.^2.*log(x.^2+y.^2);
plot(z,'b');