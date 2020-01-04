clear;
clc;

% k = 6;
% a = 0.02;
% % delta1 = 0.2;
% % beta = 0.4;
% delta2_1 = 0.3 ;
% delta2_2 = 0.5 ;
% N1 = 3000;
% t = 0.001;

% gamma = 0.2:0.001:0.7;

% x_S  =  zeros(length(gamma),1);
% x_I  =  zeros(length(gamma),1);
% x_R  =  zeros(length(gamma),1);

% %improved 论文仿真代码%%
% for s = 1:length(gamma)
%     if beta<(gamma(s)+delta2_1)*(a+delta1)/(k*delta1)
%         x_I(s,1)  =  0;
%     else
%         x_I(s,1) = (delta1*beta*k-(gamma(s)+delta2_1)*(a+delta1))/(beta*k*(gamma(s)+delta1));
%         x_S(s,1) = (gamma(s)+delta2_1)/(beta*k);
%         x_R(s,1) = 1-x_S(s,1)-x_I(s,1);
%     end
% %     
% %     if beta(s)<(gamma+delta2_2)*(a+delta1)/(k*delta1)
% %         x_I(s,2)  =  0;
% %     else
% %         x_I(s,2) = (delta1*beta(s)*k-(gamma+delta2_2)*(a+delta1))/(beta(s)*k*(gamma+delta1));
% %         x_S(s,2) = (gamma+delta2_2)/(beta(s)*k);
% %         x_R(s,2) = 1-x_S(s,1)-x_I(s,1);
% %     end
% end

% a = 0.02;
k = 3;
P = 0.4;
alpha = 0.4;
beta = 0.4;
gamma = 0.2:0.001:0.7 ;

alpha1 = 0.4;
beta1 = 0.2:0.001:0.7;
gamma1 = 0.2 ;

alpha2 = 0.2:0.001:0.7;
beta2 = 0.4;
gamma2 = 0.4 ;

x_S  =  zeros(length(gamma),3);
x_I  =  zeros(length(gamma),3);

for s = 1:length(gamma)
    
    a = P^3/(beta*k)^2 + P;
    b = (2*gamma(s)*P^2 + alpha*P*beta*k)/(beta*k)^2 + alpha;
    c = alpha*gamma(s)/(beta*k) + P*gamma(s)^2/(beta*k)^2 - alpha;
    
    x_I(s,1) = (-b+sqrt(b^2-4*a*c))/(2*a);
%     if(x_S(s,1) <= (-alpha+sqrt(alpha^2+4*P*alpha))/(2*P))
%         x_I(s) = 0;
%     else
        x_S(s,1) = (P*(-b+sqrt(b^2-4*a*c))/(2*a) + gamma(s))/(beta*k);
%     end

    a1 = P^3/(beta1(s)*k)^2 + P;
    b1 = (2*gamma1*P^2 + alpha1*P*beta1(s)*k)/(beta1(s)*k)^2 + alpha1;
    c1 = alpha1*gamma1/(beta1(s)*k) + P*gamma1^2/(beta1(s)*k)^2 - alpha1;
    
    x_I(s,2) = (-b1+sqrt(b1^2-4*a1*c1))/(2*a1);
%     if(x_S(s,1) <= (-alpha+sqrt(alpha^2+4*P*alpha))/(2*P))
%         x_I(s) = 0;
%     else
        x_S(s,2) = (P*(-b1+sqrt(b1^2-4*a1*c1))/(2*a1) + gamma1)/(beta1(s)*k);
%     end

    a2 = P^3/(beta2*k)^2 + P;
    b2 = (2*gamma2*P^2 + alpha2(s)*P*beta2*k)/(beta2*k)^2 + alpha2(s);
    c2 = alpha2(s)*gamma2/(beta2*k) + P*gamma2^2/(beta2*k)^2 - alpha2(s);
    
    x_I(s,3) = (-b2+sqrt(b2^2-4*a2*c2))/(2*a2);
%     if(x_S(s,1) <= (-alpha+sqrt(alpha^2+4*P*alpha))/(2*P))
%         x_I(s) = 0;
%     else
        x_S(s,3) = (P*(-b2+sqrt(b2^2-4*a2*c2))/(2*a2) + gamma2)/(beta2*k);
%     end
end


figure(4)
hold on
plot(gamma,x_I(:,1),'r');
plot(gamma,x_I(:,2),'b');
plot(gamma,x_I(:,3),'g');


xlabel('参数');
ylabel('I (x)');
legend('γ对I状态的影响','β对I状态的影响','α对I状态的影响');
%plot(beta,x_I(:,2));
title("不同参数对I状态的影响")

figure(5)
hold on
plot(gamma,x_S(:,1),'r');
plot(gamma,x_S(:,2),'b');
plot(gamma,x_S(:,3),'g');


xlabel('参数');
ylabel('S (x)');
legend('γ对S状态的影响','β对S状态的影响','α对S状态的影响');
%plot(beta,x_I(:,2));
title("不同参数对S状态的影响")
 

