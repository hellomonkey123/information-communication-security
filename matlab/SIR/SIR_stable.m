clc;
clear;

beta = 0.8;  % Receiving information probability
mu = 0.8;    % Communication probability;
lambda = 0.1;    % The probability of node abandoning their information without trust
delta = 0.1; % The infected node will be checked and turn into R state


k = 1;

N = 20000;
T = 3;
tt = 0.005;

x_S = zeros(1,N);
x_I = zeros(1,N);
x_R = zeros(1,N);

% P = zeros(1,N);
utility = zeros(2,N);

P1 = 0.5;
P2 = 0.6;
x_S(1,1) = 0.8;
x_I(1,1) = 0.1;
x_R(1,1) = 0.1;


for jj = 1 : N
    
    %%
    
    x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P1)*k - beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
    + lambda*x_R(1,jj) + (lambda)*x_I(1,jj))*tt;
    x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
    + beta*mu*x_I(1,jj)*x_R(1,jj)*(P1+P2-1)*k)*tt;
    x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) + beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P1)*k -beta*mu*x_I(1,jj)*x_R(1,jj)*(P1+P2-1)*k)*tt;
    
    utility(1,jj) = (100*x_R(1,jj)^2 - 50*x_I(1,jj)^2) - 0.02*40*jj*tt;
    utility(2,jj) = (100*x_R(1,jj)^2 - 50*x_I(1,jj)^2) - 0.02*50*jj*tt;
    
    %%
end

figure(1)
hold on
plot(x_S(1:400:N),'rs','LineStyle','-.','LineWidth',1);
plot(x_R(1:400:N),'bo','LineStyle',':','LineWidth',1);
plot(x_I(1:400:N),'g+','LineStyle','--','LineWidth',1);
%plot(utility,'black');
xlabel('t');
ylabel('Probability');
legend('S的概率','R的概率','I 的概率');
title("SIR模型的马尔可夫稳态");

figure(2)
hold on
plot(utility(1:400:N),'bo','LineStyle',':','LineWidth',1);
plot(utility(2:400:N),'g+','LineStyle','-.','LineWidth',1);
xlabel('代价开销值');
ylabel('信息质量与代价差值');
legend('x_{cp}','x_{ca}');
title("SIR模型信息质量和代价的效用函数");


