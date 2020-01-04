function [CORENESS]=Coreness(G)
%计算每个节点以及整个网络的核数(Coreness)
CORENESS = zeros(1,length(G));%1*n的全0矩阵，即所有节点的核数均为0
nodes_degree = sum(G');%每个点的度
max = length(G)+ 1;%max即节点所能达到的最大度数+1，也即不能达到的度数
pre_min = 0;%负责记录上一轮中的最小的度数
counted_num=0;%负责记录查找并计算过的节点的数

for i=1:length(nodes_degree)
   m = min(nodes_degree);%返回度数的最小值，是一个数值
   min_node = find(nodes_degree==m);%是一个列向量,返回最小度数的节点所在的列的下标，也即度数最小的节点序号
   counted_num = counted_num + length(min_node);
   if pre_min>m
   CORENESS(min_node) = pre_min;
   else
       CORENESS(min_node) = m;
   end

   if length(min_node)>1     %一个以上的最小度数的点
      for j=1:length(min_node)
          x = min_node(j);
          for k=1:length(G)
              if G(k,x)==1%节点k与最小度数节点相连            
                  if CORENESS(k)==0%且该节点尚未在计算核数的范围内
                    nodes_degree(k) = nodes_degree(k)-1;%更新度数
                  end
              end
          end
      end
   else     %只有一个最小度数的点
       for j=1:length(G)
          if G(j,min_node)==1;
              if CORENESS(j)==0
                 nodes_degree(j) = nodes_degree(j)-1;%更新度数
              end
          end
       end
   end

   nodes_degree(min_node) = max;%将这些原先度数最小的点的度化为max，目的是为了下一轮找最小度数节点不会再找到它们
   pre_min = m;%记录上一轮中的最小度数
   if counted_num>=length(nodes_degree)%查找完毕，提前跳出整个for循环
       break;
   end
end


bar(CORENESS,'m');
title('Node Coreness');
xlabel('Node');
ylabel('Coreness');


max_coreness = CORENESS(1);%找到最大的核数作为整个网络的核数
for i=1:length(CORENESS)
    if CORENESS(i)>max_coreness
        max_coreness = CORENESS(i);
    end
end

legend(num2str(max_coreness),'Location','NorthEastOutside');

end