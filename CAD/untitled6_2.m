%Polynomial
clc;
s=linspace(-1,3,201);
	a=[1 4 -7 -10];
	A=polyval(a,s);
	plot(s,A),...
		title('Polynomial Function A(s)=s^3 + 4s^2 - 7s -10'),...
		xlabel('s'),...
		ylabel('A(s)')