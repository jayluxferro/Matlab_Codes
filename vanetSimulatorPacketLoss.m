%vanet simulator code
%Author: Justice Owusu Agyemang
%Date: 17th August, 2016
disp('.#######..VANET SIMULATOR CODE..########..')
x=[60 120 180 240 300 360 660 720 780 840 900];
y=[179 765 1393 2011 2738 3656 4460 4606 4876 5137 5325];
plot(x,y)
grid on
legend('5000 vehicles==>Boston')
xlabel('Time(s)')
ylabel('Number of failed broadcast messages')