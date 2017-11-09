%{
Assignment
%}
clear;clc;close all;
%% Question 1:  Computing LU Factorization
A = [2 -3 1; 1/2 1 -1; 0 1 -1];
[L1,U] = lu(A)
% first method
%................
% L1 is a permutation of a lower triangular matrix
% U is upper triangular. 

%second method
%................
LU = lu(A)


%% Question 2: 
A = [1 2 3 4];
B = [4 2 1 3];
% computing permutation matrix
a=A';
b=B';
A=eye(length(a));
[C,IA,IB] = intersect(b,a,'stable');
Aperm=A(IB,:)


%% Question 3
band_width = 2;
matrix_size = 8;
M = sign(conv2(eye(matrix_size),ones(band_width+1),'same'))



%% Question 4
A = eye(4);
B = ones(4,4);
C = 4*A - B;
Invertible = inv(C)
% C is not invertible; hence the evaluation of the expression isn't


%% Question 5 Alternating Matrix
n=8;
Alt_Matrix = (-1).^bsxfun(@plus,[1:n]',1:n)
inv_Alt_Matrix = inv(Alt_Matrix)
% inverse of this matrix does not exist