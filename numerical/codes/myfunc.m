function y = myfunc(x)

    y = zeros(3, 1);
    y(1) = 3*x(1) - cos(x(2) * x(3)) - 0.5;
    y(2) = (x(1))^2 - (81 *(x(2) + 0.1)^2) + sin(x(3))+ 1.06;
    y(3) = exp(-x(1)*x(2)) + (20*x(3)) + ((10*pi)-3)/3;

end