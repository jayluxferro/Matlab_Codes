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

function ZNrp = rain(f,RR)
% Laws-Parsons Drop Size Distribution
for k = 1:length(f)
  if RR(k)==0
    ATRAN = 0;
    Nrp = 0;
  else
    % ALPHA CALCULATION
    if f(k) < 2.9
      GA = 6.39E-5;
      EA = 2.03;
    elseif f(k) < 54
      GA = 4.21E-5;
      EA = 2.42;
    elseif f(k) < 180
      GA = 4.09E-2;
      EA = 0.699;
    else
      GA = 3.38;
      EA = -0.151;
    end
    ARAIN = GA*f(k)^EA;
  
    % BETA CALCULATION
    if f(k) < 8.5
      GB = 0.851;
      EB = 0.158;
    elseif f(k) < 25
      GB = 1.41;
      EB = -0.0779;
    elseif f(k) < 164
      GB = 2.63;
      EB = -0.272;
    else
      GB = 0.616;
      EB = 0.0126;
    end
    BRAIN = GB*f(k)^EB;
    ATRAN = ARAIN*RR(k)^BRAIN;

    % Rain delay approximated after ZUFFEREY [10], who
    % used Marshall-Palmer drop size distribution and 20 deg. C
    fr = 53 - 0.37*RR(k) + 1.5E-3*RR(k)^2;
    Nro = (RR(k)*(3.68 - 0.012*RR(k)))/fr;
    X = f(k)/fr;
    Nrp = -Nro.*(X.^2.5./(1+X.^2.5));
  end
  ZNrp(k) = Nrp + i*ATRAN/(.182*f(k));
end
