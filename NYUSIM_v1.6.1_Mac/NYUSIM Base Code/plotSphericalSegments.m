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

function  plotSphericalSegments(power_azi_el_plot)

    %%% number of measurements (or elevation planes)
    numberOfMeas = size(power_azi_el_plot,3);
       
    %%% plot the spherical plot here
    for measIndex = 1:numberOfMeas

        %%% extract power column
        Pr_plot = power_azi_el_plot(:,1,measIndex);

        %%% extract azimuth, and switch to radians
        Azi_plot = power_azi_el_plot(:,2,measIndex)*pi/180;

        %%% extract elevation, and switch to radians
        El_plot = power_azi_el_plot(:,3,measIndex)*pi/180;

        %%% transform to Cartesian
        [x_plot, y_plot, z_plot] = sph2cart(-Azi_plot+pi/2,El_plot,Pr_plot);

        %%% plot in 3D
        plot3(x_plot,y_plot,z_plot,'color','b','markersize',8,'linewidth',2)        
        plot3(x_plot,y_plot,z_plot,'.','color','b','markersize',8,'linewidth',4)        

    end%%end of 3-D plotting

end