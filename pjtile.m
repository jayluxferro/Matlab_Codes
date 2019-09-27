% Flight trajectory computation
%
% Initial values
g = 32.2;
v = 50 * 5280/3600;
theta = 30 * pi/180;
% gravity, ft/s^2
% launch velocity, ft/s
% launch angle, radians
% Compute and display results
disp('time of flight (s):')
% label for time of flight
tg = 2 * v * sin(theta)/g
% time to return to ground, s
disp('distance traveled (ft):') % label for distance
xg = v * cos(theta) * tg
% distance traveled
% Compute and plot flight trajectory
t = linspace(0,tg,256);
x = v * cos(theta) * t;
y = v * sin(theta) * t - g/2 * t.^2;
plot(x,y), axis equal, axis([ 0 150 0 30 ]), grid, ...
xlabel('Distance (ft)'), ylabel('Height (ft)'), title('Flight Trajectory')