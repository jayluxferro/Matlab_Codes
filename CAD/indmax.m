function [r,c] = indmax(x)
% INDMAX returns the row and column indices of
% the maximum-valued element in x
[m,n] = size(x);
xmax = x(1,1);
r=1; c=1;
for k=1:m
    for l=1:n
        if x(k,l)> xmax
        xmax = x(k,l);
        r=k;
        c=l;
        end
    end
end
