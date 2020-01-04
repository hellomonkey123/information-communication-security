clc;
clear;

c_v = 0.5;          % cost per unit time of vaccination
c_I = 36.5;  % cost per unit time of infection
rho = 36.5;

% time horizon
Period = 1;
h = 0.001;
T = 1000;  %c=t/h
t = linspace(0, T, T + 1);

% parameters to modify
gamma = 73;      % infection rate
tau_max = 10;    % maximum vaccination rate

% initial conditions
m_S = 0.75;
m_I = 0.1;
m_R = 0.15;

x_S = zeros(1,T + 1);
x_I = zeros(1,T + 1);
x_R = zeros(1,T + 1);

pi_t = zeros(1,T + 1);
my_pi_t = zeros(1,T + 1);

my_c = zeros(1,T + 1);


jj = 1;
for t_critical = 1:(T+1)
    x_S(1) = m_S;
    x_I(1) = m_I;
    
    for tt = 1:T
       if tt < t_critical
            pi_t(tt) = tau_max;
            my_pi_t(tt) = tau_max;
       else
            pi_t(tt) = 0;
            my_pi_t(tt) = 0;
       end
       x_S(tt + 1) = x_S(tt) + (-gamma * x_I(tt) * x_S(tt) - pi_t(tt) * x_S(tt)) * h;     
       x_I(tt + 1) = x_I(tt) + (gamma * x_I(tt) * x_S(tt) - rho * x_I(tt)) * h; 
    end
    
    my_c(jj) =  c_I * h * sum(1.*x_I)  + c_v * sum(x_S.* my_pi_t) * h;
    jj = jj + 1;
end

%说白了，就是在当前不之内不断打疫苗
%plot(v,'*');
% mymin = my_v(1);
% t_opt = 0;
% hold on
% 
% 
% for tt =1:(T + 1)
%     if my_v(tt) < mymin
%         mymin = my_v(tt);
%         t_opt = tt;
%     end
% end


mymin = min(my_c); 
t_opt = find(my_c==mymin); 
cost_opt = mymin;



% c_V=0.3;  %0.9895;
t_eq = equilibrium(c_v,h,T,m_S,m_I,tau_max,rho,gamma,c_I);

x_S(1) = m_S;
x_I(1) = m_I;

for tt = 1:T
    if tt < t_eq
        pi_t(tt) = tau_max;
        my_pi_t(tt) = tau_max;
    else
        pi_t(tt) = 0;
        my_pi_t(tt) = 0;
    end
    x_S(tt + 1) = x_S(tt) + (-gamma * x_I(tt) * x_S(tt) - pi_t(tt) * x_S(tt)) * h;
    x_I(tt + 1) = x_I(tt) + (gamma * x_I(tt) * x_S(tt) - rho * x_I(tt)) * h;
end
cost_eq =  c_I * h* sum(1.*x_I)  + c_v * sum(x_S.* my_pi_t) * h ;


figure; 
hold on
plot(x_S(1:10:tt),'mo','LineStyle','-','LineWidth',0.1);
plot(x_I(1:10:tt),'rx:','LineStyle','-','LineWidth',0.1);


% myplot_dynamics(t_eq,C,S1,I1,vac_max,beta,gamma,h);
