clc;
clear;

beta = 0.6;      % Receiving information probability
mu = 0.7;        % Communication probability;
lambda = 0.1;    % The probability of node losing their information
theta = 0.1;     % R states' node will not trust their recieved information
delta = 0.1;     % The ability of infected node have immunity
gamma = 0.2;     % the node recieved information without transforming
tau = 0.6;       % L states' node checked

P1 = 0.55;
P2 = 0.5;
P_cost = 0:1:60;

k = 1;

N = 24000;
T = 3;
tt = 0.01;

x_S = zeros(1,N);
x_I = zeros(1,N);
x_R = zeros(1,N);
x_LI = zeros(1,N);
x_LR = zeros(1,N);

utility = zeros(2,length(P_cost));
P = zeros(length(P_cost),N);

%P(:,1) = 0.6;
x_S(1,1) = 0.5;
x_I(1,1) = 0.1;
x_R(1,1) = 0.2;
x_LI(1,1) = 0.1;
x_LR(1,1) = 0.1;

    for jj = 1 : N
    
%         theta = x_R(1,jj)/(x_R(1,jj)+x_I(1,jj));
        %P(1,jj) = log(1+x_I(1,jj)) + log10(1 + 3*P_cost(ii)/(10+P_cost(ii)));
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_S(1,jj)*k*((x_I(1,jj)+x_R(1,jj))*gamma+(x_I(1,jj)*(1-P2)+x_R(1,jj)*P1)*(1-gamma)) ......
         + lambda*(x_I(1,jj) + x_R(1,jj)) + tau*(x_LR(1,jj)*(1-P1)+x_LI(1,jj)*P2)+delta*(x_LR(1,jj)+x_LI(1,jj)))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + P1*tau*x_LR(1,jj) + beta*mu*x_S(1,jj)* x_R(1,jj)*k*P1*(1-gamma) ......
        + beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k- beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) - beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k + (1-P2)*tau*x_LI(1,jj) ......
        +  beta*mu*x_I(1,jj)*x_S(1,jj)*(1-gamma)*k*(1-P2)+ beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_LR(1,jj + 1) = x_LR(1,jj) + (-(tau+delta)*x_LR(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_R(1,jj)))*tt;
        x_LI(1,jj + 1) = x_LI(1,jj) + (-(tau+delta)*x_LI(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_I(1,jj)))*tt;
    end
%     utility(ii) = (100*x_R(ii,N)^2 - 500*x_I(ii,N)^2) - 0.02*P_cost(ii)*N*tt;
    
    %%另外可以计算一个时间周期内utility的最小值
    


figure(1)
hold on

plot(x_S(1:400:N),'mo','LineStyle','-.','LineWidth',1);
plot(x_R(1:400:N),'g+','LineStyle',':','LineWidth',1);
plot(x_I(1:400:N),'rs','LineStyle','--','LineWidth',1);
plot(x_LI(1:400:N),'cx','LineStyle',':','LineWidth',1);
plot(x_LR(1:400:N),'b*','LineStyle','--','LineWidth',1);
%plot(utility,'black');
xlabel('时间t');
ylabel('各状态概率');
h=legend('S的概率','R的概率','I的概率','L_I的概率','L_R的概率');
title("SIRL模型的马尔可夫稳态");
set(h,'Interpreter','latex','Location','SouthOutside')


% figure(2)
% hold on
% plot(utility(1:400:N),'bo','LineStyle',':','LineWidth',1);
% plot(utility(2:400:N),'g+','LineStyle','-.','LineWidth',1);
% xlabel('代价开销值');
% ylabel('信息质量与代价差值');
% legend('x_{cp}','x_{ca}');
% title("SIRL模型信息质量和代价的效用函数");


