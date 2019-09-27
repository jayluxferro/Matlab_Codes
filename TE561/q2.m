%TE 561
%Digital Signal Processing
%Question 2
%Cheyshev IIR lowpass filter
clear;
clc;
Wp=0.7;
Ws=0.5;
Rp=1;
Rs=32;
Ft=4;
%Ws=(2*Fs)/Ft
%Fs=(Ws*Ft)/2
[N,Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[b,a]=cheby2(N,Rs,Wn);
[h,omega]=freqz(b,a,256);
figure(2);
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Chebyshev IIR LowPass Filter');