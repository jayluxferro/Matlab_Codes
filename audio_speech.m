clc;
clear;
close all;

recObj=audiorecorder(8000,8,1);
disp('speak');
recordblocking(recObj,5);
play(recObj);
y1=getaudiodata(recObj);
figure(1)
plot(abs(fft(y1)))
