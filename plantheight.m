% Plant height 40 days
close all;
clear;
clc;
A=[20.1 20.1 20.6 20.2 20.4 20.9 19.7 20.6];
B=[16.5 14.2 13.9 14.8 14.1 12.5 14.6 12.1];
figure
hold on
bar(A,'r')
bar(B,'b')
grid on
title('Growth Performance at 40 days')
xlabel('Bed Number');
ylabel('Plant Height');
legend('Intelligent Irrigation','Manual Irrigation');
hold off


%plant height 50 days
clear;clc;
A=[37.3 35.2 36.5 37.7 36.1 37.2 36.8 36.6];
B=[17.2 17.6 18.1 16.0 17.3 14.3 17.2 16.4];
figure
hold on
bar(A,'r')
bar(B,'b')
grid on
title('Growth Performance at 50 days')
xlabel('Bed Number');
ylabel('Plant Height');
legend('Intelligent Irrigation','Manual Irrigation');
hold off

