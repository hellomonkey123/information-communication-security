function [mean_path]=AveragePath( G ,FLAG)
%求一个图的平均最短路径(Average Shortest Path Length)

len=length(G);%节点个数
m = G;
m(m==0)=len*2; %设置为最大距离的两倍，也就是不可达

for i=1:len
    m(i,i)=0;%邻接矩阵的对角线元素均为0
end

if len<=1%少于一个点
    mean_path = 0;
end

for k=1:len%弗洛伊德算法
    for i=1:len
        for j=1:len
            if m(i,j)>m(i,k)+m(k,j)
               m(i,j) = m(i,k)+m(k,j);
            end
        end
    end
end


for i=1:len
    m(m==len*2)=0;%不可达点的距离化为0
end


    each_path = sum(m')/(length(m)-1);%每个点的平均最短路径长度，减一是减去到自己的距离（不存在）
    mean_path = sum(sum(m'))/length(nonzeros(m'));%整个网络的平均最短路径长度


     if nargin==1%输入的参数为一个，也就是不输入FLAG的值
     bar(each_path,'b');
     title('Average Shortest Path-Length');
     xlabel('Node');
     ylabel('Path length');
     legend(num2str( mean_path),'Location','NorthEastOutside');
    end  
