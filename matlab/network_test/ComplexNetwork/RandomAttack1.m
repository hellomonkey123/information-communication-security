function [mean_path]=RandomAttack1( G )
%�������������������鿴���ƽ�����·����Ӱ��(RandomAttack)
mean_path = zeros(1,length(G));
[max,~,~,~,~] = MaxSubPath(G,2);
MaxSubNum = max;
max_sub_num = zeros(1,length(G));
temp = G;


for i=1:length(G)-1
   temp(1,:)=[];%ȥ����1��
   temp(:,1)=[];%ȥ����1��
   [~,~,~,~,min_path] = MaxSubPath(temp,2);
   mean_path(i) = min_path;
   [max_1,~,~,~,~] = MaxSubPath(temp,2);
   max_sub_num(i) = max_1/MaxSubNum;
end

figure(1);
x = (1:length(G));
plot(x,mean_path,'bx');
title('Robustness Against Random Attack');
xlabel('Node');
legend('Average Shortest Path of Largest SubGraph','Location','NorthEastOutside');
hold on;
figure(2);
plot(x,max_sub_num,'ro')
title('Robustness Against Random Attack');
xlabel('Node');
legend('Percentage of Largest SubGraph','Location','NorthEastOutside');
end