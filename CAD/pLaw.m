clc;
clear;
close all;
v=10:10:60;
p=[100 120 180 250 400 600];

v1=log(v); %x
p1=log(p); %y
a=polyfit(v1,p1,1)
