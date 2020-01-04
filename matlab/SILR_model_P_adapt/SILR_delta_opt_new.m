clear;
clc;

k = 1;
% p = 0.6;
p_D = 0.6;


x = 0:0.1:100;
beta = 0.3;
alpha = 0.2;

tau = 0.3;

% P_R = p*p_D + (1 - p)*(1 - p_D);
% P_I = 1 - P_R;

N1 = 40000;
t = 0.001;
%接下来要做的是，最终达到的稳态和转移参数的数值关系
% beta_1= 0.1283;  
% beta_2= 0.1650;  %这里是验证论文里面选取的两个使I最终为零的是否成立
delta = log10(1 + 3*x./(10+x)) + 0.2;

x_S  =  zeros(length(delta),N1+1);
x_I  =  zeros(length(delta),N1+1);
x_R  =  zeros(length(delta),N1+1);
x_L  =  zeros(length(delta),N1+1);

p = zeros(length(delta),N1+1);
P_R = zeros(length(delta),N1+1);
P_I = zeros(length(delta),N1+1);

utility = zeros(1,length(delta));

x_S(:,1)  = 0.6;
x_I(:,1)  = 0.1;
x_R(:,1)  = 0.2;
x_L(:,1)  = 0.1;

for j = 1:length(delta)
    for i = 1:N1
        p(j,i) = x_R(j,i)/(x_R(j,i) + x_I(j,i));
        P_R(j,i) = p(j,i)*p_D + (1 - p(j,i))*(1 - p_D);
        P_I(j,i) = 1 - P_R(j,i);
    
        x_S(j,i+1) = x_S(j,i) + (-(1 - x_S(j,i))*k*x_S(j,i) + tau*x_R(j,i) + delta(j)*x_I(j,i))*t;
        x_L(j,i+1) = x_L(j,i) + (-(1 -beta)*x_L(j,i)*x_S(j,i)*k  + alpha*(1 - x_S(j,i))*k*x_S(j,i))*t;
        x_R(j,i+1) = x_R(j,i)+(-tau*x_R(j,i) - (1 -tau)*P_I(j,i)*x_R(1,i) + (1 -beta)*P_R(j,i)*x_L(j,i)*x_S(j,i)*k ......
        + (1 - alpha)*P_R(j,i)*(1 - x_S(j,i))*k*x_S(j,i) )*t;
        x_I(j,i+1) = x_I(j,i)+(-delta(j)*x_I(j,i) + (1 -tau)*P_I(j,i)*x_R(1,i) ......
        + (1 - alpha)*P_I(j,i)*(1 - x_S(j,i))*k*x_S(j,i) + (1 - beta)*P_I(j,i)*x_L(j,i)*k*x_S(j,i))*t;
    end
    
    utility(j) = P_R(j,N1)* x_R(j,N1) - P_I(j,N1)*x_I(j,N1) - 0.2*delta(j);
end

% for j = 1:length(delta)
%     utility(j) = P_R(j,N1)* x_R(j,N1) - P_I(j,N1)*x_I(j,N1) - 0.2*delta(j);
% end

figure(1)
hold on
plot(x_S(:,40000),'r');
plot(x_R(:,40000),'b');
plot(x_I(:,40000),'g');
plot(x_L(:,40000),'y');
plot(utility,'black');
xlabel('t');
ylabel('Probability');
legend('S的概率','R的概率','I的概率','L的概率','utility');
title("策略x对SRIL马尔可夫稳态的影响");


