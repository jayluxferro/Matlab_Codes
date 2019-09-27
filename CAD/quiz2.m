% plotting z=x^2ln(x^2+y^2)
clc;
clear;
close all;
x=linspace(-10,10,1000);
y=linspace(-10,10,1000);
z=x.^2.*log(x.^2+y.^2);
figure
plot3(x,y,z),title('z=x^2ln(x^2+y^2)'),xlabel('x'),ylabel('y'),zlabel('z'),...
    grid on