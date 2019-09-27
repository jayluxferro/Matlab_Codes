function [Pavail_DG, DG_output, cost_DG] = DG_Function (Premainder)
%Diesel generator
rated_DG=1000;
fuelcost = 0.2;  %can it be dynamic to output voltage at the time?

%Assume that fuel is fuel so the generator can meet the load

if Premainder <= 0.2* rated_DG
    Pavail_DG= 0;
    DG_output=0;
    
    
elseif Premainder > (0.2 * rated_DG) 
   Pavail_DG= 1;
   
   if Premainder <= (0.75* rated_DG)
    DG_output = Premainder;
    
   else
       DG_output= (0.75 * rated_DG);
       
   end
end
  cost_DG= DG_output * fuelcost; 
end