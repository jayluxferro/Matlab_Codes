% capacitor discharging
clc;
clear;
close all;
t = linspace(0,10,1000);
v=10;
r=5;
c=10e-3;
vc = v*(1-exp(-t./(r*c)));
plot(t,vc),axis([0 10 0 15])