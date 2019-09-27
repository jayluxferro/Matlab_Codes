% geometric series sum
close all;
clear
N = 1:20;
for n = N
    s(n) = (1/2)^n;
end

figure(1)
plot(N, s);

for K = N
   n = K:-1:1;
   Sn(K) = sum((1/2).^n);
end
figure(2)
plot(N, Sn)