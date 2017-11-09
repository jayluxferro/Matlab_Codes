%Capacitor Discharging
%13th October, 2016
clc;
clear;
close all;
disp('Capacitor Discharging')
pause(1)
V=5;
Vc=linspace(0,10,1000);
R=5;
C=10^(-3);
t=-R*C*log(1-(Vc/V));
%plotting t against Vc(t)
figure(1);
plot(Vc,t),xlabel('V_c(t)'),ylabel('t(s)'),title('t(s) against V_c(t)'),grid ,box 


%performing subplots
t=linspace(0,10,1000);
Vc=V*(1-exp(-t./(R*C)));

figure(2);
subplot(2,2,1);
plot(t,Vc),xlabel('t(s)'),ylabel('V_c(t)'),title('V_c(t) against t(s)'),grid,box;

subplot(2,2,2);
plot(log(t),Vc),xlabel('log_e(t)'),ylabel('V_c(t)'),title('V_c(t) against log_e(t)'),grid,box;

subplot(2,2,3);
plot(t,log(Vc)),xlabel('t(s)'),ylabel('log_eV_c(t)'),title('log_eV_c(t) against t(s)'),grid,box;

subplot(2,2,4);
plot(log(t),log(Vc)),xlabel('log_et'),ylabel('log_eV_c(t)'),title('log_eV_c(t) against log_et'),grid,box;
