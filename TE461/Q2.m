%{
    Question 2: 
    Write an M-File to solve quadratic equations, indicating the roots,
    the maximum value and where it occurs. The user should be pre-informed
    the nature of the roots in the display.
%}

%% Default
clc; clear; close all;

%% Nature of the roots
disp('Quadratic equations...');
disp('Format: ax^2 + bx + c = 0');

%% User inputs
a = input('Enter the value of a: ');
b = input('Enter the value of b: ');
c = input('Enter the value of c: ');

fprintf('The roots of the equation %dx^2 + %dx + %d are: ', a, b, c);
x = roots([a b c])

minMax = -b/(2*a);

% calcuating the point of occurrence
x1 = minMax;
y1 = a*(x1^2) + (b*x1) + c;

if minMax > 0
   % a minimum point
  fprintf('Minimum point (x,y)=(%.3f,%.3f)\n', x1, y1); 
elseif minMax < 0
    % a maximum point
    fprintf('Maximum point (x,y)=(%.3f,%.3f)\n', x1, y1);
end

