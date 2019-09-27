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

function getDirPDP_Formatted(FigVisibility, timeArray,multipathArray,TXpower,dist,desired_frequency,envType,PL,TXBW_Azi,RXBW_Azi,G_TX,G_RX,titleName)

minPower = TXpower-180+10*log10(G_TX)+10*log10(G_RX);

indKeep = 10*log10(multipathArray)> minPower;

multipathArray_Temp = multipathArray(indKeep);
timeArray_Temp = timeArray(indKeep);

meanTau = sum(timeArray_Temp.*multipathArray_Temp)/sum(multipathArray_Temp);
meanTau_Sq=sum(timeArray_Temp.^2.*multipathArray_Temp)/sum(multipathArray_Temp);
RMSDelaySpread = sqrt(meanTau_Sq-meanTau^2);


Pr_Lin = sum(multipathArray_Temp)/G_TX/G_RX;
PL = TXpower-10*log10(Pr_Lin);

d0 = 1;
c = 3e8;

desired_frequency_temp = desired_frequency;

if desired_frequency==73
    desired_frequency_temp = 73.5;
else
end
frequency = desired_frequency_temp*1e9;

lambda = c/frequency;



figure('visible',FigVisibility)

plot(timeArray,10*log10(multipathArray),'r','linewidth',1.5)
xMin = 0;

xmaxInd = find(10*log10(multipathArray)>minPower);

%%% in case there is just one multipath, directly set its RMS value to 0
if numel(xmaxInd) == 1
    RMSDelaySpread=0;
else
end

hold on
[PKS,LOCS]= findpeaks(10*log10(multipathArray));


grid on
xlabel('Absolute Propagation Time (ns)','fontsize',16,'fontweight','bold')
ylabel('Received Power (dBm)','fontsize',16,'fontweight','bold')


title(titleName,'fontsize',16,'fontweight','bold')

set(gca,'fontweight','bold','fontsize',14)


yMax = -20;
yMin = minPower-3;
ylim([yMin yMax ])

if ~isempty(xmaxInd)
xMax = timeArray(xmaxInd(end));
xlim([xMin 2.5*xMax])
%             set(gcf,'position',[ -883   514   560   420])


else
end

yLim = get(gca,'YLim');

gMax = yLim(2);
gMin = yLim(1);

deltaY = abs(gMax-gMin);
ratio = .08;

hMax = gMax - ratio*deltaY;
hMin = gMin+ratio*deltaY+.0045;


yarray = linspace(hMax,hMin,8);
text_pos = 1.1*xMax;

text(text_pos,yarray(2),[num2str(desired_frequency),' GHz ',char(envType)],'fontsize',15,'fontweight','bold')
text(text_pos,yarray(3),['(TX,RX) HPBW: (',num2str(TXBW_Azi),'{\circ},',num2str(RXBW_Azi),'{\circ})'],'fontsize',15,'fontweight','bold')        

text(text_pos,yarray(4),[num2str(dist,'%.1f'),' m T-R Separation'],'fontsize',15,'fontweight','bold')        

text(text_pos,yarray(5),['\sigma_{\tau} = ', num2str(RMSDelaySpread,'%.1f'),' ns'],'FontSize',15,'fontweight','bold')
text(text_pos,yarray(6),['P_r = ', num2str(10*log10(Pr_Lin),'%.2f'),' dBm'],'FontSize',15,'fontweight','bold')
text(text_pos,yarray(7),['PL = ', num2str(PL,'%.2f'),' dB'],'FontSize',15,'fontweight','bold')







set(gcf,'color','w');
set(gcf,'Unit','Inches');
pos = get(gcf,'Position');
set(gcf','PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3) pos(4)]);






end