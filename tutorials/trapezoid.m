%example 1
%computation of the area of a trapezoid
clc;
b1=input('Enter first parallel side length: ');
b2=input('Enter second parellel side length: ');
h=input('Enter height of trapezoid: ');
fprintf('The area of the trapezoid is: %.3f\n',(b1+b2)/2*h);