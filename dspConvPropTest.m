%%  Convulation sum property test
clear;
clc;

x = [0 0 0 1 0 0.5];
y = [1 0 0 -3 0 0];
z = [0 0 0 1 0 1];

%% Associative 
h1 = conv(x, y);
h2 = conv(y, x);

h1 == h2;

%% Associative
h1 = conv(conv(x, y), z);
h2 = conv(x, conv(y, z));
h1 == h2;

%% Distributive
h1 = conv(x, (y + z));
h2 = conv(x, y) + conv(x, z);
h1 == h2