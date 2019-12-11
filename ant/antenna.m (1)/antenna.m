%% Clear
clear;
close all;
clc;

%% Inputs

disp('Enter known parameters:');
E = input('Enter the permitivity');
h = input('Enter height of substrate (mm)');
f = input('Enter target frequency (GHz)');
z = input('Enter input impedence (ohms)');
disp('Calculating...');
c = 3e8;

%% Calculations

% height
h = h*1e-3;

% freq
f = f*1e9;

% lambda
y = c/f;

% width patch
W = (c/(2*f))*(sqrt(2/(E+1)));

% effective permitivity
Eeff = ((E+1)/2) + (((E-1)/2)*sqrt(1/(1+((12*h)/W))));

% effective length
Leff = (c/(2*f*sqrt(Eeff)));

% dLength
dL = (((0.412*h)*(Eeff+0.3)*((W/h)+(0.26*h)))/((Eeff-0.258)*((W/h)+0.8)));

% Length patch
L = Leff-(2*dL);

% Width substrate
sW = W + (6*h);

% Length substrate
sL = L + (6*h);

% Guided wavelength
yg = y/(sqrt(Eeff));

% Feed length
fL = yg/4;

% Feed width
fW = (1/2)*fL;

% Radiation position
Ap = (-1/2)*yg;

% Radiation width
rW = ((1/3)*yg) + sW;

% Radiation length
rL = ((1/3)*yg) + sL;

% Radiation height
rh = ((1/3)*yg) + h;

% Conductance 1
k = (2*pi)/y;
x = k*W;
i1 = -2 + cos(x)+(x*sinint(x)) + (sin(x)/x);
G1 = i1/(120*pi*pi);

% Conductance 2
a = @(th) (((sin((x./2).*cos(th))./cos(th)).^2).*(besselj(0,(k.*L.*sin(th)))).*(sin(th)).^3);
a1 = integral(a,0,pi);
G12 = a1/(120*pi*pi);
R_in = 1/(2*(G1+G12));

Rin = 1/(2*G1);

% Inset
inset = (L/pi)*(acos(sqrt(z/Rin')));

% Gap
g = (((3e8)*(4.65e-12))/(sqrt(2*Eeff)*(f*(1e-9))));
%% Outputs

disp('Rectangle Patch');
disp(['Patch Width:',num2str(W*(1e3)), ' mm']);
disp(['Patch Length:',num2str(L*(1e3)), ' mm']);
disp(['Substrate Width:',num2str(sW*(1e3)), ' mm']);
disp(['Substrate Length:',num2str(sL*(1e3)), ' mm']);
disp(['Inset:',num2str(inset*(1e3)), ' mm']);
disp(['Inset Gap:',num2str(g*(1e3)), ' mm']);
disp(['Radiation Width:',num2str(rW*(1e3)), ' mm']);
disp(['Radiation Length:',num2str(rL*(1e3)), ' mm']);
disp(['Radiation Height:',num2str(rh*(1e3)), ' mm']);
disp(['Feed Width:',num2str(fW*(1e3)), ' mm']);
disp(['Feed Length:',num2str(fL*(1e3)), ' mm']);