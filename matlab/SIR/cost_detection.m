
x=1:1:120;
figure(1)
plot(exp(-(1+3./x)) + 0.3,'rs','LineStyle','-.','LineWidth',1)
xlabel('����������');
ylabel('�ɹ�������');
title("������������ɹ�������֮��Ĺ�ϵ");


y=1:1:120;
figure(2)
plot(log(1+0.6*y./(20+y))+ 0.4,'rs','LineStyle','-.','LineWidth',1)
xlabel('���濪��');
ylabel('�ɹ�������');
title("���濪����ɹ�������֮��Ĺ�ϵ");



% figure(4)
% nn=1:1:120;
% hold on
% plot(xjdk(nn,2)/469,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,3)/496,'g+','LineStyle','--','LineWidth',1);
% xlabel('ʱ��t');
% ylabel('��״̬����');
% legend('R�ĸ���','I �ĸ���');
% title("�ޱ��������I��R״̬�ݻ�����");
% 
% figure(5)
% 
% hold on
% plot(xjdk(nn,5)/469,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,6)/496,'g+','LineStyle','--','LineWidth',1);
% xlabel('ʱ��t');
% ylabel('��״̬����');
% legend('R�ĸ���','I �ĸ���');
% title("С����������I��R״̬�ݻ�����");
% 
% figure(6)
% hold on
% plot(xjdk(nn,8)/400,'rs','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,9)/400,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,10)/400,'g+','LineStyle','--','LineWidth',1);
% xlabel('ʱ��t');
% ylabel('��״̬����');
% legend('LR �ĸ���','I �ĸ���','R�ĸ���');
% title("С����������LR��I��R״̬�ݻ�����");
% 
% figure(7)
% hold on
% plot(xjdk(nn,12)/400,'rs','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,13)/400,'bo','LineStyle',':','LineWidth',1);
% plot(xjdk(nn,14)/400,'g+','LineStyle','--','LineWidth',1);
% xlabel('ʱ��t');
% ylabel('��״̬����');
% legend('LR �ĸ���','I �ĸ���','R�ĸ���');
% title("�ޱ��������LR��I��R״̬�ݻ�����");


