% Chebyshev high pass filter 
% type 2
clear;
clc;
Ft=4000;
Fp=1000;
Fs=600;
Rp=1;
Rs=40;
Wp=(2*Fp)/Ft;
Ws=(2*Fs)/Ft;
[N,Wn]=cheb2ord(Wp,Ws,Rp,Rs)