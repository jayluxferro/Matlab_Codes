
%This is a programme to compute the best using the MCDA technique

%create criteria container
criteria= {'availability','emmissions','opcost','eff','vqual','harmqual','reliab'};
length(criteria);


%Prompt and collect input for criteria and criteria ratings
disp ('=====START=====');

for i= 1:length(criteria)
    
    disp(strcat('Enter prefered values for :',criteria{i}));
    disp('---------------------------------------')
    weightVal(i).type = criteria{i};
    weightVal(i).weight = 80; %input('Enter the weight: ');
    weightVal(i).solarPV = 30; %input('Enter the weight_PV: '); 
    weightVal(i).WT =  100;   %input('Enter the weight_WT: '); 
    weightVal(i).DG = 10;    %input('Enter the weight_DG: '); 
    weightVal(i).Grid = 20;    %input('Enter the weight_Grid: '); 
    disp('---------------------------------------')
end


%Normalisation of criteria weights
    weightValTable = struct2table(weightVal);
    weightCol = sum(weightValTable.weight);
    weightValTable.weight_nom = weightValTable.weight *(100/weightCol);

%Evaluating scores by finding the product between weights and ratings
    scoreTable = table;
    scoreTable.solarPV= (weightValTable.weight_nom) .* (weightValTable.solarPV);
    %scoreTable.batteries= (weightValTable.weight_nom) .* (weightValTable.battery);
    scoreTable.DG= (weightValTable.weight_nom) .* (weightValTable.DG);
    scoreTable.WT= (weightValTable.weight_nom) .* (weightValTable.WT);
    scoreTable.Grid= (weightValTable.weight_nom) .* (weightValTable.Grid);

%Evaluating and ranking final scores 
    scoreTotal(1).name='solarPV';
    scoreTotal(1).score= sum(scoreTable.solarPV);
    %scoreTotal(2).name='batteries';
    %scoreTotal(2).score= sum(scoreTable.batteries);
    scoreTotal(2).name='DG';
    scoreTotal(2).score= sum(scoreTable.DG);
    scoreTotal(3).name='WT';
    scoreTotal(3).score = sum(scoreTable.WT);
    scoreTotal(4).name='Grid';
    scoreTotal(4).score= sum(scoreTable.Grid);

    rankTable=struct2table(scoreTotal);
    rankTable=sortrows(rankTable, 'score', 'descend');





%=========START SCHEDULING WITH MCDA RANKING======%

%Set time of day to 1
    tod=1
%r=1
    sell_tariff = 0.5; %randi([0  1]);
while (tod < 25)
disp(strcat('*****************=====starting :',int2str(tod)));

income_Total = 0;
income_Solar = 0;
income_Wind = 0;     %watch this initializing step

%collect load demand from forecasting data
    load_Array=csvread('load.csv', 1, 0);
    LoadDemand=load_Array(tod , 2);
    PDemand=LoadDemand;
    Premainder=PDemand;


%Call functions
    %[ind_Solar, cap_Solar, cost_Solar] =Solar_Function(tod);
    %[ind_Wind, cap_Wind, cost_Wind]= Wind_Function(tod);
    %[ind_DG, cap_DG, cost_DG]= DG_Function (PDemand);
    %[cap_Grid, cost_Grid]=Grid_Function (PDemand);



TotalCostOfHour = 0;
%check ranking from results of MCDA
rankTable;
cap_Grid=0;
cap_Wind=0;
cap_DG=0;
cap_Solar=0;

cost_Grid=0;
cost_Wind=0;
cost_DG=0;
cost_Solar=0;




