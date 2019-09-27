%Simulation to plot Probability of Detection (Pd)vs. Probability of false
%alarm
clear
clc
L=1000;
snr_dB=50;
snr=10.^(snr_dB./10);
Pf=0.01:0.01:1;
for m=1:length(Pf)
    i=0;
    for kk=1:10000
        n=randn(1,L);
        s=sqrt(snr).*randn(1,L);
        y=s+n;
        energy=abs(y).^2;
        energy_fin=(1/L).*sum(energy);
        thresh(m)=(qfuncinv(Pf(m))./sqrt(L))+1;
        if(energy_fin>=thresh(m))
            i=i+1;
        end
    end
    Pd(m)=i/kk;
end
%plot(Pf,Pd,'-*m')
%--------------------------------------
plot(snr_dB,Pd,'-*m');
snrlegend=strcat(num2str(snr_dB), ' dB');
%--------------------------------------
grid on
 set(gcf,'color','white')
 legend(strcat('snr=',snrlegend));
hold on
thresh=(qfuncinv(Pf)./sqrt(L))+1;
Pd_the=qfunc(((thresh-(snr+1)).*sqrt(L))./(sqrt(2).*(snr+1)));
hold on