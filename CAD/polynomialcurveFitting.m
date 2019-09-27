%polynomial curve fitting
clc;
clear;
close all;
x=0:0.1:1;
y=[-0.447 1.978 3.28 6.16 7.08 7.34 7.66 9.56 9.48 9.30 11.2];
a2=polyfit(x,y,2);
a10=polyfit(x,y,10);
xi=linspace(0,1,101);
yi2=polyval(a2,xi);
yi10=polyval(a10,xi);
plot(x,y,'o',xi,yi2,'--',xi,yi10),...
    xlabel('x'),ylabel('y'),...
    title('2nd and 10th Degree Polynomial Curve Fit'),...
    legend('Measured','2nd Degree','10th Degree')