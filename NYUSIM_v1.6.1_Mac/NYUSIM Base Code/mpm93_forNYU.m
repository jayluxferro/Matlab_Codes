%%% NYUSIM - User License %%%

% Copyright (c) 2018 New York University and NYU WIRELESS

% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the “Software”),
% to deal in the Software without restriction, including without limitation 
% the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, and to permit persons to whom the 
% Software is furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software. Users shall cite 
% NYU WIRELESS publications regarding this work.

% THE SOFTWARE IS PROVIDED “AS IS”, WITHOUTWARRANTY OF ANY KIND, EXPRESS OR 
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
% THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
% OTHER LIABILITY, WHETHER INANACTION OF CONTRACT TORT OR OTHERWISE, 
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
% OTHER DEALINGS IN THE SOFTWARE.

% MPM93 - non-official matlab version
% written by Mike Cotton (NTIA/ITS, mcotton@its.bldrdoc.gov, 303-497-7346),
% and revised by Shu Sun (New York University and NYU WIRELESS,
% ss7152@nyu.edu)

function attenFactor = mpm93_forNYU(f,p,u,t,RR)

if f<1
    f = 1;
end

adNpNpp = 0; % 0 = attenuation, 1 = delay, 2 = N', 3 = N''
len = length(f);
V = 300./(t+273.15); % reciprocal temperature variable

% ICE FLAG
ice = zeros(1,len);
if t(1)<=-40; ice = ones(1,len); % hard-coded parameter
elseif t(1)<=0 && t(1)>-40; ice = 1*ones(1,len); % user-defined ice flag
end

% WATER DROPLET DENSITY
W = zeros(1,len); % water droplent density if u < 80%
for k = 1:len
  if u(k)>99.95
    W(k) = 1; % user-defined water droplet density used if u > 99.95% or u = 0%
  % if 80% <= u <= 99.95%, then define W with haze model
  elseif u(k) >= 80 && u(k) <= 99.95
    WA = 1; % Aerosol density (g/m^3) at u=80%
    HZ = 3; % Haze model: 1=rural, 2=urban, 3=maritime, 4=maritime w/ strong wind 
    W(k) = hazeModel(u(k),HZ,WA);
  end
end

% PARTIAL PRESSURES
Es = saturationPress(t,ice); % compute saturation pressure (mb)
e = Es.*u/100; % partial pressure for water vapor (mb)
p_d = p - e; % partial pressure for dry air (mb)
idx2 = find(p_d<0);
if ~isempty(idx2)
  p_d(idx2) = 0;
  e(idx2) = p(idx2);
end

% WATER PERMITTIVITY
Eps = h2oPermittivity(V,ice);

% OXYGEN
NO2Lines = o2Lines(f,V,p_d,e);     %Ad[0] Ad[4]

% DRY AIR CONTINUUM
NdryAir = dryCont(f,V,p_d,e);   %Ad[1] Ad[5]

% WATER VAPOR
Nh2oVapor = h2oVapor(f,V,p_d,e);    %Ad[2] Ad[6]

% LIQUID WATER
Nh2oLiquid = h2oLiquid(f,V,W,ice,Eps);    %Ad[3] Ad[7]

% ATTENUATION DUE TO RAIN
Nrain = rain(f,RR);             %Ad[8] Ad[9]

% NONDISPERSIVE REFRACITIVITY
N0 = nonDispRef(V,p_d,e,RR,W,Eps);

% IF P = 0 THEN N = 0
idxp0 = find(p == 0);
if ~isempty(idxp0)
  NO2Lines(idxp0) = 0;
  NdryAir(idxp0) = 0;
  Nh2oVapor(idxp0) = 0;
  Nh2oLiquid(idxp0) = 0;
  Nrain(idxp0) = 0;
  N0(idxp0) = 0;
end

% Plot
for k = 1:len
if adNpNpp == 0
  yStr = '\alpha [dB/km]';
  y(k,:) = attenuation([transpose(NO2Lines(k)+NdryAir(k)); transpose(Nh2oVapor(k)); transpose(Nh2oLiquid(k)); transpose(Nrain(k)); transpose(NO2Lines(k)+NdryAir(k)+Nh2oVapor(k)+Nh2oLiquid(k)+Nrain(k))],f(k));
elseif adNpNpp == 1
  yStr = '\tau [ps/km]';
  y(k,:) = dispersion([transpose(NO2Lines(k)+NdryAir(k)); transpose(Nh2oVapor(k)); transpose(Nh2oLiquid(k)); transpose(Nrain(k)); transpose(NO2Lines(k)+NdryAir(k)+Nh2oVapor(k)+Nh2oLiquid(k)+Nrain(k)); transpose(N0(k)); transpose(NO2Lines(k)+NdryAir(k)+Nh2oVapor(k)+Nh2oLiquid(k)+Nrain(k)+N0(k))]);
elseif adNpNpp == 2
  yStr = 'N'' [ppm]';
  y(k,:) = real([transpose(NO2Lines(k)+NdryAir(k)); transpose(Nh2oVapor(k)); transpose(Nh2oLiquid(k)); transpose(Nrain(k)); transpose(NO2Lines(k)+NdryAir(k)+Nh2oVapor(k)+Nh2oLiquid(k)+Nrain(k)); transpose(N0(k)); transpose(NO2Lines(k)+NdryAir(k)+Nh2oVapor(k)+Nh2oLiquid(k)+Nrain(k)+N0(k))]);
elseif adNpNpp == 3
  yStr = 'N'''' [ppm]';
  y(k,:) = imag([transpose(NO2Lines(k)+NdryAir(k)); transpose(Nh2oVapor(k)); transpose(Nh2oLiquid(k)); transpose(Nrain(k)); transpose(NO2Lines(k)+NdryAir(k)+Nh2oVapor(k)+Nh2oLiquid(k)+Nrain(k))]);
end
end

AF = y(:,5); attenFactor = AF.*1e-3;
