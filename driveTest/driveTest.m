%{
 Drive Test Data
 Date: 21st March, 2019
 Author: Stephen Nuagah
%}

%% Loading data
clc; clear; close all;
load('data')

Gt = 18.15;
L = 10.7;
techiman = data(1:10, 1:3);
adum = data(14:23, 2:4);
agogo = data(27:36, 2:4);
afrancho = data(51:60, 2:4);
dorma = data(68:77, 2:4);

%% Calculating average of received power (column 4)
for k=1:10
   techiman(k, 4) =  mean(techiman(k, 1:3));
   adum(k, 4) = mean(adum(k, 1:3));
   agogo(k, 4) = mean(agogo(k, 1:3));
   afrancho(k, 4) = mean(afrancho(k, 1:3));
   dorma(k, 4) = mean(dorma(k, 1:3));
end

%% Calculating EIRP (column 5)
for k=1:10
   techiman(k, 5) =  EIRP(techiman(k,4), Gt, L);
   adum(k, 5) = EIRP(adum(k,4), Gt, L);
   agogo(k, 5) = EIRP(agogo(k,4), Gt, L);
   afrancho(k, 5) = EIRP(afrancho(k,4), Gt, L);
   dorma(k, 5) = EIRP(dorma(k,4), Gt, L);
end

%% Calculating Path Loss (Column 6)
for k = 1:10
   techiman(k, 6) =  PL(techiman(k,5), techiman(k, 4));
   adum(k, 6) = PL(adum(k,5), adum(k, 4));
   agogo(k, 6) = PL(agogo(k,5), agogo(k, 4));
   afrancho(k, 6) = PL(afrancho(k,5), afrancho(k, 4));
   dorma(k, 6) = PL(dorma(k,5), dorma(k, 4));
end

%% Plotting Path Loss / Distance
x = 50:50:500;

% single graphs
figure(1)
plot(x, techiman(1:10, 4));
xlabel('Distance'), ylabel('Path Loss (dBm)');
title('Path Loss (Techiman)');
grid('on');


figure(2)
plot(x, adum(1:10, 4));
xlabel('Distance'), ylabel('Path Loss (dBm)');
title('Path Loss (Adum)');
grid('on')


figure(3)
plot(x, agogo(1:10, 4));
xlabel('Distance'), ylabel('Path Loss (dBm)');
title('Path Loss (Agogo)');
grid('on')


figure(4)
plot(x, afrancho(1:10, 4));
xlabel('Distance'), ylabel('Path Loss (dBm)');
title('Path Loss (D. Afrancho)');
grid('on')


figure(5)
plot(x, dorma(1:10, 4));
xlabel('Distance'), ylabel('Path Loss (dBm)');
title('Path Loss (New Dorma)');
grid('on')

% all areas
figure(6)
plot(x, techiman(1:10, 4),...
        x, adum(1:10, 4),...
        x, agogo(1:10, 4),...
        x, afrancho(1:10, 4),...
        x, dorma(1:10, 4));
xlabel('Distance'), ylabel('Path Loss (dBm)');
title('Path Loss');
legend('Techiman', 'Adum', 'Agogo', 'D. Afrancho', 'New Dorma');
grid('on');


