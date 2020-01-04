clc;
clear;

beta = 0.8;  % Receiving information probability
mu = 0.8;    % Communication probability;
lambda = 0.1;    % The probability of node abandoning their information without trust
delta = 0.1; % The infected node will be checked and turn into R state

beta1 = 0.1:0.01:0.6;
lambda1 = 0.1:0.01:0.6;
P1 = 0.1:0.01:0.6;
k = 1;

N = 30000;
T = 3;
tt = 0.01;

x_S = zeros(1,N);
x_I = zeros(1,N);
x_R = zeros(1,N);

x_S1 = zeros(3,length(beta1));
x_I1 = zeros(3,length(beta1));
x_R1 = zeros(3,length(beta1));

P2 = 0.55;
P = 0.6;



for ii = 1 : length(beta1)
    x_S = zeros(1,N);
    x_I = zeros(1,N);
    x_R = zeros(1,N);
    
    x_S(1,1) = 0.7;
    x_I(1,1) = 0.2;
    x_R(1,1) = 0.1;
    for jj = 1 : N
    
    %%
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P1(1,ii))*k - beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
        + lambda*x_R(1,jj) + (delta)*x_I(1,jj))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
        + beta*mu*x_I(1,jj)*x_R(1,jj)*(P1(1,ii)+P2-1)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(delta)*x_I(1,jj) + beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P1(1,ii))*k -beta*mu*x_I(1,jj)*x_R(1,jj)*(P1(1,ii)+P2-1)*k)*tt;
    
  
    %%
    end
    x_S1(1,ii) = x_S(1,N);
    x_I1(1,ii) = x_I(1,N);
    x_R1(1,ii) = x_R(1,N);
end

for ii = 1 : length(beta1)
    x_S = zeros(1,N);
    x_I = zeros(1,N);
    x_R = zeros(1,N);
    
    x_S(1,1) = 0.7;
    x_I(1,1) = 0.2;
    x_R(1,1) = 0.1;
    for jj = 1 : N
    
    %%
        x_S(1,jj + 1) = x_S(1,jj) + (-beta1(1,ii)*mu*x_I(1,jj)*x_S(1,jj)*(1-P)*k - beta1(1,ii)*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
        + lambda*x_R(1,jj) + (delta)*x_I(1,jj))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj)+ beta1(1,ii)*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
        + beta1(1,ii)*mu*x_I(1,jj)*x_R(1,jj)*(P+P2-1)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(delta)*x_I(1,jj) + beta1(1,ii)*mu*x_I(1,jj)*x_S(1,jj)*(1-P)*k -  beta1(1,ii)*mu*x_I(1,jj)*x_R(1,jj)*(P+P2-1)*k)*tt;
    
  
    %%
    end
    x_S1(2,ii) = x_S(1,N);
    x_I1(2,ii) = x_I(1,N);
    x_R1(2,ii) = x_R(1,N);
end

for ii = 1 : length(beta1)
    x_S = zeros(1,N);
    x_I = zeros(1,N);
    x_R = zeros(1,N);
    
    x_S(1,1) = 0.7;
    x_I(1,1) = 0.2;
    x_R(1,1) = 0.1;
    for jj = 1 : N
    
    %%
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P)*k - beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
        + lambda1(1,ii)*x_R(1,jj) + delta*x_I(1,jj))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda1(1,ii)*x_R(1,jj) + beta*mu*x_S(1,jj)*x_R(1,jj)*k*P2 ......
        + beta*mu*x_I(1,jj)*x_R(1,jj)*(P+P2-1)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-delta*x_I(1,jj) + beta*mu*x_I(1,jj)*x_S(1,jj)*(1-P)*k - beta*mu*x_I(1,jj)*x_R(1,jj)*(P+P2-1)*k)*tt;
    
  
    %%
    end
    x_S1(3,ii) = x_S(1,N);
    x_I1(3,ii) = x_I(1,N);
    x_R1(3,ii) = x_R(1,N);
end
figure(1)
hold on
plot(beta1,x_R1(1,:),'mo','LineStyle','-.','LineWidth',1);
plot(beta1,x_R1(2,:),'g+','LineStyle',':','LineWidth',1);
plot(beta1,x_R1(3,:),'rs','LineStyle','--','LineWidth',1);
%plot(utility,'black');
xlabel('参数值');
ylabel('R的概率');
legend('P','\beta','\lambda');
title("P、\beta、\lambda分别对R的影响");

figure(2)
hold on
% plot(beta1,x_I1(1,:),'r','LineStyle','-.','LineWidth',1,'g^','MarkSize',100,'LineWidth',3);
% plot(beta1,x_I1(2,:),'b','LineStyle',':','LineWidth',1,'co','MarkSize',100,'LineWidth',3);
% plot(beta1,x_I1(3,:),'g','LineStyle','--','LineWidth',1,'msquare','MarkSize',100,'LineWidth',3);


plot(beta1,x_I1(1,:),'mo','LineStyle','-.','LineWidth',1);
plot(beta1,x_I1(2,:),'g+','LineStyle',':','LineWidth',1);
plot(beta1,x_I1(3,:),'rs','LineStyle','--','LineWidth',1);

%plot(utility,'black');
xlabel('参数值');
ylabel('I的概率');
legend('P','\beta','\lambda');
title("P、\beta、\lambda分别对I的影响");




