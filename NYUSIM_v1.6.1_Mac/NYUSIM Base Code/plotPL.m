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

function h = plotPL(FSPL,omniPL,omniDist,dirPL,dirDist,PL_dir_best,f,sceType,envType,d0,theta_3dB_TX,...
    phi_3dB_TX,TX_Dir_Gain_Mat,theta_3dB_RX,phi_3dB_RX,RX_Dir_Gain_Mat,Th)

h = figure;
MS = 8; LW = 1.5; FoSi = 13;
dist = logspace(log10(d0),log10(1e4),1000);
if numel(omniDist) ~= 0 && numel(dirDist) ~= 0
clear A D; A = omniPL - FSPL; D = 10*log10(omniDist/d0);
omniPLE = sum(D.*A)/sum(D.*D);
omniSTD = sqrt(sum((A-D.*omniPLE).^2)/length(omniPL));
clear A D; A = dirPL - FSPL; D = 10*log10(dirDist/d0);
dirPLE = sum(D.*A)/sum(D.*D);
dirSTD = sqrt(sum((A-D.*dirPLE).^2)/length(dirPL));
clear A D; A = PL_dir_best - FSPL; D = 10*log10(omniDist/d0);
dirPLEBest = sum(D.*A)/sum(D.*D);
dirSTDBest = sqrt(sum((A-D.*dirPLEBest).^2)/length(PL_dir_best)); 
distdB = 10.*log10(dist/d0);
omniPLEline = distdB*omniPLE; omniPLEline = omniPLEline-min(omniPLEline);
dirPLEline = distdB*dirPLE; dirPLEline = dirPLEline-min(dirPLEline);
dirPLEBestline = distdB*dirPLEBest; 
dirPLEBestline = dirPLEBestline-min(dirPLEBestline);

semilogx(omniDist,omniPL,'bo','LineWidth',LW,'MarkerSize',MS); hold on; grid on;
semilogx(dirDist,dirPL,'rx','LineWidth',LW,'MarkerSize',MS);
semilogx(omniDist,PL_dir_best,'m+','LineWidth',LW,'MarkerSize',MS);
semilogx(dist,omniPLEline+FSPL,'b-','LineWidth',LW);
semilogx(dist,dirPLEline+FSPL,'r-.','LineWidth',LW);
semilogx(dist,dirPLEBestline+FSPL,'m:','LineWidth',LW);
lgd = legend('PL_{omni}','PL_{dir}','PL_{dir-best}',...
    ['n_{omni} = ',num2str(omniPLE,'%.1f'),', \sigma_{omni} = ',num2str(omniSTD,'%.1f'),' dB'],...
    ['n_{dir} = ', num2str(dirPLE,'%.1f'),', \sigma_{dir} = ',num2str(dirSTD,'%.1f'),' dB'],...
    ['n_{dir-best} = ', num2str(dirPLEBest,'%.1f'),', \sigma_{dir-best} = ',num2str(dirSTDBest,'%.1f'),' dB'],...
    'location','northwest');
set(lgd,'fontsize',FoSi); 
else
    text(0.18,0.6,['No Detectable Multipath Components',char(10),'above the Threshold of ',num2str(Th),' dBm'],...
        'Units','normalized','fontsize',FoSi,'fontweight','bold');
end
set(gca,'fontsize',FoSi); 
xlim([min(dist) max(dist)]);
ylim([30 300]);
xlabel('T-R Separation Distance (m)'); ylabel('Path Loss (dB)');
title(['Omnidirectional and Directional Path Loss - ',num2str(f),' GHz, ' sceType ' ' envType]);
text_pos = 0.55; yarray = linspace(0.96,0.8,4);
text(text_pos,yarray(1),['TX Ant. HPBW: ', num2str(theta_3dB_TX),'^o AZ, ',...
    num2str(phi_3dB_TX),'^o EL'],'Units','normalized','FontSize',FoSi)
% text(text_pos,yarray(1),['TX Ant. HPBW: ', num2str(theta_3dB_TX),'^o AZ, ',...
%     num2str(phi_3dB_TX),'^o EL'],'FontSize',FoSi)
text(text_pos,yarray(2),['TX Ant. Gain: ', num2str(10*log10(max(TX_Dir_Gain_Mat)),'%.1f'),' dBi'],...
    'Units','normalized','FontSize',FoSi)
text(text_pos,yarray(3),['RX Ant. HPBW: ', num2str(theta_3dB_RX),'^o AZ, ',...
    num2str(phi_3dB_RX),'^o EL'],'Units','normalized','FontSize',FoSi)
text(text_pos,yarray(4),['RX Ant. Gain: ', num2str(10*log10(max(RX_Dir_Gain_Mat)),'%.1f'),' dBi'],...
    'Units','normalized','FontSize',FoSi)
set(gca,'XTick',[d0 10 1e2 1e3 1e4],'XTickLabel',[d0 10 1e2 1e3 1e4],...
    'YTick',[30:30:300],'YTickLabel',[30:30:300]);

end
