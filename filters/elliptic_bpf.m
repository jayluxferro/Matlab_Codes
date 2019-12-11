% Elliptic BPF
clc;
clear;
Ft=10000;
Fp=[350 1000];
Fs=[300 1100];
Rp=0.002;
Rs=0.01;

Wp=(2.*Fp)/Ft;
Ws=(2.*Fs)/Ft;

[N,Wn]=ellipord(Wp,Ws,Rp,Rs)