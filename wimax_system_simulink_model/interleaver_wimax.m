Ncbps=768; %the number of input bits to the Interleaver.

%ncbps=192 for bpsk,384 for QPSK,768 for 16QAM,1152 for 64QAM
Ncpc=4; %the power of 2 for each modulation ex:
%for (BPSK=1),(QPSK=2),(16QAM=4),(64QAM=6).
k = 0:Ncbps-1;
mk = (Ncbps/12)*mod(k,12)+floor(k/12);
s = ceil(Ncpc/2);
jk = s*floor(mk/s)+mod(mk+Ncbps-floor(12*mk/Ncbps),s);
jk=jk+1;
[x, intTable] = sort(jk); % per symbol


% mk= (64*mod([0:767],12)+floor([0:767]/12))
% [2*floor[(mk/2)]+mod[(mk+768-floor(12*mk/768),2]+1]';
%     
% [2*floor[((64*mod([0:767],12)+floor([0:767]/12))/2)]+mod[((64*mod([0:767],12)+floor([0:767]/12))+768-floor(12*(64*mod([0:767],12)+floor([0:767]/12))/768),2]+1]';
% 
% [2*floor[([64*mod([0:767],12)+floor([0:767]/12)]/2)]+mod[([64*mod([0:767],12)+floor([0:767]/12)]+768-floor(12*[64*mod([0:767],12)+floor([0:767]/12)]/768),2]+1]';
% 
% 
% ((1*floor((64*mod([0:383],12)+floor([0:383]/12))/2)+mod((((64*mod([0:383],12)+floor([0:383]/12))+384)-floor(12*(64*mod([0:383],12)+floor([0:383]/12))/384)),1))+1)'
