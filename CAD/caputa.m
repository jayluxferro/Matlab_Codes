function [x1,x2]=caputa(a,b,c)
% e.g. solve ax^2+bx+c=0
% caputa(a,b,c)
x1{1}=(-b+sqrt(b^2-4*a*c))/(2*a);x1{2}=(-b-sqrt(b^2-4*a*c))/(2*a);