%{
    Assignment
%}
clear;
clc;
close all;

%% Question 7 
% a
A = [ 2 3 4 ; 3 4 5 ; 4 5 6]
B = [ 1 2 3 ; 2 4 6 ; 3 6 9]

%b
if issymmetric(A)
   disp('A is symmetric')
end

if issymmetric(B)
    disp('B is symmetric')
end

% c
AB = A * B
BA = B * A

A_Squared = A ^ 2 
B_Squared = B ^ 2

%% Bonus problem 
% 1
x = 0:10;
y1 = 4 -x;
y2 = x -2;
figure
plot(x,y1,x,y2),title('x + y = 4 and 2x-2y = 4'),grid on,legend('x+y=4','2x-2y=4'),xlabel('x'),ylabel('y'),box on

% 2; Generating a random 5 x 5 matrix 
X = randi([0, randi(100)], [5,5])

% 3; 
A = [ 2 3 4 5 6 7; 3 4 5 6 7 8; 4 5 6 7 8 9; 5 6 7 8 9 10; 6 7 8 9 10 11; 7 8 9 10 11 12]
B = [ 1 2 3 4 5 6; 2 4 6 8 10 12; 3 6 9 12 15 18; 4 8 12 16 20 24; 5 10 15 20 25 30; 6 12 18 24 30 36]
AB = A * B
BA = B * A
A_Squared = A ^ 2
B_Squared = B ^ 2

% 4; 
A = randi([0, randi(100)], [5,5])
B = randi([0, randi(100)], [5,5])
AB = A*B