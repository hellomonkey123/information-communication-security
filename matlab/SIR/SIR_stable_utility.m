clc;
clear;

beta = 0.9;  % Receiving information probability
mu = 0.7;    % Communication probability;
lambda = 0.1;    % The probability of node losing their information

delta = 0.3; % The ability of infected node have immunity

P_cost = 1:0.25:40;

k = 3;

N = 6000;
T = 3;
tt = 0.001;

x_S = zeros(length(P_cost),N);
x_I = zeros(length(P_cost),N);
x_R = zeros(length(P_cost),N);

utility = zeros(2,length(P_cost));
P = zeros(1,length(P_cost));


x_S(:,1) = 0.5;
x_I(:,1) = 0.4;
x_R(:,1) = 0.1;

for ii = 1 : length(P_cost)
    for jj = 1 : N
    P(ii) = exp(-(1+3/P_cost(ii))) + 0.3;
        P(ii) = log(1+x_I(ii,jj)) + log10(1 + 3*P_cost(ii)/(10+P_cost(ii)));
        x_S(ii,jj + 1) = x_S(ii,jj) + (-beta*mu*x_I(ii,jj)*x_S(ii,jj)*k - beta*mu*x_S(ii,jj)*x_R(ii,jj)*k ......
        + lambda*x_R(ii,jj) + (P(ii)*(1-delta)+lambda)*x_I(ii,jj))*tt;
        x_R(ii,jj + 1) = x_R(ii,jj) + (-lambda*x_R(ii,jj) + P(ii)*delta*x_I(ii,jj) + beta*mu*x_S(ii,jj)* ......
        x_R(ii,jj)*k + beta*mu*x_I(ii,jj)*x_S(ii,jj)*P(ii)*k*delta)*tt;
        x_I(ii,jj + 1) = x_I(ii,jj) + (-(P(ii)+lambda)*x_I(ii,jj) + beta*mu*x_I(ii,jj)*x_S(ii,jj)*(1-P(ii))*k)*tt;
    end
    utility(1,ii) = (100*x_R(ii,N)^2 - 500*x_I(ii,N)^2) - 0.02*P_cost(ii)*N*tt;
    %%另外可以计算一个时间周期内utility的最小值
    
end

x_S(:,1) = 0.5;
x_I(:,1) = 0.4;
x_R(:,1) = 0.1;

for ii = 1 : length(P_cost)
    for jj = 1 : N
    
         P(ii) = log(1+0.6*P_cost(ii)/(20+P_cost(ii)))+ 0.4;
        x_S(ii,jj + 1) = x_S(ii,jj) + (-beta*mu*x_I(ii,jj)*x_S(ii,jj)*k - beta*mu*x_S(ii,jj)*x_R(ii,jj)*k ......
        + lambda*x_R(ii,jj) + (P(ii)*(1-delta)+lambda)*x_I(ii,jj))*tt;
        x_R(ii,jj + 1) = x_R(ii,jj) + (-lambda*x_R(ii,jj) + P(ii)*delta*x_I(ii,jj) + beta*mu*x_S(ii,jj)* ......
        x_R(ii,jj)*k + beta*mu*x_I(ii,jj)*x_S(ii,jj)*P(ii)*k*delta)*tt;
        x_I(ii,jj + 1) = x_I(ii,jj) + (-(P(ii)+lambda)*x_I(ii,jj) + beta*mu*x_I(ii,jj)*x_S(ii,jj)*(1-P(ii))*k)*tt;
    end
    utility(2,ii) = (100*x_R(ii,N)^2 - 500*x_I(ii,N)^2) - 0.04*P_cost(ii)*N*tt;
    %%另外可以计算一个时间周期内utility的最小值
    
end

figure(1)
hold on

plot(x_S(:,N),'r');
plot(x_R(:,N),'b');
plot(x_I(:,N),'g');
%plot(utility,'black');
xlabel('t');
ylabel('Probability');
legend('S的概率','R的概率','I的概率');
title("SIR模型的马尔可夫稳态");




       

figure(2)
hold on
plot(utility(1,:),'bo','LineStyle',':','LineWidth',1);
plot(utility(2,:),'g+','LineStyle','-.','LineWidth',1);
xlabel('代价开销值');
ylabel('信息质量与代价差值');
legend('处理器代价x_{cp}','缓存代价x_{ca}');
title("SIR模型信息质量和代价的效用函数");

