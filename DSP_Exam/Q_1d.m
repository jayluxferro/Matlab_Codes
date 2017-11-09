%{
Name:           Justice Owusu Agyemang
Index Number:   PG9334217
Course Code:    TE 561
Design of a bandpass filter: The worst type of filter
%}

%% Defaults
clc;
clear;
close all;


%% Design specifications
Wp = [0.45 0.65];
Ws = [0.3 0.75];
Rp = 1;
Rs = 40;

%% All the four filters
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


%% Conclusion
msgbox('The elliptic bandpass filter in the first place has ripples. Also at 1dB compression point, the elliptic bandpass filter does not have a sharp cut-off as compared to the Chebyshev type 2 filter. This makes it the worst among the four filters.','Conclusion');
%{
The elliptic bandpass filter in the first place has ripples. Also
at 1dB compression point, the elliptic bandpass filter doesn't have a sharp cut-off. 
 This makes it the worst among the four filters.
%}



