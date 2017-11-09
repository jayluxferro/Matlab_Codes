%sample time(ts)=1/fs, fs=n*BW, BW=20MHz, n=1




%****For 16QAM*****
%***Run following 4 lines at cmd prompt*****
Ry=ones(4,1)*[+1 +3 -1 -3];
ly=[+1 +3 -3 -1]'*ones(1,4);
qamConst=Ry+j*ly;
qamConst=qamConst(:)/sqrt(10);

%SET Random Integer Generator (M-ary Number to value 16)


%*****For 64QAM ********
%***Run following 4 lines at cmd prompt*****

%Ry=ones(8,1)*[+3 +1 +5 +7 -3 -1 -5 -7];
%ly=[+3 +1 +5 +7 -3 -1 -5 -7]'*ones(1,8);
%qamConst=Ry+j*ly;
%qamConst=qamConst(:)/sqrt(42);

%SET Random Integer Generator (M-ary Number to value 64)
