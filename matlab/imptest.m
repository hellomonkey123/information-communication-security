clc;
clear;
dt = 0.2;
ar = 0.5;
pt = 0.5;
ga = 0.1;
en = 0.5;
ts1 = 0.01;
ts2 = 0.01;
ru = 0.5;
th = 0.1;
dz = 0.4;
k = 4;
u = 0.0002;     %simplify the variable
%set above values of those variables

T = 3;
h = 0.001;
C = 3000;%c=t/h
t = linspace(1, T, C + 1);
%time horizon

x_s = zeros(1,C);
x_l = zeros(1,C);
x_i = zeros(1,C);
x_r = zeros(1,C);

x_s(1) = 0.7;
x_l(1) = 0.00001;
x_i(1) = 0.29998;
x_r(1) = 0.00001;

for i = 1:C+1
    if rem(i,k) ~= 0
        x_s(i+1) = x_s(i)+(dt-(ar+pt+ga)*u*x_i(i)*x_s(i)+en*x_r(i)-dt*x_s(i))*h;
        x_l(i+1) = x_l(i)+(ar*u*x_s(i)*x_i(i)-(ru+th+dt)*x_l(i))*h;
        x_i(i+1) = x_i(i)+(pt*u*x_s(i)*x_i(i)+ru*x_l(i)-(dz+dt)*x_i(i))*h;
        x_r(i+1) = x_r(i)+(ru*u*x_s(i)*x_i(i)+th*x_l(i)+dz*x_i(i)-(en+dt)*x_r(i))*h;
    else
        x_s(i+1) = (1-ts1)*x_s(i);
        x_l(i+1) = x_l(i);
        x_i(i+1) = (1-ts2)*x_i(i);
        x_r(i+1) = x_r(i)+ts1*x_s(i)+ts2*x_i(i);
    end
end
hold on
plot(x_s,'mo','LineWidth',0.1);
plot(x_l,'rx:','LineWidth',0.1);
plot(x_i,'*','LineWidth',0.1);
plot(x_r,'^','LineWidth',0.1);

    
