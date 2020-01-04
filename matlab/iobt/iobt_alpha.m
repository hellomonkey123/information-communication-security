clc;
clear;

k = [1 10 15 20];
C = [1 10 20 30];  %cost
Qt = k;  %target QoI
P = [0.4,0.3,0.2,0.1]; %distribution probabilities
lambda = 0.2;  %有点疑惑需不需要将其均分四等份
delta = [0 0.02 0.1 0.1];  %the delay of E and L
beta_E = [0.5 0.3 0.2 0.1];  %the acceptance probabilities (E)
beta_L = [0.5 0.6 0.7 0.8];  %the acceptance probabilities (L)
v = [0.4 0.3 0.3 0.3];
kappa = [0.3 0.3 0.3 0.3];

T = 5;   %time period
h = 0.001;
Num = 60000;

iter = 0;
alpha = ones(Num,4)./10;
% load('alpha.mat');   %alpha设置的为论文里面数字


R_ik = zeros(Num,1);
m_S = zeros(Num,4);
m_E = zeros(Num,4);
m_L = zeros(Num,4);
m_I = zeros(Num,4);
% m_S(1,:) = [1 1 1 1]; 
m_S(1,:) = [0.9 0.9 0.9 0.9];
m_I(1,:) = [0.1 0.1 0.1 0.1];    
    for i = 1:Num-1
        %此处有修改，待定
%         R_ik(i) = lambda+k.*(sum(k.*P.*m_I(i,:))./sum(k.*P));
        R_ik(i) = lambda+(sum(k.*P.*m_I(i,:))./sum(k.*P)); %
    
        m_S(i+1,:)=m_S(i,:)+(-(1-alpha(i,:)+alpha(i,:).*R_ik(i)).*m_S(i,:)+     ...
                  (1-delta).*(1-beta_E).*m_E(i,:)+(1-delta).*m_L(i,:)+v.*m_I(i,:)).*h; 
        m_E(i+1,:)=m_E(i,:)+(-(1-delta).*m_E(i,:)+(1-alpha(i,:)).*R_ik(i).*m_S(i,:)).*h;
        
        
        m_L(i+1,:)=m_L(i,:)+(-(1-delta).*m_L(i,:)+(1-alpha(i,:)).*(1-R_ik(i)).*m_S(i,:)).*h;
        m_I(i+1,:)=m_I(i,:)+(alpha(i,:).*R_ik(i).*m_S(i,:)+(1-delta).*beta_E.*m_E(i,:)-v.*m_I(i,:)).*h;   
        %最后后面输出m_I对应后面三个k值的值过高基本上是由于alpha过高的原因
    end
    figure(1)
    plot(m_I);
    figure(2)
    plot(m_S);
    figure(3)
    plot(m_E);
    figure(4)
    plot(m_L);
%     figure(5)
%     plot(R_ik);
    
    
    
    
    
    