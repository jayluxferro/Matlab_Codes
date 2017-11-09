	% sinusoidal representation and plotting\\
	t=linspace(-1,1,101);
	x=2*cos(2*pi*t);
	y=2*cos(2*pi*(t-0.125));
	z=2*sin(2*pi*t); 
	plot(t,x,t,y,t,z), axis([-1,1,-3,3]),title('Sinusoidal Signals'),... 
       xlabel('Amplitude'), ylabel('Time(s)'),text(-0.13,1.75,'x'),...
        text(-0.07,1.25,'y'),text(0.01,0.80,'z'),grid