clc;
clear;
%%
%%%% This method use impulse detecting
beta = 0.6;  % Receiving information probability
mu = 0.7;    % Communication probability;
lambda = 0.1;    % The probability of node abandoning their information without trust
delta = 0.3; % The infected node will be checked and turn into R state


k = 3;

N = 10000;
T = 3;
tt = 0.005;

x_S = zeros(1,N);
x_I = zeros(1,N);
x_R = zeros(1,N);

P = zeros(1,N);
utility = zeros(1,N);

P(1,1) = 0.6;
x_S(1,1) = 0.7;
x_I(1,1) = 0.2;
x_R(1,1) = 0.1;


for jj = 1 : N
    
    %%
%     if jj < 2050 || rem(jj,5) == 0
    if rem(jj,5) == 0
        P(1,jj) = log(1+x_I(1,jj)) + 0.3;
    else
        P(1,jj) = log(1+x_I(1,jj));
    end
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_I(1,jj)*x_S(1,jj)*k - beta*mu*x_S(1,jj)*x_R(1,jj)*k*P(1,jj) ......
        + lambda*x_R(1,jj) + (P(1,jj)*(1-delta)+lambda)*x_I(1,jj))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + P(1,jj)*delta*x_I(1,jj) + beta*mu*x_S(1,jj)*x_R(1,jj)*k*P(1,jj) ......
        + beta*mu*x_I(1,jj)*x_S(1,jj)*P(1,jj)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(P(1,jj)+lambda)*x_I(1,jj) + beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P(1,jj))*k)*tt;
    
    
    %%
end

figure(1)
hold on

plot(x_S,'r');
plot(x_R,'b');
plot(x_I,'g');
%plot(utility,'black');
xlabel('t');
ylabel('Probability');
legend('S的概率','R的概率','I的概率');
title("SIR模型的马尔可夫稳态");

% figure(2)
% plot(utility);


