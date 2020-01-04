function [keep_path]=IntentionalAttack1( G)
%对网络进行随机攻击，查看其对平均最短路径的影响(IntentionalAttack)
degree = sum(G');
mean_path = zeros(1,length(G));
[max_2,~,~,~,~] = MaxSubPath(G,2);
MaxSubNum = max_2;
max_sub_num = zeros(1,length(G));
temp = G;

for i=1:length(G)-1
  degree = sum(temp');
  j = find(degree==max(degree));
  if length(j)>1%不止一个的话就取第一个
      j = j(1);
  end
  temp(j,:)=[];
  temp(:,j)=[]; 

   [~,~,~,~,min_path] = MaxSubPath(temp,2);
   mean_path(i) = min_path;
   [max_1,~,~,~,~] = MaxSubPath(temp,2);
   max_sub_num(i) = max_1/MaxSubNum;

end


figure(1);
x = (1:length(G));
plot(x,mean_path,'bx');
title('Robustness Against Intentional Attack');
xlabel('Node');
legend('Average Shortest Path of Largest SubGraph','Location','NorthEastOutside');
hold on;
figure(2);
plot(x,max_sub_num,'ro')
title('Robustness Against Intentional Attack');
xlabel('Node');
legend('Percentage of Largest SubGraph','Location','NorthEastOutside');
end