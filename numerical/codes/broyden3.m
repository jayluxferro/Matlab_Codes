function [x,k] = broyden(fcn1,fcn2,fcn3, x0,maxits,tol)

if nargin < 6
    tol = 1e-8;
end
if nargin < 5
    maxits = 50;
end
if nargin < 3
    x0 = [1 1 1]';
end
if nargin < 3
    help broyden
    error('you must have at least three inputs')
end
syms x1 x2 x3
B = [diff(fcn1,x1) diff(fcn1,x2) diff(fcn1, x3);diff(fcn2,x1) diff(fcn2, x2) diff(fcn2, x1); ...
    diff(fcn3, x1) diff(fcn3, x2) diff(fcn3, x3)];
x1 = x0(1);
x2 = x0(2);
x3 = x0(3);
h = inline(fcn1,'x1','x2', 'x3');
g = inline(fcn2,'x1','x2', 'x3');
i = inline(fcn3, 'x1', 'x2', 'x3');
f(1:3,1) = [h(x1,x2,x3);g(x1,x2, x3); i(x1, x2, x3)];
B = eval(B);
x = [x1 x2 x3]';
for k=1:maxits
    s = B\(-f);
    x = x + s;
    fnew = [h(x(1),x(2), x(3));g(x(1),x(2), x(3));i(x(1), x(2), x(3))];
    y = fnew-f;
    if abs(fnew-f) < tol
        break
    end
    f = fnew;
    B = B + ((y-B*s)*s')/(s'*s);
end
