%{
    GAS Law

%}

p = 220; % bar
v = 1; % L
n = 2; % mol
r = 0.08314472; % L bar / (K mol)
a = 5.536;
b = 0.03049;

t1 = (p * v)/(n * r)

t2 = ((p + (((n^2)*a)/(v^2))) * (v - (n * b)))/(n * r)

