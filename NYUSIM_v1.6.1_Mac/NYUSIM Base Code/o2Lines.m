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

function ZN = o2Lines(f,V,p_d,e)
load oxygen.txt;
fo_O2 = transpose(oxygen(:,1));
A(1:6,:) = transpose(oxygen(:,2:7));
p = p_d+e;
ZN = 0;
for k = 1:44
  S = A(1,k)*p_d.*V.^3.*exp(A(2,k)*(1-V))*1.E-6;
  GAMMA = A(3,k)*(p_d.*V.^(0.8-A(4,k))+1.1.*e.*V)*1.E-3;
  GAMMA = sqrt(GAMMA.^2+(25*0.6E-4)^2);
  DELTA = (A(5,k)+A(6,k)*V).*p.*(V.^0.8)*1.E-3;
  ZF = VVW(f,fo_O2(k),DELTA,GAMMA);
  ZN = ZN+S.*ZF;
end
idx = find(imag(ZN)<0);
ZN(idx) = real(ZN(idx));
