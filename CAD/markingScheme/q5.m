%% Question 5
% Generate a mesh, surface and contour plot of f(x,y)=-ye^{(x^2+y^2)} and
% repeat same for its inverse using an interval of x=[-2,2] and y=[-2,2]
clear;
clc;
close all;
x=linspace(-2,2,1000);
y=linspace(-2,2,1000);
[X,Y]=meshgrid(x,y);
Z=(-Y).*exp((X.^2 +Y.^2));
figure
mesh(X,Y,Z),title('Mesh Plot of -ye^{(x^2+y^2)}'),xlabel('x'),ylabel('y'),...
    zlabel('z')

figure
surf(X,Y,Z),title('Surface Plot of -ye^{(x^2+y^2)}'),xlabel('x'),ylabel('y'),...
    zlabel('z')

figure
contour(X,Y,Z),title('Contour Plot of -ye^{(x^2+y^2)}'),xlabel('x'),ylabel('y'),...
    zlabel('z')

%% considering the inverse
Z=(-Y).*exp(-(X.^2 +Y.^2));
figure
mesh(X,Y,Z),xlabel('x'),ylabel('y'),...
    zlabel('z'),title('Mesh Plot of -Y*exp(-(X^2 +Y^2))')

figure
surf(X,Y,Z),xlabel('x'),ylabel('y'),...
    zlabel('z'),title('Surface Plot of -Y.*exp(-(X^2 +Y^2))')

figure
contour(X,Y,Z),xlabel('x'),ylabel('y'),...
    zlabel('z'),title('Contour Plot of -Y*exp(-(X^2 +Y^2))')
