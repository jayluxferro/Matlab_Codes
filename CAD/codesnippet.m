%{
code snippet
Author: Jay Lux Ferro
Date: 3rd November
Telecom 4
%}

%% PLEASE GO THROUGH CAREFULLY
%% ...........................

clc;
clear;
close all;

%a simple vector
v=[1 3 5 2 11 12];
figure
bar(v)

%labelling x-axis
set(gca,'XTickLabel',{'Jay','Lux','Ferro','Justice' , 'Owusu', 'Agyemang'});

%to increase bar with demonstration
figure
bar(v,1) % 1 can be replaced with ur desired value



%setting a color for all your bars
figure
bar(v,'r') % r can be replaced with any of the color eg. b, y, g etc


%setting separate colors for each bar
figure
%% defining colors to be used.
% should be of the same size as the number of bars
color=['r','b','y','c','m','g']; 
hold on
for i=1:length(v)
    bar(i,v(i),color(i))
end
hold off


%% putting everything together,
% displaying coloured bars and also labelling x-axis
color=['r','b','y','c','m','g']; 

% the first label should be blank, it for x=0
% just optimized it for your data sake... take note
mylabels={'' , 'Jay','Lux','Ferro','Justice' , 'Owusu', 'Agyemang'};

%defining the bar of the width: increase of the width will increase
% the length of your labels
barwidth=0.8;

figure
hold on
for i=1:length(v)
    bar(i,v(i),barwidth,color(i))
    set(gca,'XTickLabel',mylabels);
end
hold off

%% REGARDS... Jay Lux Ferro
%% if you encounter any problem whatsapp me on 0205737153 or mail: sperixlabs@gmail.com
%%...................................