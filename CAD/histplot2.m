clc; clear;
close all;
data1=2*rand(1,500)+2;
data2=randn(1,500)+3;
n1=length(data1);
[freq1,x1]=hist(data1,25);
rfreq1=freq1/n1;
n2=length(data2);
[freq2,x2]=hist(data2,25);
rfreq2=freq2/n2;

subplot(2,1,1),bar(x1,rfreq1),title('Relative histogram of data1'), grid,...
    xlabel('x'),ylabel('relative frequency'),...
subplot(2,1,2),bar(x2,rfreq2),title('Relative histogram of data2'),grid,...
    xlabel('x'),ylabel('relative frequency')