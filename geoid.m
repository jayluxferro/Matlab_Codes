%{
    Project: Geoid Computation
    Date: 6th September 2019
%}

%% cleanup
clc; clear

%% Parameter definition
g = 1; %  gravity on earth's surface
deltaGGM = 1; % Gravity anomaly from Global Geopotential Model (GGM)
rho = 2.67; % Topographic density, rho = g/cm^3
h = 1; % height of point ellipsoid
hRef = 1; % Ellipsoidal heights for actual and reference ellipsoid surface points
G = 1; % Gravitational constant
H = 1; % Orthometric constant
theta = pi/2; % Geodetic latitude
gamma = 9.78032677 * (1 + 0.0053045 * (sin(theta))^2 - 0.0000058 * (sin(2 * theta))^2); % Normal gravity

%% ?g (phi, gamma) = g ? ?
deltaG = g - gamma;

%% Residual Gravity Anomalies ?g res = ?g ? ?g GGM -2?G ? (h ? h ref)
deltaGRES = (deltaG - deltaGGM) - 2 * pi * rho * (h - hRef);

%% Bougner Gravity Anomaly
deltaGB = deltaG - (2 * pi * rho * H);

%% Terrain Correction Tc = ?g B - ?g + 2?G ? H
Tc = deltaGB - deltaG + 2 * pi * G * H;

%% Residual Faye Surface Gravity Anomalies ?g Faye res = ?g ? ?g GGM
deltaGFR = deltaG - deltaGGM;

%% Geocentric latitude
psi = atan((1 - exp(2)) * tan(theta));

%% Stokes function
sPSI = (sin(psi/2))^(-1) - ( 6 * sin(psi/2)) + 1 - (5 * cos(psi)) - 3 * cos(log((sin(psi/2) + (sin(psi/2))^2)));

%% Residual Height Anomaly
