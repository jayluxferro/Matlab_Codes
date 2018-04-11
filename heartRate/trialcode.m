clear all
clc
close all
load('14157m.mat');
seg4=val;

% FILTERING PROCESS
% used high frequency filtering with normalized cut-off frequencies  
[b,a]=butter(10,[0.15,0.40]);
feltseg4=filter(b,a,seg4);
figure, plot(abs(feltseg4))
title('Band pass filtered  signal');
xlabel('sample');
ylabel('amplitude');


% DIFFERENTIAL PROCESS
difseg4=abs(diff(feltseg4));
figure, plot(difseg4)
title('first  derivative of signal');
xlabel('sample');
ylabel('amplitude');

%SECOND DIFFERENTIAL OF THE SIGNAL
defdif=abs(diff(difseg4));
figure
plot(defdif)
title('Second derivative of signal');
xlabel('sample');
ylabel('amplitude');

% IGNORED THE FREQUENCY SPECTRUM ANALYSIS

%fastftseg4=fft(defdif);
%m=length(fastftseg4);
%onefft=fastftseg4(1:m/2);

%   PEAK DETECTION PROCESS
sig_positions=[];    % TO CREATE AN ARRAY TO STORE THE RR INTERVALS DETECTED

count = 0;
for k=2: length(seg4)-1
    if(seg4(k)> seg4(k-1)& seg4(k)> seg4(k+1)& seg4(k) > 300)
        k
        count = count+1;
        disp('prominent peak found');
        sig_positions=[sig_positions;k];
    end
    
end
disp('The total number of peaks are : ');
fprintf('%d',count);
  disp(sig_positions)
  
  % THRESHOLD PROCESS
  z = zeros(1,length(defdif));
for i = 10:length(defdif)-1
       if defdif(i) >= 50;
      z(i) = 10;
     
       end
end

figure,plot(z)
title('Threshold signal');
xlabel('sample');
ylabel('amplitude');

 figure, plot(seg4)
 title('Unprocessed signal');
 xlabel('sample');
ylabel('amplitude');
 
 % STATISTICAL VALUES
  
 disp('the differences in the RR interval positions\n');
 differences = diff(sig_positions)
 
 disp('MEAN OF THE DIFFERENCES IN THE RR INTERVALS\n');
 mean_sig = mean(differences)
 
 disp('THE STANDARD DEVIATION OF THE RR INTERVAL');
 std_dev = std(differences)

        
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
