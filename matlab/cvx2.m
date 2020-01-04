clc
clear;

N= 7;                                  %%node����Ŀ
B = round (4 * rand (N));              %%�������ƾ���
C = round (6 * rand (N));              %%cost�ľ���
I = [1:1:N]';                          %%ÿ���ڵ���ⲿ����
O = [N:-1:1]';                         %%ÿ���ڵ�����ⲿ����
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
        s1=s1+ x(j,i);%% ����ĳ���ض�i��x(j,i)�ĺ�
        s2=s2+ x(i,j);%% ����ĳ���ض�i��x(i,j)�ĺ�
    end
    sum1(i) = s1;  
    sum2(i) = s2;  
end                               
f >= tf;
minimize(f)
subject to
for i = 1:N;
    sum1(i) + I(i) >= sum2 (i) + O(i);         %%����balance������
    for j = 1:N;
        x(i,j) <=  B(i,j) ;                    %%ÿ·����������·����������
    end
end
cvx_end


