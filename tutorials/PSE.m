%Problem Solving Example
%Computational Implementation
%Author: Justice Owusu Agyemang
%Date: 18th September, 2016
%Objective: Flight Trajectory Computation

%clearing command window
clc;

%Initial Values
g=32.2;                 % Acceleration due to gravity
v=50*5280/3600;         % inital velocity, ft/s
theta=30*pi/180;        % Trajectory angle, radians

%computing the time of flight and distance traveled
tg=2*v*sin(theta)/g;
xg=v*cos(theta)*tg;
fprintf('Time of flight %.3f\n', tg)
fprintf('Distance traveled %.3f\n', xg)

%computing and plotting the flight trajectory
t=linspace(0,tg,256);
x=v*cos(theta)*t;
y=v*sin(theta)*t-(g/2*t.^2);

plot(x,y), axis equal, axis([0 150 0 30]), grid, ...
    xlabel('Distance traveled(ft)'),ylabel('Height(ft)'), ...
    title('Flight Trajectory')
