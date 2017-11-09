%{
   Assignment
%}

%% Question 1
A = magic(6)
R = rref(A)

%% Question 2
X = function v=shuffle(v)
     v=v(randperm(length(v)));
 end
rank_x = rank(X)
X_tr = transpose(X)
rank_X_tr = rank(X_tr)

%% Question 3
A = [1 2 -1 3 5; -1 1 4 -2 0; 1 1 -1 3 12; 0 4 3 1 -2];
if det(A * transpose(A)) == 0
    disp('Linearly dependent')
else
    disp('Linearly independent')
end

%% Question 4
A = [6 0 3 1 4 2; 0 -1 2 7 0 5; 12 3 0 -19 8 -11];
if det(A * transpose(A)) == 0
    disp('Linearly dependent')
else
    disp('Linearly independent')
end