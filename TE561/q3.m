%TE 561
%Digital Signal Processing
%Question 3
%BandPass filter
clear;
clc;

%declaring variables
Fp=[100 200];
Fs=[100 900];
Ft=50;
Wp=[0.45 0.65];
Ws=[0.3 0.75];
Rp=1;
Rs=40;
%end of variables declaration

%.....................................
%butterworth
[N,Wn]=buttord(Wp,Ws,Rp,Rs);
[b,a]=butter(N,Wn);
[h,omega]=freqz(b,a,256);
figure(1)
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Butterworth Band-Pass Filter');
%end of butterworth
%..... ................................


%.....................................
%chebyshev
[N,Wn]=cheb1ord(Wp,Ws,Rp,Rs);
[b,a]=cheby1(N,Rp,Wn);
[h,omega]=freqz(b,a,256);
figure(2)
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Type 1 Cheybeshev BandPass Filter');

[N,Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[b,a]=cheby2(N,Rp,Wn);
[h,omega]=freqz(b,a,256);
figure(3)
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Type 2 Cheybeshev BandPass Filter');
%end of chebyshev
%.....................................

%......................................
%elliptic
[N,Wn]=ellipord(Wp,Ws,Rp,Rs);
fprintf('N(BPF)= %d\n',2*N);
[b,a]=ellip(N,Rp,Rs,Wn);
[h,omega]=freqz(b,a,256);
figure(4)
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Elliptic Band Pass Filter');
%end of elliptic
%.......................................


%Either butterworth filter or type 1 chebyshev filter will be appropriate
disp('Either butterworth filter or type 1 chebyshev filter will be appropriate')