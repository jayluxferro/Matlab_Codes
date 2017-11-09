%Linear regression
clc;
clear; 
close all;
x=0:5;
y=[0 20 60 68 77 110];
yhat=20*x;
err=yhat-y;
MSE=mean(err.^2);
RMSE=sqrt(MSE);
plot(x,y,'o',x,yhat),title('Linear Estimate'),...
    xlabel('time(s)'),ylabel('Temperature(F)'),...
    grid, axis([-1,6,-2,120]),legend('measured','estimated')