function [CORENESS]=Coreness(G)
%����ÿ���ڵ��Լ���������ĺ���(Coreness)
CORENESS = zeros(1,length(G));%1*n��ȫ0���󣬼����нڵ�ĺ�����Ϊ0
nodes_degree = sum(G');%ÿ����Ķ�
max = length(G)+ 1;%max���ڵ����ܴﵽ��������+1��Ҳ�����ܴﵽ�Ķ���
pre_min = 0;%�����¼��һ���е���С�Ķ���
counted_num=0;%�����¼���Ҳ�������Ľڵ����

for i=1:length(nodes_degree)
   m = min(nodes_degree);%���ض�������Сֵ����һ����ֵ
   min_node = find(nodes_degree==m);%��һ��������,������С�����Ľڵ����ڵ��е��±꣬Ҳ��������С�Ľڵ����
   counted_num = counted_num + length(min_node);
   if pre_min>m
   CORENESS(min_node) = pre_min;
   else
       CORENESS(min_node) = m;
   end

   if length(min_node)>1     %һ�����ϵ���С�����ĵ�
      for j=1:length(min_node)
          x = min_node(j);
          for k=1:length(G)
              if G(k,x)==1%�ڵ�k����С�����ڵ�����            
                  if CORENESS(k)==0%�Ҹýڵ���δ�ڼ�������ķ�Χ��
                    nodes_degree(k) = nodes_degree(k)-1;%���¶���
                  end
              end
          end
      end
   else     %ֻ��һ����С�����ĵ�
       for j=1:length(G)
          if G(j,min_node)==1;
              if CORENESS(j)==0
                 nodes_degree(j) = nodes_degree(j)-1;%���¶���
              end
          end
       end
   end

   nodes_degree(min_node) = max;%����Щԭ�ȶ�����С�ĵ�ĶȻ�Ϊmax��Ŀ����Ϊ����һ������С�����ڵ㲻�����ҵ�����
   pre_min = m;%��¼��һ���е���С����
   if counted_num>=length(nodes_degree)%������ϣ���ǰ��������forѭ��
       break;
   end
end


bar(CORENESS,'m');
title('Node Coreness');
xlabel('Node');
ylabel('Coreness');


max_coreness = CORENESS(1);%�ҵ����ĺ�����Ϊ��������ĺ���
for i=1:length(CORENESS)
    if CORENESS(i)>max_coreness
        max_coreness = CORENESS(i);
    end
end

legend(num2str(max_coreness),'Location','NorthEastOutside');

end