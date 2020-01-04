    clear;
    clc;

    k = 1;
    p = 0.6;
    p_D = 0.2:0.001:0.9;

    delta = 0.2;
    beta = 0.3;
    alpha = 0.2;
    tau = 0.3;

    P_R = p.*p_D + (1 - p).*(1 - p_D);
    P_I = 1 - P_R;

    N1 = 40000;
    t = 0.001;
    %接下来要做的是，最终达到的稳态和转移参数的数值关系
    % beta_1= 0.1283;  
    % beta_2= 0.1650;  %这里是验证论文里面选取的两个使I最终为零的是否成立


    x_S  =  zeros(length(p_D),N1+1);
    x_I  =  zeros(length(p_D),N1+1);
    x_R  =  zeros(length(p_D),N1+1);
    x_L  =  zeros(length(p_D),N1+1);

    x_S(:,1)  = 0.6;
    x_I(:,1)  = 0.1;
    x_R(:,1)  = 0.2;
    x_L(:,1)  = 0.1;
    for j = 1:length(p_D)
        for i = 1:N1
            x_S(j,i+1) = x_S(j,i) + (-(1 - x_S(j,i))*k*x_S(j,i) + tau*x_R(j,i) + delta*x_I(j,i))*t;
            x_L(j,i+1) = x_L(j,i) + (-(1 -beta)*x_L(j,i)*x_S(j,i)*k  + alpha*(1 - x_S(j,i))*k*x_S(j,i))*t;
            x_R(j,i+1) = x_R(j,i)+(-tau*x_R(j,i)- (1 - tau)*P_I(j)*x_R(j,i)*x_S(j,i)*k + (1 -beta)*P_R(j)*x_L(j,i)*x_S(j,i)*k ......
            + (1 - alpha)*P_R(j)*(1 - x_S(j,i))*k*x_S(j,i) + (1 - delta)*P_R(j)*x_I(j,i)*k*x_S(j,i))*t;
            x_I(j,i+1) = x_I(j,i)+(-delta*x_I(j,i)- (1 - delta)*P_R(j)*x_I(j,i)*x_S(j,i)*k + (1 -tau)*P_I(j)*x_R(j,i)*x_S(j,i)*k ......
            + (1 - alpha)*P_I(j)*(1 - x_S(j,i))*k*x_S(j,i) + (1 - beta)*P_I(j)*x_L(j,i)*k*x_S(j,i))*t;
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
    legend('S的概率','R的概率','I的概率','L的概率');
    title("Detect_ability对SRIL马尔可夫动态演化的影响");


