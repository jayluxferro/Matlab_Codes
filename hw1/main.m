%{
MAE 547: Modeling and Control of Robots
Homework 1
%}
clear;
clc;
close all;

%% Initialize variables.
filename = 'encoder.txt';

%% Format for each line of data
formatSpec = '%7f%8f%8f%8f%8f%8f%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN, 'ReturnOnError', false);

%% Remove white space around all cell columns.
dataArray{7} = strtrim(dataArray{7});

%% Close the text file.
fclose(fileID);


%% Allocate imported array to column variable names
JointO = dataArray{:, 1};
JointA = dataArray{:, 2};
JointB = dataArray{:, 3};
JointC = dataArray{:, 4};
JointD = dataArray{:, 5};
JointE = dataArray{:, 6};

%% Clear temporary variables
clearvars filename formatSpec fileID dataArray ans;


%% Plotting figure 1
x = [0 -1 0 -2 8 10 11 40 40];
y= [ 0 4 8 10 14 20 20 21 19];
%figure
%plot(x,y,'b')

%% plotting figure 2 
% calculating required angle range for the camera to focus on the window
rangle =  atan(1/29);
result=[];
y1= 29 * 2 * tan(rangle/2);
%hold on;
for k=1:length(JointE)
    y2 =  29 * 2 * tan(JointE(k)/2);
     if abs(y2) <= y1 
         result(k)=1;
     else
         result(k)=0;
     end
     k=k+1;
end
%hold off
x = linspace(0,8,length(result));
plot(x,result),xlabel('Time(h)'),ylabel('Binary Signal'),axis([0 8 -0.5 1.5]);
%result = [1 0 1 0 0 0 1 1 0];

%{
[t,s] = unrz(result,1);
plot(t,s,'LineWidth',3);
axis([0 t(end) -0.5 1.5])
grid on
%}