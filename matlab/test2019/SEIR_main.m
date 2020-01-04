global alpha beta0 beta1 gamma mu 
mu=0.02;
alpha = 31.74;
gamma = 52;
beta0 = 1095;
beta1 = 0.05;

options = odeset('MaxStep',0.01);
[T,Y] = ode45(@func_SEIR, [0,50], [0.0658 0.0007 0.0002 0.00], options);  

figure(1)
plot(T,Y(:,3),'k','LineWidth',2);
xlabel('t/ yr');
ylabel('I/ people');

%figure(2);
%plot(Y(:,1),Y(:,3));
%xlabel('-ln(S)');
%ylabel('-ln(I)');

figure(2);
%options = odeset('MaxStep',0.01);
%[T,Y] = ode45('func_SEIR',[0 50],[0.0658 0.0007 0.0002 0.0],options);  
T=T(1:450);
 T=T(1:8.6:end);
YY=Y(1:450,3);
 YY=YY(1:8.6:end)
 plot(T,YY,'k','LineWidth',2);
 xlabel('t /yr');
 ylabel('I/ people');
 hold on;
