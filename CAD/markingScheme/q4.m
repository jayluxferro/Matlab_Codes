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
mycolor=['r','b','y','c','m','g']; 

% GDP PC
North_America_gdp = [];
South_America_gdp = [];
Asia_gdp = [];
Australia_gdp = [];
Europe_gdp = [];
Oceania_gdp = [];

% VAT and SALES Tax
North_America_vs = [];
South_America_vs = [];
Asia_vs = [];
Australia_vs = [];
Europe_vs = [];
Oceania_vs = [];


na_count = 1;
sa_count = 1;
asia_count = 1;
australia_count = 1;
europe_count = 1;
oceania_count = 1;

for k=1:length(CONTINENTS)
    all_continents(k) = string(CONTINENTS(k));
    if CONTINENTS(k) == "North America"
        North_America_gdp(na_count) = gdp_pc(k);
        North_America_vs(na_count) = vat_sales(k);
        na_count = na_count + 1;
    elseif CONTINENTS(k) == "South America"
        South_America_gdp(sa_count) = gdp_pc(k);
        South_America_vs(sa_count) = vat_sales(k);
        sa_count = sa_count + 1;
    elseif CONTINENTS(k) == "Asia"
        Asia_gdp(asia_count) = gdp_pc(k);
        Asia_vs(asia_count) = vat_sales(k);
        asia_count = asia_count + 1;
    elseif CONTINENTS(k) == "Australia"
        Australia_gdp(australia_count) = gdp_pc(k);
        Australia_vs(australia_count) = vat_sales(k);
        australia_count =  australia_count + 1;
    elseif CONTINENTS(k) == "Europe"
        Europe_gdp(europe_count) = gdp_pc(k);
        Europe_vs(europe_count) = vat_sales(k);
        europe_count = europe_count + 1;
    elseif CONTINENTS(k) == "Oceania"
        Oceania_gdp(oceania_count) = gdp_pc(k);
        Oceania_vs(oceania_count) = vat_sales(k);
        oceania_count = oceania_count + 1;
    end
    k = k + 1;
end


all_gdp = [sum(North_America_gdp); sum(South_America_gdp); sum(Asia_gdp); ...
    sum(Australia_gdp); sum(Europe_gdp); sum(Oceania_gdp)];
all_vs = [sum(North_America_vs); sum(South_America_vs); sum(Asia_vs); ...
    sum(Australia_vs); sum(Europe_vs); sum(Oceania_vs)];


figure
barwidth = 0.8;
hold on
count = 1;
for i=1:1:length(all_gdp)
     if count==length(mycolor)
           count=1;
     end
     bar(i,all_gdp(i),barwidth,mycolor(count)),title('GDP PC'),xlabel('Continents'),...
         ylabel('GDP');
     count=count+1;
end 
xticklabels({'', 'N. A.', 'S. A.', 'ASIA', 'AUS', 'EUR', 'OCEANIA'});
hold off

figure
hold on
for i=1:1:length(all_vs)
     if count==length(mycolor)
           count=1;
     end
     bar(i,all_vs(i),barwidth,mycolor(count)),title('VAT/SALES TAX'),xlabel('Continents'),...
         ylabel('VAT/SALES TAX');
     count=count+1;
end 
xticklabels({'', 'N. A.', 'S. A.', 'ASIA', 'AUS', 'EUR', 'OCEANIA'});
hold off

%% Labor Tax comparison
% getting country with the lowest labor tax
[value, country] = min(labor_tax);
fprintf("%s has the lowest labor tax of %.2f percent \n", string(countries_full(country)), value);

% getting country with the highest labor tax
[value, country] = max(labor_tax);
fprintf("%s has the highest labor tax of %.2f percent \n", string(countries_full(country)), value);
