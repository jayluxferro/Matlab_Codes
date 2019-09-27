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

function Es = saturationPress(t,ice)
for k = 1:length(t)
  if ~ice(k)
    % Compute saturation pressure over liquid water in hPa
    Y = 373.16/(t(k)+273.16);
    x = -7.90298*(Y-1)+5.02808*log10(Y)-1.3816E-7*(10^(11.344*(1-(1/Y)))-1)+8.1328E-3*(10^(-3.49149*(Y-1))-1)+log10(1013.246);
  else
    % Compute saturation pressure over ice in hPa
    Y = 273.16/(t(k)+273.16);
    x = -9.09718*(Y-1)-3.56654*log10(Y)+0.876793*(1-(1/Y))+log10(6.1071);
  end
  Es(k) = 10^x;
end