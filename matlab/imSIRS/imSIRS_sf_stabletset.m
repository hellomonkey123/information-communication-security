clear;
clc;

P = 0.4;
m_0 = 3;

delta1 = 0.3;
% a = 0.1;
% gamma = 0.1;
delta2_1 = 0.05 ;
delta2_2 = 0.15 ;
N1 =70000;
t = 0.001;
%接下来要做的是，最终达到的稳态和转移参数的数值关系
beta_1= 0.1283;  
beta_2= 0.1650;

% beta= 0:0.001:0.1;  
% 
% x_S  =  zeros(length(beta),N1+1);
% x_I  =  zeros(length(beta),N1+1);
% x_R  =  zeros(length(beta),N1+1);

% 
% for s = 1:length(beta)
%     
%     x_I(s,1) = 2.*delta1./((delta1 + gamma).* (exp((a+delta1).*(delta2_1+gamma)./(m_0.*delta1.*beta(s)))-1) .* ...
%     (1-(a+delta1).*(delta2_1+gamma)./((m_0.*delta1.*beta(s)).*(exp((a+delta1).*(delta2_1+gamma)./(m_0.*delta1.*beta(s)))-1))));
% 
%     x_I(s,2) = 2.*delta1./((delta1 + gamma).* (exp((a+delta1).*(delta2_2+gamma)./(m_0.*delta1.*beta(s)))-1) .* ...
%     (1-(a+delta1).*(delta2_2+gamma)./((m_0.*delta1.*beta(s)).*(exp((a+delta1).*(delta2_2+gamma)./(m_0.*delta1.*beta(s)))-1))));
% 
% end
% 
% figure(1)
% hold on
% plot(beta,x_I(:,1));
% plot(beta,x_I(:,2));



x_S(1,1)  = 0.7;
x_I(1,1)  = 0.1;
x_R(1,1)  = 0.2;

for i = 1:N1
    a = P * x_S(1,i);
    gamma = P * x_I(1,i);
    
     x_S(1,i+1) = x_S(1,i)+(-beta_1*m_0*x_S(1,i)*x_I(1,i)-a*x_S(1,i)+delta1*x_R(1,i)+delta2_1*x_I(1,i))*t;  
     x_I(1,i+1) = x_I(1,i)+(beta_1*m_0*x_S(1,i)*x_I(1,i)-gamma*x_I(1,i)-delta2_1*x_I(1,i))*t;
     x_R(1,i+1) = x_R(1,i)+(a*x_S(1,i)+gamma*x_I(1,i)-delta1*x_R(1,i))*t;
end

x_S(2,1)  = 0.6;
x_I(2,1)  = 0.3;
x_R(2,1)  = 0.1;

for i = 1:N1
     x_S(2,i+1) = x_S(2,i)+(-beta_2*m_0*x_S(2,i)*x_I(2,i)-a*x_S(2,i)+delta1*x_R(2,i)+delta2_2*x_I(2,i))*t;  
     x_I(2,i+1) = x_I(2,i)+(beta_2*m_0*x_S(2,i)*x_I(2,i)-gamma*x_I(2,i)-delta2_2*x_I(2,i))*t;
     x_R(2,i+1) = x_R(2,i)+(a*x_S(2,i)+gamma*x_I(2,i)-delta1*x_R(2,i))*t;
end

figure(1)
hold on
plot(x_I(1,:));
plot(x_I(2,:));


figure(2)
hold on
plot(x_S(1,:));
plot(x_S(2,:));


figure(3)
hold on
plot(x_R(1,:));
plot(x_R(2,:));


figure(4)
hold on
plot(x_I(1,:),'r');
plot(x_S(1,:),'b');
plot(x_R(1,:),'g');
xlabel('t');
ylabel('Probability');
legend('I的概率','S的概率','C的概率');
title("SIC马尔可夫动态演化");
