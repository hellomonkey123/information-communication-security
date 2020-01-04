clc;
clear;

beta = 0.6;      % Receiving information probability
mu = 1;        % Communication probability;
lambda = 0.1;    % The probability of node losing their information
theta = 0.1;     % R states' node will not trust their recieved information
delta = 0.1;     % The probability of L node losing their information
gamma = 0.2;     % the node recieved information without transforming
tau = 0.6;       % L states' node checked rate

P1 = 0.46;
P2 = 0.50;

beta1 = 0.1:0.01:0.6;
gamma1 = 0.1:0.01:0.6;
tau1 = 0.1:0.01:0.6;
P11 = 0.1:0.01:0.6;
P22 = 0.1:0.01:0.6;


k = 1;

N = 30000;
T = 3;
tt = 0.01;

x_S = zeros(1,N);
x_I = zeros(1,N);
x_R = zeros(1,N);
x_LI = zeros(1,N);
x_LR = zeros(1,N);

x_S1 = zeros(5,length(beta1));
x_I1 = zeros(5,length(beta1));
x_R1 = zeros(5,length(beta1));
x_LI1 = zeros(5,length(beta1));
x_LR1 = zeros(5,length(beta1));

%utility = zeros(1,length(P_cost));
%P = zeros(length(P_cost),N);

%P(:,1) = 0.6;


%%
%  beta
for ii = 1 : length(beta1)
    x_S(1,1) = 0.6;
     x_I(1,1) = 0.1;
     x_R(1,1) = 0.1;
     x_LI(1,1) = 0.1;
     x_LR(1,1) = 0.1;
    for jj = 1 : N
        
      
%         theta = x_R(1,jj)/(x_R(1,jj)+x_I(1,jj));
        %P(1,jj) = log(1+x_I(1,jj)) + log10(1 + 3*P_cost(ii)/(10+P_cost(ii)));
        x_S(1,jj + 1) = x_S(1,jj) + (-beta1(1,ii)*mu*x_S(1,jj)*k*((x_I(1,jj)+x_R(1,jj))*gamma+(x_I(1,jj)*(1-P2)+x_R(1,jj)*P1)*(1-gamma)) ......
         + lambda*(x_I(1,jj) + x_R(1,jj)) + tau*(x_LR(1,jj)*(1-P1)+x_LI(1,jj)*P2)+delta*(x_LR(1,jj)+x_LI(1,jj)))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + P1*tau*x_LR(1,jj) + beta1(1,ii)*mu*x_S(1,jj)* x_R(1,jj)*k*P1*(1-gamma) ......
        + beta1(1,ii)*mu*x_I(1,jj)*x_R(1,jj)*P1*k- beta1(1,ii)*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) - beta1(1,ii)*mu*x_I(1,jj)*x_R(1,jj)*P1*k + (1-P2)*tau*x_LI(1,jj) ......
        +  beta1(1,ii)*mu*x_I(1,jj)*x_S(1,jj)*(1-gamma)*k*(1-P2)+ beta1(1,ii)*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_LR(1,jj + 1) = x_LR(1,jj) + (-(tau+delta)*x_LR(1,jj) + beta1(1,ii)*mu*x_S(1,jj)*gamma*k*(x_R(1,jj)))*tt;
        x_LI(1,jj + 1) = x_LI(1,jj) + (-(tau+delta)*x_LI(1,jj) + beta1(1,ii)*mu*x_S(1,jj)*gamma*k*(x_I(1,jj)))*tt;
    end
    x_S1(1,ii)=x_S(1,N);
    x_I1(1,ii)=x_I(1,N);
    x_R1(1,ii)=x_R(1,N);
    x_LI1(1,ii)=x_LI(1,N);
    x_LR1(1,ii)=x_LR(1,N);
end
    
 %% 
 
 %%
 %  gamma
 for ii = 1 : length(beta1)
     x_S(1,1) = 0.6;
     x_I(1,1) = 0.1;
     x_R(1,1) = 0.1;
     x_LI(1,1) = 0.1;
     x_LR(1,1) = 0.1;
    for jj = 1 : N
       
       
