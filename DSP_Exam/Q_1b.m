%{
Name:           Justice Owusu Agyemang
Index Number:   PG9334217
Course Code:    TE 561
Design of an elliptic IIR highpass filter 
%}
%% initializations
clc;
clear;
close all;


%% Specifications
Fp = 600;
Fs = 2000;
Rp = 0.8;
Rs = 20;
Ft = 8000;

%% Calculating Wp and Ws
Wp = (2*Fp)/Ft;
Ws = (2*Fs)/Ft;

%% Calculating order of the elliptic IIR highpass filter
[N,Wn] = ellipord(Wp,Ws,Rp,Rs);

%% Computing the impulse reponse coefficients
[b,a] = ellip(N,Rp,Rs,Wn,'high');


%% Plotting the gain response of the elliptic IIR highpass filter
[h,omega] = freqz(b,a,256);
figure(1);
plot(omega/pi,20*log10(abs(h))); grid on;box on;
xlabel('\omega/\pi'),ylabel('Gain, db');
title('IIR Elliptic HighPass Filter');