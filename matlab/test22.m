clc;
clear;
a=[1 0 0 0 0;%ֻ���û�1������
    0 1 0 0 0;
    0 0 1 0 0;
    0 0 0 1 0;
    0 0 0 0 1;
    1 0 1 0 0;%�û�1���û�3ͬʱ������
    1 0 0 1 0;
    1 0 0 0 1;
    0 1 0 1 0;
    0 0 1 0 1;
    1 0 1 0 1];%�û�1���û�3�Լ��û�5ͬʱ������
%b��ʾ�ڵ�X��������ߵĵ��ȷ���
b=[1 0 0 0 0;%
    0 1 0 0 0;
    0 0 1 0 0;
    0 0 0 0 1;
    1 0 1 0 0 ;
    1 0 0 0 1 ;
    1 0 1 0 1];
%c��ʾ�ڵ�X�������ұߵ�����µĵ��ȷ���
c=[0 1 0 0 0 ;
    0 0 1 0 0;
    0 0 0 1 0;
    0 0 0 0 1;
    0 1 0 1 0 ;
   0 0 1 0 1 ];
n1=11;%��ʾ�ڵ�Xû�г��ֵ�����£����ȷ�������11��
n2=7;%��ʾ�ڵ�X��������ߵĵ��ȷ��������ȷ�������7��
n3=6;%��ʾ�ڵ�X�������ұߵ�����µĵ��ȷ��������ȷ�������6��

cvx_begin
variable p1(n1);
variable p2(n2);
variable p3(n3);

eachP1=p1'*a;%�������֪�ڵ�Xû�г��ֵ�����£�11�ֵ��ȷ����ĸ����ܺ�

eachP2=p2'*b;%�������֪�ڵ�X��������ߵ�����£�7�ֵ��ȷ����ĸ����ܺ�

eachP3=p3'*c;%�������֪�ڵ�X�������ұߵ�����£�6�ֵ��ȷ����ĸ����ܺ�
   
maximize 0.5*sum(eachP1)+0.3*sum(eachP2)+0.2*sum(eachP3)
subject to
sum(p1)==1;%��֪�ڵ�Xû�г��ֵ�����£�11�ֵ��ȷ����ĸ����ܺͱ������1
sum(p2)==1;%��֪�ڵ�X��������ߵ�����£�7�ֵ��ȷ����ĸ����ܺͱ������1
sum(p3)==1;%��֪�ڵ�X�������ұߵ�����£�6�ֵ��ȷ����ĸ����ܺͱ������1
for i=1:5
    d(i)=0.5*eachP1(i)+0.3*eachP2(i)+0.2*eachP3(i)>=0.2;%��ʾ5���û��ĵ������ʶ��ֱ����0.2
    0.5*eachP1(i)+0.3*eachP2(i)+0.2*eachP3(i)<=1;
end
for i=1:n1
    p1(i)>=0;%��ʾ�ڵ�Xû�г��ֵ�����£����ȷ����ĸ��ʶ�����С����
end
for i=1:n2
    p2(i)>=0;%��ʾ�ڵ�X��������ߵ�����£����ȷ����ĸ��ʶ�����С����
end
for i=1:n3
    p3(i)>=0;%��ʾ�ڵ�X�������ұߵ�����£����ȷ����ĸ��ʶ�����С����
end
 
cvx_end