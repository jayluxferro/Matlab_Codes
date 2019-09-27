data=rand(1,10)+2;
%% Colors
clrCerulean = [0.0, 0.48, 0.65];
clrOrangeRed = [1.0, 0.27, 0.0];
clrOliveGreen = [0.33, 0.42, 0.18];

%% Plot bar graph and color it
% Bar graph figure
hBar = bar(data);

% Get a handle to the children
hBarChildren = get(hBar, 'Children');

% Set the colors we want to use
myBarColors = [clrCerulean; clrOrangeRed; clrOliveGreen];

% This defines which bar will be using which index of "myBarColors", i.e. the first
%  two bars will be colored in "clrCerulean", the next 6 will be colored in "clrOrangeRed"
%  and the last 4 bars will be colored in "clrOliveGreen"
index = [1 1 2 2 2 2 2 2 3 3 3 3];

% Set the index as CData to the children
set(hBarChildren, 'CData', index);

% And set the custom colormap. Takes care of everything else
colormap(myBarColors);