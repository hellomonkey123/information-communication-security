clc;
clear;
a=[1 0 0 0 0;%表示只有用户1发数据
    0 1 0 0 0;%表示只有用户2发数据
    0 0 1 0 0;
    0 0 0 1 0;
    0 0 0 0 1;
    1 0 1 0 0;%表示用户1和用户3同时发数据
    1 0 0 1 0;
    1 0 0 0 1;
    0 1 0 1 0;
    0 0 1 0 1;
    1 0 1 0 1];%表示用户1和用户3以及用户5同时发数据
n=11;%表示调度方案一共有11种clc

totalP=0;
cvx_begin
variable p(n);

eachP=p'*a;%计算出五个用户的调度速率
maximize  sum(eachP)
 
subject to
for i=1:5
    eachP(i)>=0.4;
    eachP(i)<=1;
    %每个用户的调度速率都等于0.4
end
for i=1:n
    p(i)>=0;%每种调度方案的概率都不能为0
end
sum(p)==1;%所有调度方案的概率总和等于1
cvx_end
 

