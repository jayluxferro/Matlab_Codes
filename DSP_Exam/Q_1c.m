%{
Name:           Justice Owusu Agyemang
Index Number:   PG9334217
Course Code:    TE 561
Design of a digital Type 1 Chebyshev lowpass filter
%}

%% Defaults
clc;
clear;
close all;

%% Design specifications
Fp = 4000;
Rp = 0.5;
Rs = 45;
Ft = 80000;
Fs = 6000;

%% Computing Wp and Ws
Wp = (2*Fp)/Ft;
Ws = (2*Fs)/Ft;

%% Determining the order 
[N,Wn]=cheb1ord(Wp,Ws,Rp,Rs);

%% The impulse response coefficients
[b,a]=cheby1(N,Rp,Wn);

%% plotting the gain response of the filter
[h,omega]=freqz(b,a,256);
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('Type 1 Cheybeshev Low Pass Filter');

