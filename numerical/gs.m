% Gauss seidel method for solving 3 linear equations
clear
clc
x1=0.1;
x2=0.1;
x3=0.1;
Iterations=4;
n=Iterations;
xa=zeros(1,n);
xb=zeros(1,n);
xc=zeros(1,n);
ite=zeros(1,n);
for i=1:1:n
    x1=3*x1 - cos(x2 * x3) - 0.5;
    xa(1,i)=x1;
    x2=x1^2 - 81*(x2 + 0.1)^2 + sin(x3) + 1.06;
    xb(1,i)=x2;
    x3=exp(-x1*x2) + (20*x3) + (((10*pi)-3)/3);
    xc(1,i)=x3;
    ite(1,i)=i;
    disp(sprintf('Iteration:%i',i)); 
    disp(x1);
    disp(x2);
    disp(x3);
end