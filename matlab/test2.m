clc;
clear;
a=[1 0 0 0 0;%��ʾֻ���û�1������
    0 1 0 0 0;%��ʾֻ���û�2������
    0 0 1 0 0;
    0 0 0 1 0;
    0 0 0 0 1;
    1 0 1 0 0;%��ʾ�û�1���û�3ͬʱ������
    1 0 0 1 0;
    1 0 0 0 1;
    0 1 0 1 0;
    0 0 1 0 1;
    1 0 1 0 1];%��ʾ�û�1���û�3�Լ��û�5ͬʱ������
n=11;%��ʾ���ȷ���һ����11��clc

totalP=0;
cvx_begin
variable p(n);

eachP=p'*a;%���������û��ĵ�������
maximize  sum(eachP)
 
subject to
for i=1:5
    eachP(i)>=0.4;
    eachP(i)<=1;
    %ÿ���û��ĵ������ʶ�����0.4
end
for i=1:n
    p(i)>=0;%ÿ�ֵ��ȷ����ĸ��ʶ�����Ϊ0
end
sum(p)==1;%���е��ȷ����ĸ����ܺ͵���1
cvx_end
 
