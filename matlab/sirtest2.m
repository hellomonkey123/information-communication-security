clc;
clear;
c_v = 0.01:0.002:1.2;          % cost per unit time of vaccination
c_I = 36.5;  % cost per unit time of infection
gamma = 36.5;

% time horizon
T = 1;
h = 0.001;
C = 1000;%c=t/h
t = linspace(1, T, C + 1);

% parameters to modify
beta = 73;  % infection rate
vac_max = 10;  % maximum vaccination rate

% initial conditions
S1 = 0.75;
I1 = 0.10;

x_S = zeros(1,C + 1);
x_I = zeros(1,C + 1);
my_policy = zeros(1,C + 1);
v = zeros(1,C + 1);

t_opt =zeros(1,length(c_v));
t_eq =zeros(1,length(c_v));

for s=1:length(c_v)
    j = 1;
    for t_critical = 1:(C+1)
        x_S(1) = S1;
        x_I(1) = I1;

        for i = 1:C
            if i < t_critical
                myvac = vac_max;
                my_policy(i) = vac_max;
            else
                myvac = 0;
                my_policy(i) = 0;
            end
            x_S(i + 1) = x_S(i) + (-beta * x_I(i) * x_S(i) - myvac * x_S(i)) * h;
            x_I(i + 1) = x_I(i) + (beta * x_I(i) * x_S(i) - gamma * x_I(i)) * h;
%             tmp(i+1) = c_I *abs(beta * x_I(i) * x_S(i) - gamma * x_I(i)) + c_v(s) *abs(beta * x_I(i) * x_S(i) + myvac * x_S(i))*my_policy(i);
        end
        v(j) =  c_I * h* sum(x_I)  + c_v(s) * sum(x_S.* my_policy) * h;
%         v(j) = sum(tmp)*h;
        j = j + 1;
    end
    %说白了，就是在当前不之内不断打疫苗
    %plot(v,'*');
    mymin = v(1);
  
    
    
    for i =1:(C + 1)
        if v(i) <= mymin
            mymin = v(i);
            t_opt(s) = i/1000;
        end
    end

    % c_V=0.3;  %0.9895;
    t_eq(s) = equilibrium(c_v(s),h,C,S1,I1,vac_max,gamma,beta,c_I)./1000;
end
figure
hold on
plot(c_v,t_opt,'-');
plot(c_v,t_eq,'-');