r=1;
while(Premainder > 0)
    disp(strcat('==starting hour:',int2str(tod)))
    disp(strcat('=====current r :',int2str(r)))
    disp(strcat('====starting   :',int2str(Premainder)))
    currentSrc= string(rankTable {r,1});
    if currentSrc == "Grid"
           [cap_Grid, cost_Grid]=Grid_Function (Premainder);
            Premainder = Premainder - cap_Grid;
           %calculate cost of running grid and into cost_Grid break
           disp(strcat ('met grid at', int2str (r)));
           TotalCostOfHour = TotalCostOfHour + cost_Grid;
          
        elseif (currentSrc == "solarPV" )
                
            [ind_Solar, cap_Solar, cost_Solar] =Solar_Function(tod);
            %calculate remainder load demand
            Premainder = Premainder - cap_Solar;
            TotalCostOfHour = TotalCostOfHour + cost_Solar;
            disp(strcat ('met solar at', int2str (r)));
            
        elseif (currentSrc == "WT" )
                
            [ind_Wind, cap_Wind, cost_Wind]= Wind_Function(tod);
            %calculate remainder load demand
            Premainder = Premainder - cap_Wind;
            TotalCostOfHour = TotalCostOfHour + cost_Wind;
            disp(strcat ('met WT at', int2str (r)));
            
        elseif (currentSrc == "DG" )
                    
            [ind_DG, cap_DG, cost_DG]= DG_Function (Premainder);
            %calculate remainder load demand
            Premainder = Premainder - cap_DG;
            TotalCostOfHour = TotalCostOfHour + cost_DG;
            disp(strcat ('met DG at', int2str (r)));
           
    end
        
        r=r+1;
        if r > length(rankTable {:, 2})
            r=1;
        end
  disp(strcat('====ending   :',int2str(Premainder)))
end

if (Premainder < 0)
    if(currentSrc == "solarPV" || currentSrc == "WT" )
        %calculate income from selling excess power to grid and keep in
        %income_Excess
        %income_Solar= sell_tariff* cap_Solar;
        %income_Wind= sell_tariff* cap_Wind;
        income_Total=sell_tariff* Premainder;
        disp('sell to grid')
    end
else
    %calculate cost_Grid + cost_DG int cost_Gross
    NetCost= TotalCostOfHour;
    
end
  
%calculate netcost from cost_Gross -/+ income_Excess
NetCost= TotalCostOfHour+(income_Total);

%output into table, the necessarry results
    %all results in variables
    disp(strcat ('Details for hour:', int2str (tod)));
        
        disp(strcat ('Solar cap', int2str (cap_Solar)));
        disp(strcat ('Solar cost', int2str (cost_Solar)));
        disp(strcat ('Wind cap', int2str (cap_Wind)));
        disp(strcat ('Wind cost', int2str (cost_Wind)));
        disp(strcat ('Genset cap', int2str (cap_DG)));
        disp(strcat ('Genset cost', int2str (cost_DG)));
        disp(strcat ('Grid cap', int2str (cap_Grid)));
        disp(strcat ('Solar cost', int2str (cost_Grid)));
        
        disp(strcat ('TotalCostOfHour', int2str (TotalCostOfHour)));
        %disp(strcat ('income solar', int2str (income_Solar)));
        %disp(strcat ('income wind', int2str (income_Wind)));
        disp(strcat ('income total', int2str (income_Total)));
        
        disp(strcat ('NetCost', int2str (NetCost)));
        
        disp('=========NEXT HOUR========');
        
        
        %keep data in table
        %LoadingTable = {'Hour','Total Load','Solar','Wind','Genset','Grid'};
        LoadingStruct(tod).hour = tod;
        LoadingStruct(tod).Total_Load = LoadDemand ;
        LoadingStruct(tod).Solar = cap_Solar;
        LoadingStruct(tod).Wind = cap_Wind;
        LoadingStruct(tod).DG = cap_DG;
        LoadingStruct(tod).Grid = cap_Grid;
        
        LoadingTable = struct2table(LoadingStruct);
        
        CostStruct(tod).hour = tod;
        
        CostStruct(tod).Solar = cost_Solar;
        CostStruct(tod).Wind = cost_Wind;
        CostStruct(tod).DG = cost_DG;
        CostStruct(tod).Grid = cost_Grid;
        %CostStruct(tod).Income_Solar = income_Solar;
        %CostStruct(tod).Income_Wind = income_Wind;
        CostStruct(tod).Income_Total = income_Total ;
        CostStruct(tod).Gross_Cost = TotalCostOfHour ;
        CostStruct(tod).Total_Cost = NetCost ;
        
        CostTable = struct2table(CostStruct);
        
        
    
    %increment time of day
    tod = tod+1
    
    
end
            
            
