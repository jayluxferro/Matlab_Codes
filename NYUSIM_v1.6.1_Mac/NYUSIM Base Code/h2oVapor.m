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

function ZN = h2oVapor(f,V,p_d,e)
load water.txt;
Fo_H2O = transpose(water(:,1));
B(1:6,:) = transpose(water(:,2:7));
ZN = 0;
for k = 1:35
  S = B(1,k)*e.*V.^3.5.*exp(B(2,k)*(1-V));  
  GAMH = B(3,k)*(p_d.*V.^B(5,k)+B(4,k)*e.*V.^B(6,k))*1.E-3;
  GAMD2 = 1E-12./V*(1.46*Fo_H2O(k)).^2;
  GAMH = 0.535*GAMH+sqrt(0.217*GAMH.^2+GAMD2);
  DELH = 0;
  ZF = VVW(f,Fo_H2O(k),DELH,GAMH);
  ZN = ZN+S.*ZF;
end
