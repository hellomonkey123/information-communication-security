clc
clear;

N= 7;                                  %%node的数目
B = round (4 * rand (N));              %%生成限制矩阵
C = round (6 * rand (N));              %%cost的矩阵
I = [1:1:N]';                          %%每个节点的外部流入
O = [N:-1:1]';                         %%每个节点的向外部流出
s1 = 0;
s2 = 0;
cvx_begin
variable f nonnegative
variable x(N,N) nonnegative
% variable sum1(N,1) nonnegative
% variable sum2(N,1) nonnegative
tf = 0;
for i=1:N
    for j = 1 : N;
        tf=tf+x(i,j) * C(i,j);
        s1=s1+ x(j,i);%% 对于某个特定i，x(j,i)的和
        s2=s2+ x(i,j);%% 对于某个特定i，x(i,j)的和
    end
    sum1(i) = s1;  
    sum2(i) = s2;  
end                               
f >= tf;
minimize(f)
subject to
for i = 1:N;
    sum1(i) + I(i) >= sum2 (i) + O(i);         %%服从balance的限制
    for j = 1:N;
        x(i,j) <=  B(i,j) ;                    %%每路流量服从链路容量的限制
    end
end
cvx_end


