clear;
clc;

% k = 6;
% a = 0.02;
% beta = 0.2;
% gamma = 0.4;
% delta2_1 = 0.3 ;
% delta2_2 = 0.5 ;
% N1 = 3000;
% t = 0.001;
% 
% delta1 = 0.1:0.001:0.7;
% 
% x_S  =  zeros(length(delta1),N1+1);
% x_I  =  zeros(length(delta1),N1+1);
% x_R  =  zeros(length(delta1),N1+1);
% 
% 
% for s = 1:length(delta1)
%     if beta<(gamma+delta2_1)*(a+delta1(s))/(k*delta1(s))
%         x_I(s,1)  =  0;
%     else
%         x_I(s,1) = (delta1(s)*beta*k-(gamma+delta2_1)*(a+delta1(s)))/(beta*k*(gamma+delta1(s)));
%         x_S(s,1) = (gamma+delta2_1)/(beta*k);
%         x_R(s,1) = 1-x_S(s,1)-x_I(s,1);
%     end
%     
% %     if beta(s)<(gamma+delta2_2)*(a+delta1)/(k*delta1)
% %         x_I(s,2)  =  0;
% %     else
% %         x_I(s,2) = (delta1*beta(s)*k-(gamma+delta2_2)*(a+delta1))/(beta(s)*k*(gamma+delta1));
% %         x_S(s,2) = (gamma+delta2_2)/(beta(s)*k);
% %         x_R(s,2) = 1-x_S(s,1)-x_I(s,1);
% %     end
% end

% for i = 1:N1
%      x_S(s,i+1) = x_S(s,i)+(-beta(s)*k*x_S(s,i)*x_I(s,i)-a*x_S(s,i)+delta1*x_R(s,i)+delta2*x_I(s,i))*t;  
%      x_I(s,i+1) = x_I(s,i)+(beta(s)*k*x_S(s,i)*x_I(s,i)-gamma*x_I(s,i)-delta2*x_I(s,i))*t;
%      x_R(s,i+1) = x_R(s,i)+(a*x_S(s,i)+gamma*x_I(s,i)-delta1*x_R(s,i))*t;
% end

k = 3;
P = 0.4;
alpha2 = 0.2:0.001:0.7;
beta2 = 0.4;
gamma2 = 0.2 ;

x_S  =  zeros(length(beta2),1);
x_I  =  zeros(length(beta2),1);
x_R  =  zeros(length(beta2),1);

for s = 1:length(beta2)
    
    a2 = P^3/(beta2(s*k)^2 + P;
    b2 = (2*gamma2*P^2 + alpha2(s)*P*beta2(s*k)/(beta2*k)^2 + alpha2(s);
    c2 = alpha2(s)*gamma2/(beta2*k) + P*gamma2^2/(beta2*k)^2 - alpha2(s);
    
    x_I(s,1) = (-b2+sqrt(b2^2-4*a2*c2))/(2*a2);
%     if(x_S(s,1) <= (-alpha+sqrt(alpha^2+4*P*alpha))/(2*P))
%         x_I(s) = 0;
%     else
        x_S(s,1) = (P*(-b2+sqrt(b2^2-4*a2*c2))/(2*a2) + gamma2)/(beta2*k);
%     end
end


figure(4)
hold on
plot(beta2,x_I(:,1));
xlabel('¦Â');
ylabel('I(x)');
%plot(beta,x_I(:,2));
title("¦Â¶ÔI×´Ì¬µÄÓ°Ïì")
 

