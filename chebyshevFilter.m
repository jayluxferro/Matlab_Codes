%Designing a chebyshev digital high pass filter
clc;
clear;
wp=0.5;
ws=0.3;
rp=1;
rs=40;
[N,Wn]=cheb2ord(wp,ws,rp,rs);
[b,a]=cheby2(N,rp,Wn,'high');
[h,omega]=freqz(b,a,256);
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Cheybeshev High Pass Filter');