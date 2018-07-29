clear all
clc
close all

load('14157m.mat');
seg4=val;
%seg4= abs(signal);
plot(seg4);
title('ECG SIGNAL');
%plot(seg4,'bo');
Fs= 250;
Ts=1/Fs
L= length(seg4)
%figure, plot(signal);
time= L/Fs


%   PEAK DETECTION PROCESS
sig_positions=[];    % TO CREATE AN ARRAY TO STORE THE RR INTERVALS DETECTED
sig_position_in_time=[];
position_in_ms=[];
count = 0;
for k=2: length(seg4)-1
    if(seg4(k)> seg4(k-1)& seg4(k)> seg4(k+1)& seg4(k) > 180); %suppress
        k
        count = count+1;
        disp('prominent peak found');
        sig_positions=[sig_positions;k];
        sig_position_in_time= sig_positions/Fs;
       % position_in_ms= (sig_position_in_time)*1000;
    end
    
end

disp('The total number of peaks are : ');

fprintf('%d',count);

  disp(sig_positions);
  
disp('SIGNAL POSITION IN TIME (SECONDS)')
disp(sig_position_in_time);

%disp(' POSITIONS IN MS ')
%disp(position_in_ms); %we have suppreseed the display for this output
 
  % LOCATION OF R PEAKS
  z1 = zeros(1,length(seg4));
for i = 2:length(seg4)-1
       if seg4(i) >= 100;
     z1(i) =seg4(i);
     
       end
end

figure,plot(z1)
title('R PEAKS');

  % THRESHOLD PROCESS   
  z = zeros(1,length(seg4));
for i = 2:length(seg4)-1
       if seg4(i) >= 100;
      z(i) = 10;
     
       end
end

figure,plot(z)
title('THRESHOLD SIGNAL');

% HEART RATE
%disp('HEART RATE')
HEART_RATE = (count*60)/time
 
 
  %= sig_positions/Fs
  
 % STATISTICAL VALUES
  
  % CHANGING TO TIME DOMIAN
 %Fs= (length(seg4))/60;
 %time = (sig_positions/Fs);
 %interval= diff(time);
 %mean_interval = mean(interval)
 
 
 disp('the differences in the RR interval positions\n')
 differences = diff(sig_position_in_time)
 
 % time intervals in ms
 
% differences = difference*(1000);
 
 disp('MEAN OF THE DIFFERENCES IN THE RR INTERVALS\n');
 mean_sig = mean(differences)
 
 disp('THE STANDARD DEVIATION OF THE RR INTERVAL');
% std_dev = std(differences)
 %CALCULATING THE STANDARD DEVIATION USING FORMULA 
 
 % THE differences between the ean and the rr interval
 % square the result 
% find the mean of the total and the square root of the mean 
 
stndDev= differences-(mean_sig);
sqDev=(stndDev).^2;
mean_sqDev=mean(sqDev);
standard_dev=sqrt(mean_sqDev)
 
 
 
 
  
 
 %RMSSD       ROOT MEAN SQUARE OF THE R-R INTERVAL
%P1 = (differences).^2;
%p2 = mean(P1);
%RMSSD = sqrt(p2)

NNN = diff(differences);
p11= (NNN).^2;
p22= mean(p11)
rmssd= sqrt(p22)

%PNN50        PERCENTAGE OF R-R INTERVAL > 50ms
%SS = differences > 50;
% 50ms will correspond to 0.05sNNN = diff(differences);
NNN_positions=[];

count2 = 0;
for m=2: length(NNN)-1
    if(NNN(m)> 0.050 || NNN(m)< -0.050); %suppress
        m; %we suppress
        count2 = count2+1;
       
        NNN_positions =[NNN_positions;m];
        
        
    end
    
end
disp('NN50 : ');

fprintf('%d',count2);

  %disp(sig_positions);


disp(NNN_positions);

%sstime= NNN > 50
%NN50 = length(sstime)
PNN50 = ((count2)/count)*100


% DIAGNOSIS

% FOR NORMAL AUTONOMIC FUNCTIO
if standard_dev > 0.150;
    disp('NORMAL AUTONOMIC FUNCTION')
end

% FOR MODERATELY DEPRESSED HRV
if standard_dev < 0.1OO;
    disp('MODERTAELY DEPRESSESD HRV')
end

% FOR CARDIOVASCULAR DISEASES
if standard_dev > 0.35;
    disp(' POSSIBLE CARDIOVASCULAR DISEASE, VISIT THE NEAREST HOSPITAL IMMEDIATELY')
end

% FOR HIGHLY DEPRESSED HRV
if standard_dev < 0.05;
    disp('HIGHLY DEPRESSED HRV VISIT THE NEAREST HOSPITAL FOR FURTHER TEST')
end

% FOR NORMAL HEART RATE
if HEART_RATE > 60 & HEART_RATE < 90;
    disp('NORMAL HEART RATE')
end

% FOR ABNORMAL HEART RATE
if HEART_RATE < 60 ||HEART_RATE > 90;
    disp('POSSIBLE CARDIOVASCULAR DISEASE PRESENT')
end
