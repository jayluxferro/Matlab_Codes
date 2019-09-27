%Designing a butterworth band pass filter
clc;
clear;
wp=[0.45,0.65];
ws=[0.3,0.75];
rp=1;
rs=40;
[N,Wn]=buttord(wp,ws,rp,rs);
[b,a]=butter(N,Wn);
[h,omega]=freqz(b,a,256);
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Butterworth Band-Pass Filter');