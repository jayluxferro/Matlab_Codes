% Gauss seidel method for solving 3 linear equations
% 5x1-x2+2x3=12
% 3x1+8x2-2x3=-25
% x1+x2+4x3=6
% Result is x1=1; x2=-3; x3=2
clear all
clc
x1=input('Enter the assumed value of x1 :');
x2=input('Enter the assumed value of x2 :');
x3=input('Enter the assumed value of x3 :');
Iterations=input('Enter the number of iterations :');
n=Iterations;
xa=zeros(1,n);
xb=zeros(1,n);
xc=zeros(1,n);
ite=zeros(1,n);
for i=1:1:n
    x1=(12+x2-(2*x3))/5;
    xa(1,i)=x1;
    x2=(-25-(3*x1)+(2*x3))/8;
    xb(1,i)=x2;
    x3=(6-x1-x2)/4;
    xc(1,i)=x3;
    ite(1,i)=i;
    disp(sprintf('Iteration:%i',i)); 
    disp(x1);
    disp(x2);
    disp(x3);
    xa_actual(1,i)=1;
    xb_actual(1,i)=-3;
    xc_actual(1,i)=2;
end
% Plotting of convergence of parameters
% Plotting of x1 vs actual value
subplot(3,1,1);
plot(ite,xa_actual,'blue',ite,xa,'red');
xlabel('Iteration');
ylabel('X1 value');
title('Convergence characteristic of X1')
% Plotting of x2 vs actual value
subplot(3,1,2);
plot(ite,xb_actual,'blue',ite,xb,'red');
xlabel('Iteration');
ylabel('X2 value');
title('Convergence characteristic of X2')
% Plotting of x1 vs actual value
subplot(3,1,3);
plot(ite,xc_actual,'blue',ite,xc,'red');
xlabel('Iteration');
ylabel('X1 value');
title('Convergence characteristic of X3')
%##########################################################################