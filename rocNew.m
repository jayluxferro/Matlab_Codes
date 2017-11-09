jay=0;
m=1000;
N=2*m;
Base=0.01:0.02:1;
Pf=Base.^2;


for j=1:3
   if jay==0
       snr_avgdB=-20;
   else
       snr_avgdB=input('Enter the snr_avgdB: ');
   end
   
   %adding main code execution
    snr_avg=power(10,snr_avgdB/10);
for i=1:length(Pf)
    Over_Num=0;
    Th(i)=chi2inv(1-Pf(i),2*m);
     Th(i)=gaminv(1-Pf(i),m,1)*2;
     for kk=1:1000;
         t=1:N;
         x=sin(pi*t);
         noise=randn(1,N);
         pn=mean(noise.^2);
         pn=(std(noise))^2;
         amp=sqrt(noise.^2*snr_avg);
         x=amp.*x./abs(x);
         SNRdb_Sample=10*log10(x.^2/(noise.^2));
         signal=x(1:N);
         ps=mean(abs(signal).^2);
         Rev_sig=signal+noise;
         accum_power(i)=sum(abs(Rev_sig.^2))/pn;
         if accum_power(i)>Th(i)
             Over_Num=Over_Num+1;
         end
     end
end
     Pd_sim(i)=Over_Num/kk;
     Pd_theory(i)=marcumq(sqrt(snr_avg*2*m),sqrt(Th(i)),m);
     Pd_appm(i)=0.5*erfc((sqrt(2)*erfcinv(2*Pf(i))))-(snr_avg*sqrt(m))/(sqrt(2+4*snr_avg));
     Pm_sim=1-Pd_sim;
     Pm_theory=1-Pd_theory;
     Pm_appm=1-Pd_appm;
     %figure
    % subplot(3,1,jay+1)
    if jay==0
     loglog(Pf,Pm_sim,'*r',Pf,Pm_theory,'-.k',Pf,Pm_appm,'--b');
     hold on
     %setting background color to white
     set(gcf,'color','white')
     %end of background color code
     title('Complementary ROC of ED under AWGN')
     grid on
     axis([0.0001,1,0.0001,1]);
     xlabel('Pf');
     ylabel('Pm');
     legend('Simulation','Theory','Approximation');
    elseif jay==1
     loglog(Pf,Pm_sim,'*g',Pf,Pm_theory,'-.k',Pf,Pm_appm,'--b');
     hold on
     %setting background color to white
     set(gcf,'color','white')
     %end of background color code
     title('Complementary ROC of ED under AWGN')
     grid on
     axis([0.0001,1,0.0001,1]);
     xlabel('Pf');
     ylabel('Pm');
     legend('Simulation2','Theory2','Approximation2');  
        
    elseif jay==2
     loglog(Pf,Pm_sim,'*c',Pf,Pm_theory,'-.k',Pf,Pm_appm,'--b');
     hold on
     %setting background color to white
     set(gcf,'color','white')
     %end of background color code
     title('Complementary ROC of ED under AWGN')
     grid on
     axis([0.0001,1,0.0001,1]);
     xlabel('Pf');
     ylabel('Pm');
     legend('Simulation3','Theory3','Approximation3');   
    end   
   %end of main code execution
   
   
   jay=jay+1;
end
    