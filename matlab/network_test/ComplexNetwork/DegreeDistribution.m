function [node_degree]=DegreeDistribution(G)
% 计算每个节点的度

node_degree = sum(G');
figure(1);
bar(node_degree,'r');
title('Node Degree Distribution');
xlabel('Node');
ylabel('Degree');
avg_degree = sum(node_degree)/(length(node_degree));
legend(num2str(avg_degree),'Location','NorthEastOutside');
hold;

figure(2);
md = max(node_degree);
for i=1:md+1
    n_deg(i) = length(find(node_degree == i-1));
end
bar([0:md],n_deg,'r');
title('Node Degree Distribution');
xlabel('Degree');
ylabel('Node');
avg_degree = sum(node_degree)/(length(node_degree));
legend(num2str(avg_degree),'Location','NorthEastOutside');
end
