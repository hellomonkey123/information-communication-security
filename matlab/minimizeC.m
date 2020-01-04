clc;
clear;
c_V = 0.5;          % cost per unit time of vaccination
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
v = zeros(1,C + 1);
cvx_begin
variable my_policy(C);

t_eq = equilibrium(c_V,h,C,S1,I1,vac_max,gamma,beta,c_I);
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
 minimize  c_I * h* sum(1.*x_I)  + c_V * sum(x_S.* my_policy) * h;

