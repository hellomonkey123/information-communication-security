function [C]=Coefficient(G)
%����ÿ���ڵ�ľۼ�ϵ��(Cluster Coefficient)

K = sum(G');%ÿ���ڵ�Ķ�
C = zeros(1,length(G));%��¼ÿ���ڵ�ľۼ�ϵ��

for i=1:length(G)
    a = find(G(i,:)>0);
    E=0;
    for j=1:length(a)
      for k=j+1:length(a)
          if G(a(j),a(k))==1
            E = E+1;%�ھ����еıߵ�����
          end
      end
    end
    if K(i)==1||K(i)==0
        C(i)=0;
    else
        C(i) = 2*E/(K(i)*(K(i)-1));
    end
end


mean_c = sum(C)/length(C);
bar(C,'g');
title('Clustering Coefficient');
xlabel('Node');
ylabel('Coefficient');
legend(num2str(mean_c),'Location','NorthEastOutside');
end