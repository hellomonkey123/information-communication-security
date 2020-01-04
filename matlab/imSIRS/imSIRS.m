clear;
clc;

k = 6;
a = 0.02;
delta1 = 0.2;
gamma = 0.4;
delta2_1 = 0.3 ;
delta2_2 = 0.5 ;
N1 = 3000;
t = 0.001;

beta = 0.2:0.001:0.7;

x_S  =  zeros(length(beta),N1+1);
x_I  =  zeros(length(beta),N1+1);
x_R  =  zeros(length(beta),N1+1);


for s = 1:length(beta)
    if beta(s)<(gamma+delta2_1)*(a+delta1)/(k*delta1)
        x_I(s,1)  =  0;
    else
        x_I(s,1) = (delta1*beta(s)*k-(gamma+delta2_1)*(a+delta1))/(beta(s)*k*(gamma+delta1));
        x_S(s,1) = (gamma+delta2_1)/(beta(s)*k);
        x_R(s,1) = 1-x_S(s,1)-x_I(s,1);
    end
    
    if beta(s)<(gamma+delta2_2)*(a+delta1)/(k*delta1)
        x_I(s,2)  =  0;
    else
        x_I(s,2) = (delta1*beta(s)*k-(gamma+delta2_2)*(a+delta1))/(beta(s)*k*(gamma+delta1));
        x_S(s,2) = (gamma+delta2_2)/(beta(s)*k);
        x_R(s,2) = 1-x_S(s,1)-x_I(s,1);
    end
end

% for i = 1:N1
%      x_S(s,i+1) = x_S(s,i)+(-beta(s)*k*x_S(s,i)*x_I(s,i)-a*x_S(s,i)+delta1*x_R(s,i)+delta2*x_I(s,i))*t;  
%      x_I(s,i+1) = x_I(s,i)+(beta(s)*k*x_S(s,i)*x_I(s,i)-gamma*x_I(s,i)-delta2*x_I(s,i))*t;
%      x_R(s,i+1) = x_R(s,i)+(a*x_S(s,i)+gamma*x_I(s,i)-delta1*x_R(s,i))*t;
% end

figure(4)
hold on
plot(beta,x_I(:,1));
xlabel('¦Â');
ylabel('I (x)');
%plot(beta,x_I(:,2));
title("¦Â¶ÔI×´Ì¬µÄÓ°Ïì")
 

