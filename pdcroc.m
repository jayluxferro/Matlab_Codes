close all;
clear all; 
clc;
m=1000;
N=2*m;
Base=0.01:0.05:1;
Pf=Base.^2;
snr_avgdB=-10;
snr_avg=power(10,snr_avgdB/10);
for i=1:length(Pf)
Over_Num=0;
Th(i)=chi2inv(1-Pf(i),2*m);
for kk=1:1000
    t=1:N;
    x=sin(pi*t);
    noise=randn(1,N);
    pn=mean(noise.^2);
    amp=sqrt(noise.^2*snr_avg);
    x=amp.*x./abs(x);
    SNRdB_Sample=10*log10(x.^2./(noise.^2));
    signal=x(1:N);
    ps=mean(abs(signal).^2);
    Rev_sig=signal+noise;
    accum_power(i)=sum(abs(Rev_sig.^2))/pn;
   if accum_power(i)>Th(i)
       Over_Num=Over_Num+1;
   end
end
    Pd_sim(i)=Over_Num/kk;
   % Pd_theory(i)=marcumq(sqrt(snr_avg*2*m),sqrt(Th(i)));
    %Pd_appm(i)=0.5*erfc(((sqrt(2)*erfcinv(2*Pf((i))-snr_avg*sqrt(m)))))/sqrt(2+4*snr_avg);
end
Pm_sim=1-Pd_sim;
%Pm_theory=1-Pd_theory;
%Pm_appm=1-Pd_appm
figure
loglog(Pf,Pm_sim,'--m');
title('Complementary ROC of Energy Detection over AWGN')
grid on
axis([0.0001,1,0.0001,1]);
xlabel('Pf');
ylabel('Pm');
legend('snr=21dB');