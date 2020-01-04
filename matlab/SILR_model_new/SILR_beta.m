clear;
clc;

k = 6;
p = 0.6;
p_D = 0.6;

delta = 0.2;
beta = 0.2:0.001:0.9;
alpha = 0.2;
tau = 0.3;

P_R = p*p_D + (1 - p)*(1 - p_D);
P_I = 1 - P_R;

N1 = 40000;
t = 0.001;
%������Ҫ�����ǣ����մﵽ����̬��ת�Ʋ�������ֵ��ϵ
% beta_1= 0.1283;  
% beta_2= 0.1650;  %��������֤��������ѡȡ������ʹI����Ϊ����Ƿ����


x_S  =  zeros(length(beta),N1+1);
x_I  =  zeros(length(beta),N1+1);
x_R  =  zeros(length(beta),N1+1);
x_L  =  zeros(length(beta),N1+1);

x_S(:,1)  = 0.6;
x_I(:,1)  = 0.1;
x_R(:,1)  = 0.2;
x_L(:,1)  = 0.1;
for j = 1:length(beta)
    for i = 1:N1
        x_S(j,i+1) = x_S(j,i) + (-(1 - x_S(j,i))*k*x_S(j,i) + tau*x_R(j,i) + delta*x_I(j,i))*t;
        x_L(j,i+1) = x_L(j,i) + (-(1 -beta(j))*x_L(j,i)*x_S(j,i)*k  + alpha*(1 - x_S(j,i))*k*x_S(j,i))*t;
        x_R(j,i+1) = x_R(j,i)+(-tau*x_R(j,i) + (1 -beta(j))*P_R*x_L(j,i)*x_S(j,i)*k ......
        + (1 - alpha)*P_R*(1 - x_S(j,i))*k*x_S(j,i))*t;
        x_I(j,i+1) = x_I(j,i)+(-delta*x_I(j,i) ......
        + (1 - alpha)*P_I*(1 - x_S(j,i))*k*x_S(j,i) + (1 - beta(j))*P_I*x_L(j,i)*k*x_S(j,i))*t;
    end
end



figure(1)
hold on
plot(x_S(:,40000),'r');
plot(x_R(:,40000),'b');
plot(x_I(:,40000),'g');
plot(x_L(:,40000),'y');
xlabel('t');
ylabel('Probability');
legend('S�ĸ���','R�ĸ���','I�ĸ���','L�ĸ���');
title("�¶�SRIL�����ɷ�̬�ݻ���Ӱ��");


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