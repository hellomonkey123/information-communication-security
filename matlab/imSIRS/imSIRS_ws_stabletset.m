clear;
clc;

k = 6;
a_1 = 0.1;
a_2 = 0.1;
delta1_1 = 0.3;
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

beta_1= 0.6;  
beta_2= 0.6;  %���﷢��������̬��ֵ�������кܴ󲻷���

x_S  =  zeros(2,N1+1);
x_I  =  zeros(2,N1+1);
x_R  =  zeros(2,N1+1);

x_S(1,1)  = 0.7;
x_I(1,1)  = 0.1;
x_R(1,1)  = 0.2;

for i = 1:N1
     x_S(1,i+1) = x_S(1,i)+(-beta_1*k*x_S(1,i)*x_I(1,i)-a_1*x_S(1,i)+delta1_1*x_R(1,i)+delta2_1*x_I(1,i))*t;  
     x_I(1,i+1) = x_I(1,i)+(beta_1*k*x_S(1,i)*x_I(1,i)-gamma*x_I(1,i)-delta2_1*x_I(1,i))*t;
     x_R(1,i+1) = x_R(1,i)+(a_1*x_S(1,i)+gamma*x_I(1,i)-delta1_1*x_R(1,i))*t;
end

x_S(2,1)  = 0.6;
x_I(2,1)  = 0.3;
x_R(2,1)  = 0.1;

for i = 1:N1
     x_S(2,i+1) = x_S(2,i)+(-beta_2*k*x_S(2,i)*x_I(2,i)-a_2*x_S(2,i)+delta1_2*x_R(2,i)+delta2_2*x_I(2,i))*t;  
     x_I(2,i+1) = x_I(2,i)+(beta_2*k*x_S(2,i)*x_I(2,i)-gamma*x_I(2,i)-delta2_2*x_I(2,i))*t;
     x_R(2,i+1) = x_R(2,i)+(a_2*x_S(2,i)+gamma*x_I(2,i)-delta1_2*x_R(2,i))*t;
end

figure(1)
hold on
plot(x_I(1,:));
plot(x_I(2,:));



figure(2)
hold on
plot(x_S(1,:));
%plot(x_S(2,:));
title("�ȶ�S״̬��Ӱ��")


figure(3)
hold on
plot(x_R(1,:));
plot(x_R(2,:));