%         theta = x_R(1,jj)/(x_R(1,jj)+x_I(1,jj));
        %P(1,jj) = log(1+x_I(1,jj)) + log10(1 + 3*P_cost(ii)/(10+P_cost(ii)));
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_S(1,jj)*k*((x_I(1,jj)+x_R(1,jj))*gamma1(1,ii)+(x_I(1,jj)*(1-P2)+x_R(1,jj)*P1)*(1-gamma1(1,ii))) ......
         + lambda*(x_I(1,jj) + x_R(1,jj)) + tau*(x_LR(1,jj)*(1-P1)+x_LI(1,jj)*P2)+delta*(x_LR(1,jj)+x_LI(1,jj)))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + P1*tau*x_LR(1,jj) + beta*mu*x_S(1,jj)* x_R(1,jj)*k*P1*(1-gamma1(1,ii)) ......
        + beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k- beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) - beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k + (1-P2)*tau*x_LI(1,jj) ......
        +  beta*mu*x_I(1,jj)*x_S(1,jj)*(1-gamma1(1,ii))*k*(1-P2)+ beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_LR(1,jj + 1) = x_LR(1,jj) + (-(tau+delta)*x_LR(1,jj) + beta*mu*x_S(1,jj)*gamma1(1,ii)*k*(x_R(1,jj)))*tt;
        x_LI(1,jj + 1) = x_LI(1,jj) + (-(tau+delta)*x_LI(1,jj) + beta*mu*x_S(1,jj)*gamma1(1,ii)*k*(x_I(1,jj)))*tt;
    end
    x_S1(2,ii)=x_S(1,N);
    x_I1(2,ii)=x_I(1,N);
    x_R1(2,ii)=x_R(1,N);
    x_LI1(2,ii)=x_LI(1,N);
    x_LR1(2,ii)=x_LR(1,N);
end
    
 %% 
 
 %%
 % tau
 for ii = 1 : length(beta1)
     x_S(1,1) = 0.6;
     x_I(1,1) = 0.1;
     x_R(1,1) = 0.1;
     x_LI(1,1) = 0.1;
     x_LR(1,1) = 0.1;
    for jj = 1 : N
    
        
%         theta = x_R(1,jj)/(x_R(1,jj)+x_I(1,jj));
        %P(1,jj) = log(1+x_I(1,jj)) + log10(1 + 3*P_cost(ii)/(10+P_cost(ii)));
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_S(1,jj)*k*((x_I(1,jj)+x_R(1,jj))*gamma+(x_I(1,jj)*(1-P2)+x_R(1,jj)*P1)*(1-gamma)) ......
         + lambda*(x_I(1,jj) + x_R(1,jj)) + tau1(1,ii)*(x_LR(1,jj)*(1-P1)+x_LI(1,jj)*P2)+delta*(x_LR(1,jj)+x_LI(1,jj)))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + P1*tau1(1,ii)*x_LR(1,jj) + beta*mu*x_S(1,jj)* x_R(1,jj)*k*P1*(1-gamma) ......
        + beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k- beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) - beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k + (1-P2)*tau1(1,ii)*x_LI(1,jj) ......
        +  beta*mu*x_I(1,jj)*x_S(1,jj)*(1-gamma)*k*(1-P2)+ beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_LR(1,jj + 1) = x_LR(1,jj) + (-(tau1(1,ii)+delta)*x_LR(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_R(1,jj)))*tt;
        x_LI(1,jj + 1) = x_LI(1,jj) + (-(tau1(1,ii)+delta)*x_LI(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_I(1,jj)))*tt;
    end
    x_S1(3,ii)=x_S(1,N);
    x_I1(3,ii)=x_I(1,N);
    x_R1(3,ii)=x_R(1,N);
    x_LI1(3,ii)=x_LI(1,N);
    x_LR1(3,ii)=x_LR(1,N);
end
    
 %% 
 
 %%
 % P1
 for ii = 1 : length(beta1)
     x_S(1,1) = 0.6;
     x_I(1,1) = 0.1;
     x_R(1,1) = 0.1;
     x_LI(1,1) = 0.1;
     x_LR(1,1) = 0.1;
    for jj = 1 : N
    
       
%         theta = x_R(1,jj)/(x_R(1,jj)+x_I(1,jj));
        %P(1,jj) = log(1+x_I(1,jj)) + log10(1 + 3*P_cost(ii)/(10+P_cost(ii)));
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_S(1,jj)*k*((x_I(1,jj)+x_R(1,jj))*gamma+(x_I(1,jj)*(1-P2)+x_R(1,jj)*P11(1,ii))*(1-gamma)) ......
         + lambda*(x_I(1,jj) + x_R(1,jj)) + tau*(x_LR(1,jj)*(1-P11(1,ii))+x_LI(1,jj)*P2)+delta*(x_LR(1,jj)+x_LI(1,jj)))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + P11(1,ii)*tau*x_LR(1,jj) + beta*mu*x_S(1,jj)* x_R(1,jj)*k*P11(1,ii)*(1-gamma) ......
        + beta*mu*x_I(1,jj)*x_R(1,jj)*P11(1,ii)*k- beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) - beta*mu*x_I(1,jj)*x_R(1,jj)*P11(1,ii)*k + (1-P2)*tau*x_LI(1,jj) ......
        +  beta*mu*x_I(1,jj)*x_S(1,jj)*(1-gamma)*k*(1-P2)+ beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P2)*k)*tt;
        x_LR(1,jj + 1) = x_LR(1,jj) + (-(tau+delta)*x_LR(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_R(1,jj)))*tt;
        x_LI(1,jj + 1) = x_LI(1,jj) + (-(tau+delta)*x_LI(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_I(1,jj)))*tt;
    end
    x_S1(4,ii)=x_S(1,N);
    x_I1(4,ii)=x_I(1,N);
    x_R1(4,ii)=x_R(1,N);
    x_LI1(4,ii)=x_LI(1,N);
    x_LR1(4,ii)=x_LR(1,N);
