
x=1:1:120;
figure(1)
plot(exp(-(1+3./x)) + 0.3,'rs','LineStyle','-.','LineWidth',1)
xlabel('处理器开销');
ylabel('成功检查概率');
title("处理器开销与成功检查概率之间的关系");


y=1:1:120;
figure(2)
plot(log(1+0.6*y./(20+y))+ 0.4,'rs','LineStyle','-.','LineWidth',1)
xlabel('缓存开销');
ylabel('成功检查概率');
title("缓存开销与成功检查概率之间的关系");



% figure(4)
% nn=1:1:120;
% hold on
% plot(xjdk(nn,2)/469,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,3)/496,'g+','LineStyle','--','LineWidth',1);
% xlabel('时间t');
% ylabel('各状态概率');
% legend('R的概率','I 的概率');
% title("无标度网络下I、R状态演化过程");
% 
% figure(5)
% 
% hold on
% plot(xjdk(nn,5)/469,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,6)/496,'g+','LineStyle','--','LineWidth',1);
% xlabel('时间t');
% ylabel('各状态概率');
% legend('R的概率','I 的概率');
% title("小世界网络下I、R状态演化过程");
% 
% figure(6)
% hold on
% plot(xjdk(nn,8)/400,'rs','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,9)/400,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,10)/400,'g+','LineStyle','--','LineWidth',1);
% xlabel('时间t');
% ylabel('各状态概率');
% legend('LR 的概率','I 的概率','R的概率');
% title("小世界网络下LR、I、R状态演化过程");
% 
% figure(7)
% hold on
% plot(xjdk(nn,12)/400,'rs','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,13)/400,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,14)/400,'g+','LineStyle','--','LineWidth',1);
% xlabel('时间t');
% ylabel('各状态概率');
% legend('LR 的概率','I 的概率','R的概率');
% title("无标度网络下LR、I、R状态演化过程");


