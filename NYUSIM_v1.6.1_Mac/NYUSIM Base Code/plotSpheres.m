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

function         [smallestPower middlePower largestPower] = ...
            plotSpheres(maxPower,minPower,margin)

    %%% define sphere radii
%     if abs(minPower-maxPower)>margin
%         smallestPower = maxPower-margin;
%         middlePower = maxPower -margin/2;
%         largestPower = maxPower;
%     elseif abs(minPower-maxPower)<=margin
%         smallestPower = minPower+5;
%         middlePower = minPower+10;
%         largestPower = minPower+15;
%     else
%     end

if abs(minPower-maxPower)>margin
        smallestPower = maxPower-margin;
        middlePower = maxPower -margin/2;
        largestPower = maxPower;
    elseif abs(minPower-maxPower)<=margin
        smallestPower = minPower+1;
        largestPower = maxPower;
        middlePower = (smallestPower + largestPower)/2;
    else
    end
      
    %%% create a sphere whose radius is the spherical threshold    
    [xsph, ysph, zsph] = sphere(50);
    r = smallestPower-minPower;
%     surf(r*xsph,r*ysph,r*zsph,'facealpha',.5,'facecolor',[1 0 0],'edgecolor','none')
surf(r*xsph,r*ysph,r*zsph,'facealpha',.5,'facecolor',[1 0 0],'edgecolor','none')

    %%% create another spherical surface
    [xsph, ysph, zsph] = sphere(50);
    r_10 = middlePower-minPower;
    surf(r_10*xsph,r_10*ysph,r_10*zsph,'facealpha',.25,'facecolor',[0.8 0 1],'edgecolor','none')

    %%% create another spherical surface
    [xsph, ysph, zsph] = sphere(50);
    r_20 = largestPower-minPower;
    surf(r_20*xsph,r_20*ysph,r_20*zsph,'facealpha',.1,'facecolor',[1 1 0],'edgecolor',[0.7 0.7 0.7])

end