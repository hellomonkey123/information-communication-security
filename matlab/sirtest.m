clc;
clear;
c_v = 0.5;          % cost per unit time of vaccination
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
I1 = 0.1;

x_S = zeros(1,C + 1);
x_I = zeros(1,C + 1);
my_policy = zeros(1,C + 1);
v = zeros(1,C + 1);

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
    end
    v(j) =  c_I * h* sum(1.*x_I)  + c_v * sum(x_S.* my_policy) * h;
    j = j + 1;
end
%说白了，就是在当前不之内不断打疫苗
%plot(v,'*');
mymin = v(1);
t_opt = 0;
hold on


for i =1:(C + 1)
    if v(i) < mymin
        mymin = v(i);
        t_opt = i;
    end
end

cost_opt = mymin;

% c_V=0.3;  %0.9895;
t_eq = equilibrium(c_v,h,C,S1,I1,vac_max,gamma,beta,c_I);
x_S(1) = S1;
x_I(1) = I1;

for i = 1:C
    if i < t_eq
        myvac = vac_max;
        my_policy(i) = vac_max;
    else
        myvac = 0;
        my_policy(i) = 0;
    end
    x_S(i + 1) = x_S(i) + (-beta * x_I(i) * x_S(i) - myvac * x_S(i)) * h;
    x_I(i + 1) = x_I(i) + (beta * x_I(i) * x_S(i) - gamma * x_I(i)) * h;
end
cost_eq =  c_I * h* sum(1.*x_I)  + c_v * sum(x_S.* my_policy) * h ;

hold on
plot(x_S(1:10:i),'mo','LineStyle','-','LineWidth',0.1);
plot(x_I(1:10:i),'rx:','LineStyle','-','LineWidth',0.1);


% myplot_dynamics(t_eq,C,S1,I1,vac_max,beta,gamma,h);
