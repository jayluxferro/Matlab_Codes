% curve fitting for pricing
clear;
clc;
close all;
x = [1, 2.1, 2.1, 2.4, 2.6, 3.5, 3.7, 4.5, 4.7, 9.4, 9.5];
y = [5, 6, 6, 7, 7, 8, 8, 12, 13, 17, 23];
a1 = polyfit(x, y, 1);
x1 = linspace(0, length(x), 101);
y1 = polyval(a1, x1);
%a2 = polyfit(x, y, 4);
%y2 = polyval(a2, x1);
plot(x,y,'o',x1,y1,'--'),...%, x1, y2),...
    xlabel('Distance (km)'),ylabel('Price (GHS)'),...
    title('Curve fitting for price estimation'),...
    legend('Measured','1st Degree'),...
    grid('on')