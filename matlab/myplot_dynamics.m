function myplot_dynamics(myt,C,S1,I1,vac_max,beta,gamma,h)

my_policy = zeros(1,C);
x_S = zeros(1,C);
x_I = zeros(1,C);
x_S(1) = S1;
x_I(1) = I1;
for i=1:C
    if i < myt
            myvac = vac_max;
            my_policy(i) = vac_max;
    else
        myvac = 0;
        my_policy(i) = 0;
    end
    x_S(i + 1) = x_S(i) + (-beta * x_I(i) * x_S(i) - myvac * x_S(i)) * h;
    x_I(i + 1) = x_I(i) + (beta * x_I(i) * x_S(i) - gamma * x_I(i)) * h;
end
%plot haven't written here

hold on
plot(x_S(1:10:i),'mo','LineStyle','-','LineWidth',0.1);
plot(x_I(1:10:i),'rx:','LineStyle','-','LineWidth',0.1);
return 
