close all;
t=linspace(0,10,100);
x=sin(t);
x=x.*(x>0);
plot(t,x),xlabel('Time(s)'),ylabel('Amplitude'),...
    title('Discontinuous Signal'), axis([0 10 -0.1 1.1]),grid on