clc;
clear;

N=100;
a=100; %aΪѭ������
j=1;   %jΪpֵ������־
for p=0:0.01:1
% p=0.1;

degree=zeros(N,a);  %degree���������������нڵ�Ķȷֶ�k
a_k=zeros(a,1);     %a_k�������������ƽ����

a_D=zeros(a,1);     %a_D�������������ƽ����̾���D

sum_CC=zeros(N,a);  %sum_CC�������������нڵ�ġ��ھ�ʵ�������ı�����
a_CC=zeros(N,a);    %�������������нڵ�ļ���ϵ��
ave_CC=zeros(a,1);  %һ������ļ���ϵ��
for i=1:a
adjmex=zeros(N,N);  %adjmexΪ�ڽӾ���
for m=1:N
     for n=m+1:N
        if(rand(1,1)<p)
             adjmex(m,n)=1;
             adjmex(n,m)=1;
        end
     end
end

%��һ������Ķȷֲ�
for b=1:N
    degree(b,i)=sum(adjmex(b,:));
end

%��һ�������ƽ����
a_k(i,1)=sum(adjmex(:))/N;

%��һ�������ƽ������̾���·�������ڵ��֮�����֮��/�ڵ����Ŀ��
%���У����ɴ��������Ϊ0���ڵ��������������Ϊ0���ڵ����ĿΪ(N*(N-1)/2)
D=adjmex;  %DΪ�������
D(find(D==0))=inf;
for k=1:N   %Floyd�㷨��������������̾��� ? ?
    for e=1:N
        for f=1:N
            if D(e,f)>D(e,k)+D(k,f)
                 D(e,f)=D(e,k)+D(k,f);
            end
        end
    end
    D(k,k)=0;
end
D(find(D==inf))=0;
a_D(i,1)=(sum(D(:))/2)/(N*(N-1)/2);

%��һ�������ƽ������ϵ�������нڵ��CC֮��/�ڵ���Ŀ
%һ���ڵ��CC=�ھ�ʵ�������ı�/�ھӼ�Ӧ�������ı�=�ھ�ʵ�������ı�/��di*��di-1��/2��
%���У�diΪ�ڵ�i�Ķ�
%���ԣ���ڵ�CC�ķ��������Խڵ�i���ھ���Ϊ�ڵ㣬������ͼ����ͼ��1����Ŀ��һ�����CC
for k=1:N
    num_k=sum(adjmex(k,:));
    if num_k==0||num_k==1  %���ڵ�i��Ϊ0��1������û��CC
        sum_CC(k,i)=0;
    else
        for e=1:N
            for f=e+1:N
                if adjmex(k,e)+adjmex(k,f)==2 && adjmex(e,f)==1
                   sum_CC(k,i)=sum_CC(k,i)+1;
                end
            end
        end
        a_CC(k,i)=sum_CC(k,i)/((num_k)*(num_k-1)/2); 
    end
end
ave_CC(i,1)=sum(a_CC(:,i))/N;
end
aver_k(j,1)=sum(a_k(:))/a;%��ͳ��ƽ����
aver_D(j,1)=sum(a_D(:))/a;%��ͳ��ƽ����̾���
aver_CC(j,1)=sum(ave_CC(:))/a;%��ͳ��ƽ������ϵ��
j=j+1;
end


% figure;
% subplot(2,2,1);histogram(degree,'Normalization','probability');%��ͼ��ͳ�ƶȷֲ�
% title('ͳ��ƽ���Ķȷֲ�(N=100,p=0.1)');xlabel('�ڵ�Ķ�');ylabel('Ƶ��');
%?
% subplot(2,2,2);histogram(a_k,'Normalization','probability');%��ͼ��ƽ����
% title('������������ƽ����');xlabel('ƽ����');ylabel('Ƶ��');
%?
% subplot(2,2,3);histogram(a_D,'Normalization','probability');%��ͼ��ƽ�����·������
% title('������������ƽ�����·������');xlabel('ƽ�����·������');ylabel('Ƶ��');
%?
% subplot(2,2,4);histogram(ave_CC,'Normalization','probability');%��ͼ��ƽ������ϵ��
% title('������������ƽ������ϵ��');xlabel('ƽ������ϵ��');ylabel('Ƶ��');

% ��pֵ�仯ͳ�����Ե�ͼ
x = linspace(0,1,101);
figure;
subplot(2,1,1);
plot(x,aver_k);
xlabel('p');
title('��������ƽ����');
% subplot(3,1,2);
% plot(x,aver_D);
% xlabel('p');
% title('��������ƽ�����·������');
subplot(2,1,2);
plot(x,aver_CC);
xlabel('p');
title('��������ƽ������ϵ��');