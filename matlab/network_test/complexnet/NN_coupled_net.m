function A=NN_coupled_net()
%%% ������N���ڵ㣬ÿ���ڵ���2K���ھӽڵ��������������
%% A �D�D�D�D�D�D��������������ڽӾ���
disp('�ó�����������������·��');
N=input('�������������������нڵ������N��');
K=input('��������������������ÿ���ڵ���ھӽڵ�ĸ�����һ��K��');
if K>floor(N/2)
    disp('�����Kֵ���Ϸ�')
    return;
end
angle=0:2*pi/N:2*pi-2*pi/N;  %%����������������ĸ��ڵ�����
x=100*sin(angle);
y=100*cos(angle);
plot(x,y,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',8);
hold on; 
 
A=zeros(N);
for i=1:N
    for j=i+1:i+K
        jj=j;
        if j>N
            jj=mod(j,N);
        end
      A(i,jj)=1; A(jj,i)=1;     %%������������������ڽӾ���
    end
end
for i=1:N 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2); 
            hold on;          %% ����������������ͼ
        end
    end
end
axis equal;
hold off   
[C,aver_C]=Clustering_Coefficient(A);
[DeD,aver_DeD]=Degree_Distribution(A);
[D,aver_D]=Aver_Path_Length(A);   
 disp(['�����ͼ��ƽ��·������Ϊ��',num2str(aver_D)]);  %%������������������
 disp(['�����ͼ�ľ���ϵ��Ϊ��',num2str(aver_C)]);
 disp(['�����ͼ��ƽ����Ϊ��',num2str(aver_DeD)]);   