clc; clear;
close all;
data1=2*rand(1,500)+2;
data2=randn(1,500)+3;
save data
subplot(2,1,1),plot(data1),axis([0 500 0 6]),title('Random Numbers - data1'),...
    subplot(2,1,2),plot(data2),title('Random Numbers - data2'),xlabel('Index,k')