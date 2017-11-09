%elliptic bandpass filter
clc; 
clear;
fp=[200 280];
fs=[160 300];
rp=0.1;
rs=70;
ft=1600;
wp=(2.*fp)./ft;
ws=(2.*fs)./ft;
[N,Wn]=ellipord(wp,ws,rp,rs) %#ok
fprintf('N(BPF)= %d\n',2*N);
[b,a]=ellip(N,rp,rs,Wn);
[h,omega]=freqz(b,a,256);
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Elliptic Band Pass Filter');