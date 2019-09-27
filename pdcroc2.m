close all;
clear all; 
clc;
m=1000;
N=2*m;
Base=0.01:0.05:1;
Pf=Base.^2;

enc=0;
%--- 3 iterations ---%
for enk=1:3
    snr_avgdB=input('Enter the snr_avgdB: ');
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

%getting values for each iteration
if enk==1
    Pm_sim1=Pm_sim;
    snr_avgdB1=snr_avgdB;
    snr1=strcat(num2str(snr_avgdB1), ' dB');
elseif enk==2
    Pm_sim2=Pm_sim;
    snr_avgdB2=snr_avgdB;
    snr2=strcat(num2str(snr_avgdB2), ' dB');
elseif enk==3
     Pm_sim3=Pm_sim;
     snr_avgdB3=snr_avgdB;
     snr3=strcat(num2str(snr_avgdB3), ' dB');
end


%Pm_theory=1-Pd_theory;
%Pm_appm=1-Pd_appm

enc=enc+1;
end


%plotting results based on data received...
figure
loglog(Pf,Pm_sim1,'--m',Pf,Pm_sim2,'--r',Pf,Pm_sim3,'--b');
set(gcf,'color','white');
title('Complementary ROC of Energy Detection over AWGN')
grid on
axis([0.0001,1,0.0001,1]);
xlabel('Pf');
ylabel('Pm');
legend(strcat('snr=',snr1),strcat('snr=',snr2),strcat('snr=',snr3));
