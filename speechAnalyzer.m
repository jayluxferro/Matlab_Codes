%{
Speech Analyzing software
Author: Jay Lux Ferro
Date: 18th October, 2017
%}
%% Initialize
clc; % clearing command window
clear; % clear workspace variables;
close all; % close all figures
recObj=audiorecorder(8000,16,2);
while 1
    recordblocking(recObj,1);
    % play(recObj);
    y1=getaudiodata(recObj);
    subplot(2,1,1)
    t = linspace(0,1,length(y1));
    plot(t,y1),xlabel('Sampling Frequency(Hz)'),ylabel('Amplitude'),title('FM Signal'),...
        grid on; %plot signal
    
    subplot(2,1,2);
    plot(abs(fft(y1,8000))),xlabel('Frequency(Hz)'),ylabel('Amplitude'),title('Fourier Transform'),...
        grid on; %plot fft signal
    
    drawnow; %display result
    pause(0.01) 
end
