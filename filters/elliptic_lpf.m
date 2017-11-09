%Designing an elliptic LPF
clc;
clear;
Ft=4000;
Fp=800;
Fs=1000;
Rp=0.5;
Rs=40;

Wp=(2*Fp)/Ft;
Ws=(2*Fs)/Ft;

[N,Wn]=ellipord(Wp,Ws,Rp,Rs);
[b,a]=ellip(N,Rp,Rs,Wn);
[h,omega]=freqz(b,a,256);
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Elliptic Low Pass Filter');