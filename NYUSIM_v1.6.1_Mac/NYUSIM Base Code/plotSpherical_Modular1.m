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

function h = plotSpherical_Modular1(power_azi_el_true,titleName,envType,FigVisibility,Th)        
        
%%% minimum/maximum received power in the spherical spectrum
minPower = getMinPower(power_azi_el_true,Th);
maxPower = max(max(power_azi_el_true(:,1,:)));

%%% manipulate the power_azi_el_true matrix for plotting
power_azi_el_plot = prepareForPlotting(power_azi_el_true,minPower);

%%% open figure
figure('visible',FigVisibility);
hold on
grid on
box on

%%% define title of graph
title(titleName,'fontsize',12,'fontweight','bold')

%%% set all text to bold
set(gca,'fontweight','bold')

%%% remove ticklabels from plot
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])
set(gca,'ZTickLabel',[])

%%% all axes equal for viewing purposes
axis equal        

%%% Step 1: Plot 3 spherical colored surfaces
if strcmp(envType,'LOS')== true
    margin = 15;
elseif strcmp(envType,'NLOS')== true
    margin = 20;
%         margin = 25;
else
end
if maxPower > Th && maxPower - minPower > 1
[smallestPower middlePower largestPower] = ...
    plotSpheres(maxPower,minPower,margin);

%%% Step 2: Plot (azi,el,power) angular segments
plotSphericalSegments_v2(power_azi_el_plot)

%%% Spte 3: Plot connecting lines between angular segments for a given
%%% azimuth angle cut
%     plotConnectingLine(power_azi_el_plot)   

%%% plot legend
hLeg = legend([num2str(smallestPower,'%.0f'),' dBm'],[num2str(middlePower,'%.0f'),' dBm'],...
    [num2str(largestPower,'%.0f'),' dBm']);

%%% set legend font size
%     set(hLeg,'fontsize',16,'position',[0.6913    0.2337    0.1946    0.1444])
set(hLeg,'fontsize',14,'position',[0.75    0.11    0.1946    0.1444])

%%% get gca for this figure
hGca = gca;

set(gca,'view',[0 90]);
%     view(3);
set(gcf,'color','w');
set(gcf,'Unit','Inches');
pos = get(gcf,'Position');
set(gcf','PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3) pos(4)]);

else
     text(0.18,0.6,['No Detectable Multipath Components',char(10),'above the Threshold of ',num2str(Th),' dBm'],...
    'Units','normalized','fontsize',15,'fontweight','bold');
end

h = gcf;
end