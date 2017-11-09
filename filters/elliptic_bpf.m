% Elliptic BPF
clc;
clear;
Ft=1600;
Fp=[200 280];
Fs=[160 300];
Rp=0.1;
Rs=70;

Wp=(2.*Fp)/Ft;
Ws=(2.*Fs)/Ft;

[N,Wn]=ellipord(Wp,Ws,Rp,Rs)