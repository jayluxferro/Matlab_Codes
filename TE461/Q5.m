%{
    Mesh, Surface and contour subplots
%}

%% default
clc; clear; close all;

x = linspace(-2,2,100);
y = linspace(-2,2,100);
[X,Y] = meshgrid(x,y);
Z = exp(-(X.^2 + Y.^2));

%% plotting mesh, surface and contour
subplot(3,1,1);
mesh(X,Y,Z);
xlabel('X'),ylabel('Y'),title('Mesh');

subplot(3,1,2);
surf(X,Y,Z);
xlabel('X'),ylabel('Y'),title('Surface');

subplot(3,1,3);
contour(x,y,Z);
xlabel('X'),ylabel('Y'),title('Contour');