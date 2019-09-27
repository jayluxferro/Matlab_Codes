%%% NYUSIM - User License %%%

% Copyright (c) 2018 New York University and NYU WIRELESS

% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the “Software”),
% to deal in the Software without restriction, including without limitation 
% the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, and to permit persons to whom the 
% Software is furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software. Users shall cite 
% NYU WIRELESS publications regarding this work.

% THE SOFTWARE IS PROVIDED “AS IS”, WITHOUTWARRANTY OF ANY KIND, EXPRESS OR 
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
% THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
% OTHER LIABILITY, WHETHER INANACTION OF CONTRACT TORT OR OTHERWISE, 
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
% OTHER DEALINGS IN THE SOFTWARE.

function ZNw = h2oLiquid(f,V,W,ice,Eps)
ZEp = zeros(size(V));
for k = 1:length(V)
  if ~ice(k)
    fD = 20.20-146.4*(V(k)-1)+316*(V(k)-1)^2;
    fS = 39.8*fD;
    Epinf = 0.0671*Eps(k);
    Eopt = 3.52;
    ZEp(k) = Eps(k)-f(k)*((Eps(k)-Epinf)/(f(k)+j*fD)+(Epinf-Eopt)/(f(k)+j*fS));
  else
    Ai = (62*V(k)-11.6)*exp(-22.1*(V(k)-1))*1.E-4;
    Bi = .542E-6*(-24.17+116.79/V(k)+(V(k)/(V(k)-.9927)).^2);
    if f(k) < .001; fice = .001; else fice = f(k); end
	ZEp(k) = 3.15+j*(Ai/fice+Bi*fice);
  end
  % SUSPENDED PARTICLE RAYLEIGH APPROXIMATION [6]
end
ZNw = 1.5*W.*((ZEp-1)./(ZEp+2)-1+3./(Eps+2));