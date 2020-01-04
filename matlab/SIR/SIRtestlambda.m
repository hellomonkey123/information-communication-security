clc;
clear;

beta = 0.8;  % Receiving information probability
mu = 0.8;    % Communication probability;
lambda1 = 0.2;    % The probability of node abandoning their information without trust
delta = 0.1; % The infected node will be checked and turn into R state


k = 3;

N = 6000;
T = 3;
tt = 0.005;

x_S = zeros(length(lambda1),N);
x_I = zeros(length(lambda1),N);
x_R = zeros(length(lambda1),N);

% P = zeros(1,N);
utility = zeros(1,N);

lambda1 = 0.1:0.01:0.6;

P1 = 0.2;
P2 = 0.7;
x_S(1,1) = 0.8;
x_I(1,1) = 0.1;
x_R(1,1) = 0.1;

for ii = 1 : length(lambda1)
for jj = 1 : N
    
    %%
    
    x_S(ii,jj + 1) = x_S(1,jj) + (-beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P1)*k - beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
    + lambda1(ii)*x_R(1,jj) + (lambda1(ii))*x_I(1,jj))*tt;
    x_R(ii,jj + 1) = x_R(1,jj) + (-lambda1(ii)*x_R(1,jj) + beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
    + beta*mu*x_I(1,jj)*x_R(1,jj)*(P1+P2-1)*k)*tt;
    x_I(ii,jj + 1) = x_I(1,jj) + (-(lambda1(ii))*x_I(1,jj) + beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P1)*k -beta*mu*x_I(1,jj)*x_R(1,jj)*(P1+P2-1)*k)*tt;
    
%     utility(1,jj) = (100*x_R(1,jj)^2 - 50*x_I(1,jj)^2) - 0.02*40*jj*tt;
    
    %%
end
end
% figure(1)
% hold on
% plot(x_S(1:20:N),'r','LineStyle','-.','LineWidth',1);
% plot(x_R(1:20:N),'b','LineStyle',':','LineWidth',1);
% plot(x_I(1:20:N),'g','LineStyle','--','LineWidth',1);
% %plot(utility,'black');
% xlabel('t');
% ylabel('Probability');
% legend('S的概率','R的概率','I 的概率');
% title("SIR模型的马尔可夫稳态");

figure(2)
plot(lambda1,x_S(:,N),'b');
xlabel('λ');
ylabel('S 状态概率');
title("λ对S状态的影响");

