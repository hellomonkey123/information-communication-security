clc;
clear;

beta = 0.8;  % Receiving information probability
mu = 0.8;    % Communication probability;
lambda = 0.2;    % The probability of node abandoning their information without trust
delta = 0.1; % The infected node will be checked and turn into R state


k = 3;

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
x_I(1,1) = 0.2;
x_R(1,1) = 0.1;


for jj = 1 : N
    
    %%
    
    x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_I(1,jj)*x_S(1,jj)*k +(lambda)*x_I(1,jj))*tt;
    
    x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) + beta*mu*x_I(1,jj)*x_S(1,jj)*k )*tt;
    
   
    
    %%
end

figure(1)
hold on
plot(x_S(1:20:1000),'rs','LineStyle','-.','LineWidth',1);
plot(x_I(1:20:1000),'g+','LineStyle','--','LineWidth',1);
%plot(utility,'black');
xlabel('时间t');
ylabel('各状态概率');
legend('S的概率','I 的概率');
title("SIS模型的马尔可夫稳态");



