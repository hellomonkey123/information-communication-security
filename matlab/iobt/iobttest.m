clc;
clear;

k = [1 10 15 20];
C = [1 10 20 30];  %cost
Qt = k;  %target QoI
P = [0.4,0.3,0.2,0.1]; %distribution probabilities
lambda = 0.2;  %有点疑惑需不需要将其均分四等份
delta = [0 0.4 0.3 0.3];  %the delay of E and L
beta_E = [0.5 0.3 0.2 0.1];  %the acceptance probabilities (E)
beta_L = [0.5 0.6 0.7 0.8];  %the acceptance probabilities (L)
v = [0.1 0.1 0.1 0.1];
kappa = [0.3 0.3 0.3 0.3];

T = 0.9;   %time period
h = 0.001;

iter = 0;
alpha = ones(900,4)./10;
while(iter<16)
  
    R_ik = zeros(900,1);

    m_S = zeros(900,4);
    m_E = zeros(900,4);
    m_L = zeros(900,4);
    m_I = zeros(900,4);
    
    u_S = zeros(900,4);
    u_E = zeros(900,4);
    u_L = zeros(900,4);
    u_I = zeros(900,4);

%     alpha = ones(900,4).*alpha(900,:);
    
    m_S(1,:) = [1 1 1 1]; 
    
    for i = 1:899
        %此处有修改，待定
%         R_ik(i) = lambda+k.*(sum(k.*P.*m_I(i,:))./sum(k.*P));
        R_ik(i) = lambda+(sum(k.*P.*m_I(i,:))./sum(k.*P));
    
        m_S(i+1,:)=m_S(i,:)+(-(1-alpha(i,:)+alpha(i,:).*R_ik(i)).*m_S(i,:)+     ...
                  (1-delta).*(1-beta_E).*m_E(i,:)+(1-delta).*m_L(i,:)+v.*m_I(i,:)).*h; 
        m_E(i+1,:)=m_E(i,:)+(-(1-delta).*m_E(i,:)+(1-alpha(i,:)).*R_ik(i).*m_S(i,:)).*h;
        
        
        m_L(i+1,:)=m_L(i,:)+(-(1-delta).*m_L(i,:)+(1-alpha(i,:)).*(1-R_ik(i)).*m_S(i,:)).*h;
        m_I(i+1,:)=m_I(i,:)+(alpha(i,:).*R_ik(i).*m_S(i,:)+(1-delta).*beta_E.*m_E(i,:)-v.*m_I(i,:)).*h;   
        %最后后面输出m_I对应后面三个k值的值过高基本上是由于alpha过高的原因
    end
    %此处有修改
%     R_ik(900,:) = lambda+k.*(sum(k.*P.*m_I(900,:))./sum(k.*P)); %theta到底应该怎么处理
%     theta = sum((R_ik-lambda)./k,2)./4;

    R_ik(900) = lambda+(sum(k.*P.*m_I(900,:))./sum(k.*P));
    theta = R_ik-lambda;
    eta = sum(k.*P.*m_S,2)./sum(k.*P);  %对行求和
    
    
    E_Q = alpha.*(1-R_ik).*(k.*eta+1)+alpha.*(k.*eta-k.*theta-lambda-(1-lambda).*k.*eta)    ...
          +(1-alpha).*(1-R_ik).*(beta_L.*(k.*eta+1-kappa.*delta))     ...
          +(1-alpha).*(beta_E.*(k.*eta-k.*theta-lambda-(1-lambda).*k.*eta-kappa.*delta.*R_ik));
      
    u = (E_Q-Qt).^2;
    
    min_u = m_S.*u + m_I.*C;
    
    for i = 900:-1:2
        u_S(i-1,:)=u_S(i,:)+((1-alpha(i,:)).*R_ik(i).*(u_E(i,:)-u_S(i,:))+(1-alpha(i,:)).*  ...
                  (1-R_ik(i)).*(u_L(i,:)-u_S(i,:))+alpha(i,:).*R_ik(i).*(u_I(i,:)-u_S(i,:))).*h;
        u_E(i-1,:)=u_E(i,:)+((1-delta).*beta_E.*(u_I(i,:)-u_E(i,:))+(1-delta).*(1-beta_E).*(u_S(i,:)-u_E(i,:))).*h;
        u_L(i-1,:)=u_L(i,:)+((1-delta).*(u_S(i,:)-u_L(i,:))).*h;
        u_I(i-1,:)=u_I(i,:)+(C+v.*(u_S(i,:)-u_I(i,:))).*h;
    end
    
    A1 = (1-R_ik).*(k.*eta+1)+(k.*eta-k.*theta-lambda-(1-lambda).*k.*eta)-     ...
          (1-R_ik).*beta_L.*(k.*eta+1-kappa.*delta)      ...
          -beta_E.*(k.*eta-k.*theta-lambda-(1-lambda).*k.*eta-kappa.*delta).*R_ik;
      
    A2 = (1-R_ik).*(beta_L.*(k.*eta+1-kappa.*delta))+    ...
          beta_E.*(k.*eta-k.*theta-lambda-(1-lambda).*k.*eta-kappa.*delta).*R_ik;
    
    alpha = (R_ik.*(u_E-u_S)+(1-R_ik).*(u_L-u_S)-R_ik.*(u_I-u_S)+2.*A1.*(Qt-A2))./(2.*A1.^2);
    for i = 1:900
        for j = 1:4
            if(alpha(i,j)<0)
                alpha(i,j)=0;
            elseif(alpha(i,j)>1)
                alpha(i,j)=1;
            else
                alpha(i,j)=alpha(i,j);
            end
        end
    end
    iter=iter+1;
end

plot(E_Q-Qt);

