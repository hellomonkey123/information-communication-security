clear;
clc;

k = 6;
a = 0.1;
delta2 = 0.1:0.01:0.5;
delta1 = 0.5;
delta1_2 = 0.5;


gamma = 0.1;

delta2_1 = 0.05 ;
delta2_2 = 0.05 ;
m_0 = 3;
N1 = 30000;
t = 0.001;
%������Ҫ�����ǣ����մﵽ����̬��ת�Ʋ�������ֵ��ϵ
% beta_1= 0.1283;  
% beta_2= 0.1650;  %��������֤��������ѡȡ������ʹI����Ϊ����Ƿ����

beta = 0.2;
% beta_1= 0.6;  
% beta_2= 0.6;  %���﷢��������̬��ֵ�������кܴ󲻷���

x_S  =  zeros(length(delta2),N1+1);
x_I  =  zeros(length(delta2),N1+1);
x_R  =  zeros(length(delta2),N1+1);

x_S(:,1)  = 0.7;
x_I(:,1)  = 0.1;
x_R(:,1)  = 0.2;

for s = 1:length(delta2)
    for i = 1:N1
        x_S(s,i+1) = x_S(s,i)+(-beta*k*x_S(s,i)*x_I(s,i)-a*x_S(s,i)+delta1*x_R(s,i)+delta2(s)*x_I(s,i))*t;  
        x_I(s,i+1) = x_I(s,i)+(beta*k*x_S(s,i)*x_I(s,i)-gamma*x_I(s,i)-delta2(s)*x_I(s,i))*t;
        x_R(s,i+1) = x_R(s,i)+(a*x_S(s,i)+gamma*x_I(s,i)-delta1*x_R(s,i))*t;
    end
end
figure(1)
hold on
plot(delta2,x_I(:,30000));
title("delta2��I��Ӱ��")

figure(2)
hold on
plot(delta2,x_S(:,30000));
title("delta2��S��Ӱ��")



%%%%%%
% x_S(2,1)  = 0.6;
% x_I(2,1)  = 0.3;
% x_R(2,1)  = 0.1;
% 
% for i = 1:N1
%      x_S(2,i+1) = x_S(2,i)+(-beta_2*k*x_S(2,i)*x_I(2,i)-a_2*x_S(2,i)+delta1_2*x_R(2,i)+delta2_2*x_I(2,i))*t;  
%      x_I(2,i+1) = x_I(2,i)+(beta_2*k*x_S(2,i)*x_I(2,i)-gamma*x_I(2,i)-delta2_2*x_I(2,i))*t;
%      x_R(2,i+1) = x_R(2,i)+(a_2*x_S(2,i)+gamma*x_I(2,i)-delta1_2*x_R(2,i))*t;
% end
% 
% figure(1)
% hold on
% plot(x_I(1,:));
% plot(x_I(2,:));
% 
% 
% 
% figure(2)
% hold on
% plot(x_S(1,:));
% plot(x_S(2,:));
% title("delta1��S��Ӱ��")
% 
% 
% figure(3)
% hold on
% plot(x_R(1,:));
% plot(x_R(2,:));

