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

function power_azi_el_true = getSphericalSpectrum(powerSpectrum,angleType,Th)

if strcmp(angleType,'AOD') == true
    subpathAngles = powerSpectrum(:,4:5);
elseif strcmp(angleType,'AOA') == true
    subpathAngles = powerSpectrum(:,6:7);
else
end

%%% initialize power_azi_el_true
elArray = -90:90;
numberOfElevationPlanes = length(elArray);
AziArray = 0:359;
power_azi_el_true = Th*ones(length(AziArray),3,numberOfElevationPlanes);

%%% total number of subpaths
total_NumberOfSubpaths = size(powerSpectrum,1);

%%% initialize the continuous spectrum
for elMatIndex = 1:numberOfElevationPlanes
    
    currentEl = elArray(elMatIndex); 
    power_azi_el_true(:,3,elMatIndex) = currentEl*ones(length(AziArray),1);
    power_azi_el_true(:,2,elMatIndex) = AziArray';

end

for subpathIndex = 1:total_NumberOfSubpaths
    
    %%% subpath angles
    theta = mod(round(subpathAngles(subpathIndex,1)),360);
    phi = round(subpathAngles(subpathIndex,2));
    
    %%% extract subpath power (linear)
    subpathP_Lin = powerSpectrum(subpathIndex,2);
    
    %%% find storing elements
    [c,aziIndex,smth] = intersect(AziArray,theta);
    [c,elIndex,smth1] = intersect(elArray,phi);
    
    %%% extract current power
%     aziIndex
%     elIndex
    currentP = 10^(power_azi_el_true(aziIndex,1,elIndex)/10);
    
    %%% store in power_azi_el_true. 
    power_azi_el_true(aziIndex,1,elIndex) = 10*log10(currentP+subpathP_Lin);    
    
end%%end of lobeIndex for loop

end