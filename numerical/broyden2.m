function [x, ithist] = broyden2(f,x0,opt,bounds)
% Solve system of nonlinear equations by Broyden's method
%  Broyden's method is a quasi Newton method which updates an approximate 
%  Jacobian at each new Newton step.
%  
%  Usage:
%  [x, ithist] = broyden( f, x0, opt, bounds)
%
%  Input parameters:
%    f       name of a matlab function that evaluates F.  (Required)
%    x0      iteration starting point                     (Required)
%    opt     Options struct. Fields:                      (Optional) 
%       tolfun  Function tolerance. (Default tolfun = 1.e-10)
%               Iterations end if ||F(x)||_2 < tolfun
%       tolx    Step length tolerance (Default tolx = 1.e-8)
%               Newton's method stops if  ||step||_2 < tolx, 
%               where step is the Newton step.
%       maxiter maximum number of iterations (Default maxiter = 50)
%    bounds     Optional bounds on x  Default: no bounds. 
%               bounds(:,1) <= x < bounds(:,2)
%   
%  Output parameters:
%    x       approximation of the solution. 
%    ithist  iteration history struct.  Fields:  x, f(x), norm(f)
%
% Example:
%  f = @(x) [x(1)^2 + x(2)^2 - 4; exp(x(1)) + x(2) - 1];
%  x = broyden(f,[1;1])
%  The other root has x(1) > 0, x(2) < 0.  This may be found by selecting  
%  another inital x, or by using constraints.  E.g.:
%  x = broyden(f,[1;1],[],[0 2.5;-2.5 0])
%
%  See also: fsolve (in optimization toolbox)
%  Author: Are Mjaavatten, Telemark University College, Norway
% 
%  The update formula for the Jacobian J is taken from   
%  the broyden function written by Matthias Heinkenschloss:
%  http://read.pudn.com/downloads158/sourcecode/math/705810/sysnlineq/broyden.m__.htm
%
% Version 1:   2015-12-29
% Version 1.1: 2016-11-29  Added iteration history
    optfields = {'maxiter','tolfun','tolx'};
    defaults = {50,1e-10,1e-8,[]};
    if nargin < 3 
        opt = [];
    end
    for i = 1:3
        if isfield(opt,optfields{i})
            if isempty(opt.(optfields{i}))
                opt.(optfields{i}) = defaults{i};
            end
        else
            opt.(optfields{i}) = defaults{i};
        end
    end
    
    x      = x0(:);
    it     = 0;
    F      = feval(f, x);
    if ~(size(x,1) == size(F,1))
        error('f must return a column vector of the same size as x0')
    end
    normf =  norm(F);
    J      = jacobi(f,F,x);  % Intial Jacobian matrix
    
    if nargout > 1
        ithist.x = [x(:)';zeros(opt.maxiter,length(x))];
        ithist.f = [F(:)';zeros(opt.maxiter,length(x))];
        ithist.normf = [normf;zeros(opt.maxiter,1)];
    end
    
    normdx  = 2*opt.tolx;
    while( it < opt.maxiter+1 && normdx > opt.tolx && normf > opt.tolfun)   
       if rcond(J) < 1e-15
           error('Singular jacobian at iteration %d\n',it)
       end
       dx     = -J\F;
       normdx = norm(dx);
       if nargin > 3  % variable bounds are supplied
           % make sure x stays within bounds
           for j = 1:20
               jl = find(x+dx<bounds(:,1));
               dx(jl) = dx(jl)/2;
               ju = find(x+dx>bounds(:,2));
               dx(ju) = dx(ju)/2;
               if isempty(jl) && isempty(ju)
                   break
               end
           end
       end
       x  = x+dx;
       it = it+1;
       F  = feval(f, x);
       normf = norm(F);
       J  = J + F*dx'/(dx'*dx);  
       if nargout > 1
           ithist.x(it+1,:) = x(:)';
           ithist.f(it+1,:) = F(:)';
           ithist.normf(it+1,:) = normf;
       end
    end
    % Check if the iterations converged and issue warning if needed
    if it >= opt.maxiter && norm(F) > opt.tolfun
        warning('No convergence in %d iterations.\n',it+1)
    elseif normf>opt.tolfun
        warning('Newton step < %g, but function norm > %g\n',...
            opt.tolx,opt.tolfun)
    elseif normdx>opt.tolx
        warning('Function norm < %g, but newton step norm > %g\n',...
            opt.tolfun,opt.tolx)        
    end
    if nargout > 1
        ithist.x(it+2:end,:) = [];
        ithist.f(it+2:end,:) = [];
        ithist.normf(it+2:end) = [];
    end
end
function J = jacobi(f,y0,x)
% Quick and dirty numerical Jacobian for function f at x
% y0: f(x);
    delta = 1e-6*(max(1,sqrt(norm(x))));
    n = length(y0);
    m = length(x);
    J = zeros(n,m);
    for i = 1:m
        dx = zeros(m,1);
        dx(i) = delta/2;
        J(:,i) = (feval(f,x+dx)-feval(f,x-dx))/delta;
    end
end