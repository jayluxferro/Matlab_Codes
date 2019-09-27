%Voice input analysis
%Author: Justice Owusu Agyemang
%Date: 25th September, 2016
clc;
clear;
msgbox('Voice input analysis code: Justice Owusu Agyemang','Voice Input analysis using matlab');
disp('Project: Voice input analys');
disp('By  Justice Owusu Agyemang ');
disp(' ');
pause(0.5);
disp('LOADING ');
pause(1);
disp('... ');
pause(1);
disp('... ');
pause(1);
disp('... ');
pause(1);
disp('... ');
%reading audio file
audiofile=input('Enter audio filename: ');
[Y,FS]=audioread(audiofile);
p=audioplayer(Y,FS);
play(p);
x=linspace(1,length(Y),length(Y));
plot(x,Y),grid on, box on, xlabel('frequency(Hz)'),ylabel('Amplitude');
audioinfo(audiofile)