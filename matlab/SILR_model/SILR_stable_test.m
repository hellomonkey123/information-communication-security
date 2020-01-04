clear;
clc;

k = 1;
p = 0.8;
p_D = 0.8;

delta = 0.4;
beta = 0.3;
alpha = 0.2;
tau = 0.3;

P_R = p*p_D + (1 - p)*(1 - p_D);
P_I = 1 - P_R;

N1 = 15000;
t = 0.001;
%������Ҫ�����ǣ����մﵽ����̬��ת�Ʋ�������ֵ��ϵ
% beta_1= 0.1283;  
% beta_2= 0.1650;  %��������֤��������ѡȡ������ʹI����Ϊ����Ƿ����


x_S  =  zeros(2,N1+1);
x_I  =  zeros(2,N1+1);
x_R  =  zeros(2,N1+1);
x_L  =  zeros(2,N1+1);

x_S(1,1)  = 0.6;
x_I(1,1)  = 0.1;
x_R(1,1)  = 0.2;
x_L(1,1)  = 0.1;

for i = 1:N1
     x_S(1,i+1) = x_S(1,i) + (-(1 - x_S(1,i))*k*x_S(1,i) + tau*x_R(1,i) + delta*x_I(1,i))*t;
     x_L(1,i+1) = x_L(1,i) + (-(1 -beta)*x_L(1,i)*x_S(1,i)*k  + alpha*(1 - x_S(1,i))*k*x_S(1,i))*t;
     x_R(1,i+1) = x_R(1,i)+(-tau*x_R(1,i)- (1 - tau)*P_I*x_R(1,i)*x_S(1,i)*k + (1 -beta)*P_R*x_L(1,i)*x_S(1,i)*k ......
     + (1 - alpha)*P_R*(1 - x_S(1,i))*k*x_S(1,i) + (1 - delta)*P_R*x_I(1,i)*k*x_S(1,i))*t;
     x_I(1,i+1) = x_I(1,i)+(-delta*x_I(1,i)- (1 - delta)*P_R*x_I(1,i)*x_S(1,i)*k + (1 -tau)*P_I*x_R(1,i)*x_S(1,i)*k ......
     + (1 - alpha)*P_I*(1 - x_S(1,i))*k*x_S(1,i) + (1 - beta)*P_I*x_L(1,i)*k*x_S(1,i))*t;
end



figure(1)
hold on
plot(x_S(1,:),'r');
plot(x_R(1,:),'b');
plot(x_I(1,:),'g');
plot(x_L(1,:),'c');
xlabel('t');
ylabel('Probability');
legend('S�ĸ���','R�ĸ���','I�ĸ���','L�ĸ���');
title("SRIL����ɷ�̬�ݻ�");


% figure(2)
% hold on
% plot(x_S(1,:));
% %plot(x_S(2,:));
% title("�ȶ�S״̬��Ӱ��")
% 
% 
% figure(3)
% hold on
% plot(x_R(1,:));
% plot(x_R(2,:));
