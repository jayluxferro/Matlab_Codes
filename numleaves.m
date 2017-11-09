%num leaves
close all;
clear;
clc;

%40 days
A=[4.8 4.0 5.1 4.5 5.2 6.0 5.1 5.4];
B=[3.8 4.1 4.0 4.2 3.6 3.8 3.7 3.5];
figure
hold on
bar(A,'r')
bar(B,'b')
grid on
title('Growth Performance at 40 days')
xlabel('Bed Number');
ylabel('Number of leaves');
legend('Intelligent Irrigation','Manual Irrigation');
hold off



%50 days
A=[7.1 7.1 7.4 7.4 7.2 7.4 7.4 7.5];
B=[4.8 4.8 4.6 5.4 4.3 4.1 4.3 4.7];
figure
hold on
bar(A,'r')
bar(B,'b')
grid on
title('Growth Performance at 50 days')
xlabel('Bed Number');
ylabel('Number of leaves');
legend('Intelligent Irrigation','Manual Irrigation');
hold off