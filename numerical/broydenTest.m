%{
    Broyden test
%}
clc; clear;
x = broyden(str2sym('x1+2*x2-2'),str2sym('x1^2+4*x2^2-4'),[1 1]',50)