function v=shuffle(v)
% eg.
% v = 1:20;
% result = shuffle(v)
%...........................
%eg. result = shuffle([1 2 4 4])
     v=v(randperm(length(v)));
 end