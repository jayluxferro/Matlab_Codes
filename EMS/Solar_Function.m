
function [Pavail_Solar, outputPower_Solar, cost_Solar, Ta, Tc, G_ing] = Solar_Function(tod)
%[Pavail_Solar, outputPower_Solar, cost_Solar] = Solar_Function(tod)
    %fetch hourly irradiation value G_ing
    irradiation_Array=csvread('irradiation.csv', 1, 0);
    G_ing=irradiation_Array(tod , 2); 
    
    %fetch hourly temperature value Ta
    temperature_Array=csvread('temperature.csv', 1, 0);
    Ta=temperature_Array(tod , 2);
    
    Tc= Ta+ ((45-20) * (G_ing / 800));
    
    P_stc= 2000; %Wp
    G_stc= 1000; %W/m^2
    Ic=  -0.0046;  %(%/deg.Cel.)
    Tr= 25; %deg.Cel.
    
    %output equation
    outputPower_Solar=P_stc*( G_ing / G_stc )*(1 + Ic *( Tc - Tr));
    
    if outputPower_Solar > 0
        Pavail_Solar= 1;
        
    else
        Pavail_Solar= 0;
    end
    
    cost_Solar = 0;
    
     %SolarStruct(tod).hour = tod;
        
        %SolarStruct(tod).Solar = cap_Solar;
        %
        %SolarTable = struct2table(SolarStruct);
        
    
    
end





