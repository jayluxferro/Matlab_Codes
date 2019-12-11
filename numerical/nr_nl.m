%{
    newton raphson non-linear code 

%}
      clear; clc;
      n=20;
      f=@(x)[x(1)^5+x(2)^3*x(3)^4+1 ; x(1)^2*x(2)*x(3) ; x(3)^4-1 ];
      Df=@(x)[5*x(1)^4 3*x(2)^2*x(3)^4 x(2)^3*4*x(3)^3
              2*x(1)*x(2)*x(3) x(1)^2*x(3) x(1)^2*x(2)
              0 0 4*x(3)^3];
      T=@(x)0.5*(f(x))'*f(x);
      tau=0.5;
      x = [-.01;-.01;-.01]; % starting guess
      for i = 1: n
      Dx = -Df (x)\f(x); % solve for increment
      lambda=1.0;
      while T(x+lambda*Dx)-T(x) > -0.5*lambda*T(x)
      lambda=tau*lambda;
      end
      x=x+lambda*Dx;
      f(x); % see if f(x) is really zero
      fprintf('value of x: %d\n', x);
      fprintf('value of function: %d\n', f(x));
      end