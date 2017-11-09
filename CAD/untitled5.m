clc; clear;
b=[1 -2 1]; % s^2 -2s +1
a=[1 3 4 2]; % s^3 +3s^2 + 4s +2
[c,r,q]=residue(a,b)
