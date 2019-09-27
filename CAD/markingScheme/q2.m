%Question 2
%Using selection programming write an M-File to solve quadratic equations
%with only maximum values, indicating the roots, the maximum value and
%where it occurs. Where the quadratic doesn't have a maximum value, the
%user should be notified to input an appropriate equation

%% y=ax^2 + bx + c
%  dvalue=-b/(2*a)
clear;
clc;
init=1;

while init==1
    disp('Requesting data input from user')
    disp('The quadratic Equation should be in the form: ax^2 + bx +c=0')
    a=input('Enter the value of a: ');
    b=input('Enter the value of b: ');
    c=input('Enter the value of c: ');
    x=-b/(2*a);
    dvalue=(a*((x)^2))+(b*(x))+c;
    if dvalue > 0
        disp('Calcuating the roots of the equation');
        x=roots([a b c]);
        fprintf('The roots of the equation are %.2f and %.2f\n',x(1),x(2));
        fprintf('The maximum value is y=%.2f\n',dvalue);
        disp('')
        y=input('\nDo you want to perform another operation? y/n: ','s');
        if y=='y' || y=='Y'
            init=1;
        else
            init=0;
        end
        fprintf('\n\n');    
    else
       fprintf('\n');
       disp('Enter an appropriate quadratic equation'); 
       fprintf('\n');
       fprintf('\n');
    end
end
disp('Thank you!!')