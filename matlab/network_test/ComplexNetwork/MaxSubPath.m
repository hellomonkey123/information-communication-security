function [max_1,Max_Sub,s,Q,min_path]=MaxSubPath(G,FLAG)
%求最大连通子图的平均最短路径
%C 顶点所分的块数
%con 每行表示一个连通域中的节点标号
%s 各连通域规模（节点数）
%min_path 平均最短路径的长度
%Max_Sub 最大连通子图所在的标号
n=size(G,1);%将矩阵G的行数的值赋给n，也即节点的个数
m=sum(sum(G))/2;
c=1;
q=zeros(n,1);%n*1的全0矩阵
Q=zeros(n,1);
for i=1:n
    if sum(G(i,:))==0  %G整行的和为0，说明i为孤立点
        q(i)=c;
        c=c+1;
    else   
        for j=1:n  
            if G(i,j)==1
                if q(i)==q(j)   %若两者之间有边且标记相同，则属于同一块
                    if q(i)==0
                        q(i)=c;q(j)=c;
                        c=c+1;
                    end
                else    %两者之间有边但标记不同
                    if q(i)==0   %i点尚未获得标记
                        q(i)=q(j);
                    elseif q(j)==0  %j点尚未获得标记
                        q(j)=q(i);
                    else   
                        for k=1:n   %更新标记
                            if q(k)==q(i)
                                q(k)=q(j);
                            end
                        end
                    end
                end
            end
        end
    end
end

%重新编号，排除空的块号
C=0;
for k=1:c-1
    if ~isempty(find(q==k, 1))%利用find函数找到q==k的下标
        C=C+1;
        Q(q==k)=C;%存储各个节点所在的块号
        s(C,1)=length(find(q==k)); 
    end
end

sort(s,1,'descend');

Max_Sub=find(s==max(s));%最大连通子图所在的标号
len_Q = length(Q);


M = zeros(len_Q,len_Q)%创建一个新的矩阵存储最大连通子图的邻接矩阵
for i=1:len_Q
  if Q(i)==Max_Sub
      for j=1:len_Q
          M(i,j)=G(i,j);
      end
  end
end

max_1 = s(1);%找到最大连通子图的节点数
   for i=1:length(s)
       if s(i)>max_1
           max_1 = s(i);
       end
   end

A1=sum(abs(M'));%删除所有为0的行
index=find(A1==0);
M(index,:)=[];

A2=sum(abs(M));%删除所有为0的列
index=find(A2==0);
M(:,index)=[];

if nargin==1
    AveragePath(M);%计算最大连通子图的平均最短路径
else
    min_path = AveragePath(M,FLAG);%计算最大连通子图的平均最短路径
end  