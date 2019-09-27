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

function plotConnectingLine(power_azi_el_plot)

    %%% number of measurements (or elevation planes)
    numberOfMeas = size(power_azi_el_plot,3);

    %%% extract all azimuth angles
    aziAngles_array = power_azi_el_plot(:,2,1)

    %%% number of azimuth angles in a given plane
    numberOfAziAngles = numel(aziAngles_array)

    %%% Define all elevation palnes in this way
    %%% +20 plane: index #3
    %%% 0 plane: index #1
    %%% -20 plane: index #2
%     ZeroIndex = 1;
%     MinusTenIndex = 2;
%     MinusTwentyIndex = 3;
%     MinusThirtyIndex = 4;
%     PlusTenIndex = 5;
%     PlusTwentyIndex = 6;
%     PlusThirtyIndex = 7;
%     elMat = [0 -10 -20 -30 10 20 30];

%     %%% store elevation planes from largest to smallest
%     planeMat = [PlusThirtyIndex;PlusTwentyIndex;PlusTenIndex;ZeroIndex;MinusTenIndex;MinusTwentyIndex; MinusThirtyIndex];

    
    
    
    ZeroIndex = 1;
    MinusTwentyIndex = 3;
    PlusTwentyIndex = 6;
%     elMat = [0 -10 -20 -30 10 20 30];

    %%% store elevation planes from largest to smallest
    planeMat = [PlusTwentyIndex;ZeroIndex;MinusTwentyIndex];
    %%% # of points discretizing the 3-D lines
    N = 10;
    numberOfMeas = numel(planeMat);
    for aziIndex = 1:numberOfAziAngles

        %%% extract current azimuth
        currentAziAngle = aziAngles_array(aziIndex);
        azimuthAngles = repmat(currentAziAngle,2,1);

        for planeIndex = 1:numberOfMeas-1

            %%% two consecutive elevation plane indices
            planeIndex
            elPlane_indices = planeMat(planeIndex:planeIndex+1);   

            %%% two consecutive elevation angles and powers (+reshape
            %%% size)
            aziIndex
            size(aziIndex)
            size(power_azi_el_plot)
            elevationAngles = reshape(power_azi_el_plot(aziIndex,3,elPlane_indices),2,1);
            currentPowers = reshape(power_azi_el_plot(aziIndex,1,elPlane_indices),2,1);

            %%% find cartesian coordinates
            [xx yy zz] = sph2cart(pi/2-azimuthAngles*pi/180,elevationAngles*pi/180,currentPowers);

            %%% construct 3-D array of lines connecting power levels on
            %%% at a given azimuth angle
            x_array = linspace(xx(1),xx(2),N);
            y_array = linspace(yy(1),yy(2),N);
            z_array = linspace(zz(1),zz(2),N);

            %%% plot 3-D lines
            plot3(x_array,y_array,z_array,'k','linestyle','-','linewidth',2)

        end%% end of planeIndex for loop

    end%%end of aziIndex for loop



end