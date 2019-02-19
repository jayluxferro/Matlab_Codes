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

function  power_azi_el_plot = prepareForPlotting(power_azi_el_true,minPower)
        
    %%% rename matrix containing data for initialization purposes
    power_azi_el_plot = power_azi_el_true;

    %%% equate all angular powers = -200 dBm to min_power (for plotting
    %%% purposes        
    numberOfMeas = size(power_azi_el_plot,3);
    for index = 1:numberOfMeas
       indSmallest = power_azi_el_plot(:,1,index) == min(power_azi_el_plot(:,1,index));
       power_azi_el_plot(indSmallest,1,index) = minPower;
    end 

    %%% shift all received powers to be non-negative numbers
    power_azi_el_plot(:,1,:) = power_azi_el_plot(:,1,:) - minPower;

    %%% append additional row equal to first row
    power_azi_el_plot = [power_azi_el_plot;power_azi_el_plot(1,:,:)];
        
end