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

function [timeArray multipathArray] = getTimeVSPower(t_mn,subPathPowers_Lin,numberOfClusters)

%%% initialize
time_power = [];

%%% for each cluster
for clusterIndex = 1:numberOfClusters    
    
   %%% extract subpath times and powers 
   t_c = t_mn.(['c',num2str(clusterIndex)]);
   p_c = subPathPowers_Lin.(['c',num2str(clusterIndex)]);
    
   %%% store
   time_power = [time_power;t_c' 10*log10(p_c')]  ;
end

%%% time increment
dt = 1/16;

%%% identify max time index
maxTime = round(1.2*max(time_power(:,1))/dt);

%%% build time and power arrays
time1 = (0:maxTime)*dt;
power1 = -200*ones(size(time1));

%%% store the power levels at appropriate times
power1(round(time_power(:,1)/dt)) = time_power(:,2);

%%% assign output
timeArray = time1;
multipathArray = 10.^(power1/10);


end