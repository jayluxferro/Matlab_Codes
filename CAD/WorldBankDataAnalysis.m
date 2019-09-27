e%{
  Analyse the world bank data on taxes and write
  a brief report by company taxes in the continents of the world
%}
clc;
clear;
close all;
%short form of the countries
[a1,b1,shortcountries]=xlsread('taxdata.xlsx','B2:B86');

%full name of the countries
[a,b,countries]=xlsread('taxdata.xlsx','C2:C86');

%continents of each country
[x,y,continents]=xlsread('taxdata.xlsx','A2:A86');

%getting distinct continents
%performing a loop through countries and their continents
for i=1:length(continents)
       disp(continents(i))
    i=i+1;
end