end
 %% 
 
 %%
 % P2
 for ii = 1 : length(beta1)
     x_S(1,1) = 0.6;
     x_I(1,1) = 0.1;
     x_R(1,1) = 0.1;
     x_LI(1,1) = 0.1;
     x_LR(1,1) = 0.1;
    for jj = 1 : N
    
        
%         theta = x_R(1,jj)/(x_R(1,jj)+x_I(1,jj));
        %P(1,jj) = log(1+x_I(1,jj)) + log10(1 + 3*P_cost(ii)/(10+P_cost(ii)));
        x_S(1,jj + 1) = x_S(1,jj) + (-beta*mu*x_S(1,jj)*k*((x_I(1,jj)+x_R(1,jj))*gamma+(x_I(1,jj)*(1-P22(1,ii))+x_R(1,jj)*P1)*(1-gamma)) ......
         + lambda*(x_I(1,jj) + x_R(1,jj)) + tau*(x_LR(1,jj)*(1-P1)+x_LI(1,jj)*P22(1,ii))+delta*(x_LR(1,jj)+x_LI(1,jj)))*tt;
        x_R(1,jj + 1) = x_R(1,jj) + (-lambda*x_R(1,jj) + P1*tau*x_LR(1,jj) + beta*mu*x_S(1,jj)* x_R(1,jj)*k*P1*(1-gamma) ......
        + beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k- beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P22(1,ii))*k)*tt;
        x_I(1,jj + 1) = x_I(1,jj) + (-(lambda)*x_I(1,jj) - beta*mu*x_I(1,jj)*x_R(1,jj)*P1*k + (1-P22(1,ii))*tau*x_LI(1,jj) ......
        +  beta*mu*x_I(1,jj)*x_S(1,jj)*(1-gamma)*k*(1-P22(1,ii))+ beta*mu*x_I(1,jj)*x_R(1,jj)*(1-P22(1,ii))*k)*tt;
        x_LR(1,jj + 1) = x_LR(1,jj) + (-(tau+delta)*x_LR(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_R(1,jj)))*tt;
        x_LI(1,jj + 1) = x_LI(1,jj) + (-(tau+delta)*x_LI(1,jj) + beta*mu*x_S(1,jj)*gamma*k*(x_I(1,jj)))*tt;
    end
     
    x_S1(5,ii)=x_S(1,N);
    x_I1(5,ii)=x_I(1,N);
    x_R1(5,ii)=x_R(1,N);
    x_LI1(5,ii)=x_LI(1,N);
    x_LR1(5,ii)=x_LR(1,N);
end
    
 %% 
 


figure(1)
hold on
plot(beta1,x_R1(1,:),'mo','LineStyle','-.','LineWidth',1);
plot(beta1,x_R1(2,:),'g+','LineStyle',':','LineWidth',1);
plot(beta1,x_R1(3,:),'rs','LineStyle','--','LineWidth',1);
plot(beta1,x_R1(4,:),'cx','LineStyle','--','LineWidth',1);
plot(beta1,x_R1(5,:),'b*','LineStyle','--','LineWidth',1);
%plot(utility,'black');
xlabel('参数值','FontSize',12);
ylabel('R的概率','FontSize',12);
legend('\beta','\gamma','\tau','P_{R}','P_{I}');
title("\beta、\gamma、\tau、P_{R}、P_{I}分别对R的影响");


figure(2)
hold on
% plot(beta1,x_I1(1,:),'r','LineStyle','-.','LineWidth',1,'g^','MarkSize',100,'LineWidth',3);
% plot(beta1,x_I1(2,:),'b','LineStyle',':','LineWidth',1,'co','MarkSize',100,'LineWidth',3);
% plot(beta1,x_I1(3,:),'g','LineStyle','--','LineWidth',1,'msquare','MarkSize',100,'LineWidth',3);


plot(beta1,x_I1(1,:),'mo','LineStyle','-.','LineWidth',1);
plot(beta1,x_I1(2,:),'g+','LineStyle',':','LineWidth',1);
plot(beta1,x_I1(3,:),'rs','LineStyle','--','LineWidth',1);
plot(beta1,x_I1(4,:),'cx','LineStyle',':','LineWidth',1);
plot(beta1,x_I1(5,:),'b*','LineStyle','--','LineWidth',1);

%plot(utility,'black');
xlabel('参数值','FontSize',12);
ylabel('I的概率','FontSize',12);
legend('\beta','\gamma','\tau','P_{R}','P_{I}');
title("\beta、\gamma、\tau、P_{R}、P_{I}分别对I的影响",'FontSize',12);


