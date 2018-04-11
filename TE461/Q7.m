%{
    Question 7
    Signal strength of a telecom operation 
%}

%% defaults
clc; clear; close all;

%% initialization
x = 0:0.1:1;
y = [0.447 1.978 0.28 1.16 2.08 0.34 1.66 2.56 0.48 1.30 1.25];


%% determining MSE and plotting
degrees = [2 4 8];

for k=1:length(degrees)
    degree = degrees(k);
    a = polyfit(x,y,degree);
    yhat = polyval(a,x);
    err = yhat - y;
    MSE = mean(err.^2);
    figure
    plot(x,y,'o',x,yhat),title('Traffic density'),...
        xlabel('t(h)'),ylabel('Traffic Density(Erl)'),grid on, box on
end