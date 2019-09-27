function [outputPower_Grid, cost_Grid] = Grid_Function (Premainder)
    %output for grid
    outputPower_Grid= Premainder;
    
    tarrif= 0.8;

    cost_Grid= Premainder* tarrif;

end