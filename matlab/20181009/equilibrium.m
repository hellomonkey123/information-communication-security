
function thr=equilibrium(c_v,h,C,S1,I1,vac_max,gamma,beta,c_I)
    %if C < max(beta, gamma, vac_max)
   %     return ;
    %end
    t_critical = 3;  % randint(0,C);任意给一个初值，只要不离谱就行
    thr = 0;
    res_a = zeros(1,C+1);
    while t_critical ~= thr
        x_S = zeros(1,C + 1);
        x_I = zeros(1,C + 1);
        my_policy = zeros(1,C + 1);
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
        J_s = zeros(1,C + 1);
        J_i = zeros(1,C + 1);
        J_r = zeros(1,C + 1);
%         J_v = zeros(1,C + 1);
        
        for count = 1:C
            t_ = C - count+2;
            slope = c_v - J_s(t_);
            if slope < 0  %p3.3
                res_a(t_) = vac_max; 
            else
                res_a(t_) = 0;
            end
            p_s_s = 1 - 1. * beta * x_I(t_ - 1) * h - 1. *res_a(t_)* h;
            p_s_i = 1. * beta * x_I(t_ - 1) * h;
            J_s(t_ - 1) = res_a(t_)* c_v * h + p_s_s * J_s(t_) + p_s_i * J_i(t_);
            p_i_s = 0;
            p_i_i = 1 - gamma * h;
            J_i(t_ - 1) = c_I * h + p_i_s * J_s(t_) + p_i_i * J_i(t_);%中间J_s部分为零
            J_r(t_ - 1) = J_r(t_);
           % J_v(t_ - 1) = J_v(t_);这里并没有应用到V状态的模型
        end
        for i = 1:(C+1)
            if J_s(i) <= c_v
                thr = i;
                break;
            end
        end 
        if t_critical > thr
            t_critical = t_critical - 1;
        end
        if t_critical < thr
            t_critical = t_critical + 1;
        end
    end
%     plot(J_s);
    