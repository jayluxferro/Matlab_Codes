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
   
   %performing computations and generating required values
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
   %end of computation generation
   
   
   
   %generating values for plot
   if jay==0
        Pm_sim0=Pm_sim;
        Pm_theory0=Pm_theory;
        Pm_appm0=Pm_appm;
   elseif jay==1
        Pm_sim1=Pm_sim;
        Pm_theory1=Pm_theory;
        Pm_appm1=Pm_appm;
   elseif jay==2
        Pm_sim2=Pm_sim;
        Pm_theory2=Pm_theory;
        Pm_appm2=Pm_appm;
   end
   %end generation of values for plot
   
   jay=jay+1;
end



%final code for graph generation
loglog(Pf,Pm_sim0,'*c',Pf,Pm_theory0,'-.k',Pf,Pm_appm0,'--b',Pf,Pm_sim1,'*g',Pf,Pm_theory1,'-.k',Pf,Pm_appm1,'--b',Pf,Pm_sim2,'*m',Pf,Pm_theory2,'-.k',Pf,Pm_appm2,'--b');
     %setting background color to white
     set(gcf,'color','white');
     %end of background color code
     title('Complementary ROC of ED under AWGN');
     grid on
     axis([0.0001,1,0.0001,1]);
     xlabel('Pf');
     ylabel('Pm');
     legend('Simulation','Theory','Approximation','Simulation2','Theory2','Approximation2','Simulation3','Theory3','Approximation3'); 
%end of final code for graph generation