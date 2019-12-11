clear
clc
f=@(x)x*x*x - 4*x - 9; %Write your function f(x), where f(x)=0.
fd=@(x) 3*x*x - 4;%Write the derivative of the function f'(x).
x0=input('\n Enter initial guess '); %initial guess of the root. For exmple here x0=2.
epsilon=input('\n Enter the error '); %error of tolerance you want. for exmple 0.001 or 0.0001 etc.
%Formula: x1=x0-f(x0)/f'(x0);
 x1=x0-f(x0)/fd(x0);
 err=abs(x1-x0);
while err > epsilon
    x1=x0-f(x0)/fd(x0);
    err=abs(x1-x0);
    x0=x1;
end

fprintf('\n The root is %4.3f \n',x0)
