clc;
clear;

N=100;
a=100; %a为循环次数
j=1;   %j为p值递增标志
for p=0:0.01:1
% p=0.1;

degree=zeros(N,a);  %degree包含所有网络所有节点的度分度k
a_k=zeros(a,1);     %a_k包含所有网络的平均度

a_D=zeros(a,1);     %a_D包含所有网络的平均最短距离D

sum_CC=zeros(N,a);  %sum_CC是所有网络所有节点的【邻居实际相连的边数】
a_CC=zeros(N,a);    %求所有网络所有节点的集聚系数
ave_CC=zeros(a,1);  %一个网络的集聚系数
for i=1:a
adjmex=zeros(N,N);  %adjmex为邻接矩阵
for m=1:N
     for n=m+1:N
        if(rand(1,1)<p)
             adjmex(m,n)=1;
             adjmex(n,m)=1;
        end
     end
end

%求一个网络的度分布
for b=1:N
    degree(b,i)=sum(adjmex(b,:));
end

%求一个网络的平均度
a_k(i,1)=sum(adjmex(:))/N;

%求一个网络的平均【最短距离路径】：节点对之间距离之和/节点对数目。
%其中，不可达两点距离为0，节点自身与自身距离为0，节点对数目为(N*(N-1)/2)
D=adjmex;  %D为距离矩阵
D(find(D==0))=inf;
for k=1:N   %Floyd算法求解任意两点的最短距离 ? ?
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

%求一个网络的平均集聚系数：所有节点的CC之和/节点数目
%一个节点的CC=邻居实际相连的边/邻居间应该相连的边=邻居实际相连的边/（di*（di-1）/2）
%其中，di为节点i的度
%所以，算节点CC的方法二：以节点i的邻居们为节点，构造子图。子图中1的数目的一半就是CC
for k=1:N
    num_k=sum(adjmex(k,:));
    if num_k==0||num_k==1  %若节点i度为0或1，则其没有CC
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
aver_k(j,1)=sum(a_k(:))/a;%求统计平均度
aver_D(j,1)=sum(a_D(:))/a;%求统计平均最短距离
aver_CC(j,1)=sum(ave_CC(:))/a;%求统计平均集聚系数
j=j+1;
end


% figure;
% subplot(2,2,1);histogram(degree,'Normalization','probability');%作图求统计度分布
% title('统计平均的度分布(N=100,p=0.1)');xlabel('节点的度');ylabel('频率');
%?
% subplot(2,2,2);histogram(a_k,'Normalization','probability');%作图求平均度
% title('所有随机网络的平均度');xlabel('平均度');ylabel('频率');
%?
% subplot(2,2,3);histogram(a_D,'Normalization','probability');%作图求平均最短路径距离
% title('所有随机网络的平均最短路径距离');xlabel('平均最短路径距离');ylabel('频率');
%?
% subplot(2,2,4);histogram(ave_CC,'Normalization','probability');%作图求平均集聚系数
% title('所有随机网络的平均集聚系数');xlabel('平均集聚系数');ylabel('频率');

% 随p值变化统计特性的图
x = linspace(0,1,101);
figure;
subplot(2,1,1);
plot(x,aver_k);
xlabel('p');
title('随机网络的平均度');
% subplot(3,1,2);
% plot(x,aver_D);
% xlabel('p');
% title('随机网络的平均最短路径距离');
subplot(2,1,2);
plot(x,aver_CC);
xlabel('p');
title('随机网络的平均集聚系数');