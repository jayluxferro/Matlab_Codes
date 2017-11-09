%{
Speech Mixing
Author: Jay Lux Ferro
Date: 2nd November, 2017
%}

%% Default
clc;
clear;
close all;

%% initializations
y1=[];y2=[];y3=[];y=[];
Fs=8000;
B = 16;
channel = 2;

r = audiorecorder(Fs,B,channel); % audio recorder object
for i=1:3
    disp('Please get ready to record for 5 seconds: press enter to proceed');
    pause
    disp('Recording ....');
    recordblocking(r,5);
    if i==1
        y1 = getaudiodata(r);
    elseif i== 2
        y2 = getaudiodata(r);
    elseif i==3
        y3 = getaudiodata(r);
    end
end
%playing fall sounds
for i=1:3
    if i==1
        disp('About to listen to first recording: press enter to proceed');
        pause
        p = audioplayer(y1,Fs);
        play(p);
    elseif i==2
        disp('About to listen to second recording: press enter to proceed');
        pause
        p = audioplayer(y2,Fs);
        play(p);
    elseif i==3
        disp('About to listen to third recording: press enter to proceed');
        pause
        p = audioplayer(y3,Fs);
        play(p);
    end
end


disp('Playing mixed signal: press enter to proceed');
pause
y = y1 + y2 + y3; % mixing the audio inputs
p = audioplayer(y,Fs); % audio player object
play(p); % playing mixed signals

%% getting original speech signals
y1_Original = y - (y2 + y3);
y2_Original = y - (y1 + y3);
y3_Original = y - (y1 + y2);

disp('Performing signal recovery');
for i=1:3
    if i==1
        disp('Playing first recorded original audio: : press enter to proceed')
        pause
        p = audioplayer(y1_Original,Fs);
        play(p);
    elseif i==2
        disp('Playing second recorded original audio: press enter to proceed')
        pause
        p = audioplayer(y2_Original,Fs);
        play(p);
    elseif i==3
        disp('Playing third recorded original audio: press enter to proceed')
        pause
        p = audioplayer(y3_Original,Fs);
        play(p);
    end
end
