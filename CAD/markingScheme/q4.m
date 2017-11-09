%% Question 4
% The data labeled taxdata represents information on tax revenue for
% countries globally, it is believed that the higher the GDP pc the higher
% the VAT  and Sales Tax. Using the data provided confirm or disprove the
% belief on a continent by continent basis. Also compare the labor tax
% globally and comment on your findings
clc;
clear; 
close all;

[NUM,CONTINENTS,RAW]=xlsread('taxdata.xlsx','A2:A86');
gdp_pc=xlsread('taxdata.xlsx','R2:R86');
vat_sales=xlsread('taxdata.xlsx','I2:I86');
labor_tax=xlsread('taxdata.xlsx','G2:G86');
[NUM,countries_short,RAW]=xlsread('taxdata.xlsx','B2:B86');
[NUM,countries_full,RAW]=xlsread('taxdata.xlsx','C2:C86');

%% Generate labor tax bar graph for all countries
mycolor=['r','b','y','c','m','g']; 
% getting labels for the labor tax
barwidth=1.0;
figure 
hold on
count=1;


for i=1:1:length(labor_tax)
     if count==length(mycolor)
           count=1;
     end
     bar(i,labor_tax(i),barwidth,mycolor(count)),title('Labor Tax'),xlabel('Countries'),...
         ylabel('Tax');
     count=count+1;
end 
hold off





