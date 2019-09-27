
%Remove Vac after TESTS

function [Pavail_Wind,outputPower_Wind, cost_Wind, Vac ] = Wind_Function (tod)
      %fetch hourly wind speed value Vac
    windspeed_Array=csvread('windspeed.csv', 1, 0);
    Vac=windspeed_Array(tod , 2); 
    
    a= 3.4;
    b= -12;
    c= 9.2;


%output for wind turbine
    
    if Vac == 18
        outputPower_Wind = 130; %watts
    else
        if Vac < 3.6
            
            outputPower_Wind = 0;
        elseif (Vac > 3.5 && Vac < 18)
            
            outputPower_Wind= (a*(Vac^2)) + (b*Vac) + c;
        end
    end
        
    
    if outputPower_Wind > 0
        Pavail_Wind= 1;
        cost_Wind= 0;
    else
        Pavail_Wind=0;
     %disp('====')
    %disp(outputPower_Wind);
end