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

function h = plotDirPDP(FigVisibility,timeArray,timeArray_Dir,multipathArray_Dir,...
    Th,TRDistance,f,sceType,envType,maxIndex,DirRMSDelaySpread,Pr_Lin_Dir,...
    PL_dir,PLE_dir,theta_3dB_TX,phi_3dB_TX,theta_3dB_RX,phi_3dB_RX,TX_Dir_Gain_Mat,...
    RX_Dir_Gain_Mat)
% Determine the visibility of the figure
figure('Visible',FigVisibility);
xmaxInd = find(10*log10(multipathArray_Dir)>=Th);
hold on; grid on;
timeLine = min(timeArray_Dir):1:max(timeArray_Dir)+100;
xlabel('Absolute Propagation Time (ns)','Fontsize',14,'fontweight','bold');
ylabel('Received Power [dBm]','Fontsize',14,'fontweight','bold');
titleName = 'Directional PDP with Strongest Power';        
title(titleName,'Fontsize',14,'fontweight','bold');
set(gca,'fontsize',14,'fontweight','bold'); 
if ~isempty(xmaxInd)
stem(timeArray_Dir, 10*log10(multipathArray_Dir),'BaseValue',Th,...
    'LineStyle','-','Marker','none','linewidth',1.5,'color',[0 0.5 0.5]); 
xlim([0.985*min(timeArray) 1.7*max(timeArray)]); 
ylim([Th max(10*log10(multipathArray_Dir))+1]);
% yMax = max(10*log10(multipathArray_Dir))+5; 
% yMin = Th+5; 
yarray = linspace(0.95,0.1,12);
text_pos = 0.43;
text(text_pos,yarray(2),[num2str(f),' GHz ',char(sceType),' ',char(envType)],...
    'Units','normalized','fontsize',15,'fontweight','bold')
text(text_pos,yarray(3),[num2str(TRDistance,'%.1f'),' m T-R Separation'],'Units','normalized',...
    'fontsize',15,'fontweight','bold')        
text(text_pos,yarray(4),['\sigma_{\tau} = ', num2str(DirRMSDelaySpread(maxIndex),'%.1f'),' ns'],...
    'Units','normalized','FontSize',15,'fontweight','bold')
text(text_pos,yarray(5),['P_r = ', num2str(10*log10(Pr_Lin_Dir),'%.1f'),' dBm'],...
    'Units','normalized','FontSize',15,'fontweight','bold')
text(text_pos,yarray(6),['PL = ', num2str(PL_dir(maxIndex),'%.1f'),' dB'],...
    'Units','normalized','FontSize',15,'fontweight','bold')
text(text_pos,yarray(7),['PLE = ', num2str(PLE_dir(maxIndex),'%.1f')],'Units','normalized',...
    'FontSize',15,'fontweight','bold')
text(text_pos,yarray(8),['TX Ant. HPBW: ', num2str(theta_3dB_TX),'^o AZ, ',...
    num2str(phi_3dB_TX),'^o EL'],'Units','normalized','FontSize',15,'fontweight','bold')
text(text_pos,yarray(9),['TX Ant. Gain: ', num2str(10*log10(max(TX_Dir_Gain_Mat)),'%.1f'),' dBi'],...
    'Units','normalized','FontSize',15,'fontweight','bold')
text(text_pos,yarray(10),['RX Ant. HPBW: ', num2str(theta_3dB_RX),'^o AZ, ',...
    num2str(phi_3dB_RX),'^o EL'],'Units','normalized','FontSize',15,'fontweight','bold')
text(text_pos,yarray(11),['RX Ant. Gain: ', num2str(10*log10(max(RX_Dir_Gain_Mat)),'%.1f'),' dBi'],...
    'Units','normalized','FontSize',15,'fontweight','bold')
else
    text(0.18,0.6,['No Detectable Multipath Components',char(10),'above the Threshold of ',num2str(Th),' dBm'],...
        'Units','normalized','fontsize',15,'fontweight','bold');
end
h = gcf;
end
