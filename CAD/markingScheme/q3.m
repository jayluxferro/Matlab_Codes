%% Question 3
% A rectifier circuit receives a sinuisoidal signal and rectifies the
% negative output to positive. Write a MATLAB M-File to demonstrate the
% rectifier action using x(t)=sin(t) as the input signal. Plot the
% rectified signal over the interval t=[0,10].

t = linspace(0,10,1000);
 y = abs(sin(t));
 plot(t,y),xlabel('t(s)'),ylabel('Amplitude'),grid on, title('Rectifier Action');