function A=NW_net()
%%% ����N���ڵ㣬ÿ���ڵ���2K���ھӽڵ��������������ͼͨ���������������NWС������·
%% A �D�D�D�D�D�D��������������ڽӾ���
disp('�ó�������NWС������·��');
N=input('�������������������нڵ������N��');
K=input('��������������������ÿ���ڵ���ھӽڵ�ĸ�����һ��K��');
p=input('������������ӱߵĸ���p:');
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
[m,n]=find(A==0);          %�ҳ������ޱ������Ľڵ�ԣ�ע��A(i,i)=0,Ҫ�ų���
for i=1:length(m)
    if m(i)~=n(i)
        p1=rand(1,1);
        if p>p1
            A(m(i),n(i))=1;  %�ӱ߲��ԣ���δ�ӱߵ����ڵ㣬���ɵ������С��pʱ����ӱ�
            A(n(i),m(i))=1;
        end
    end
end
 
% for i=1:N
%     for j=i+1:i+K
%         jj=j;
%         if j>N
%             jj=mod(j,N);         %%%������
%         end
%         p1=rand(1,1);
%         if p1<p              %% ���ɵ������С��p����߽������������,���򣬲����мӱ�
%           %  A(i,jj)=0;A(jj,i)=0;  
%             A(i,i)=inf; a=find(A(i,:)==0);     %�������ԣ����Ͽ�ԭ���ıߣ�ֱ����δ���ı������ѡ����һ���ڵ㣬
%             m=length(a);                       %      ����ԭ�ڵ����ӡ�
%             if m==0
%                 disp(['�ڵ�',int2str(i),'�����������нڵ������������ٶԸýڵ�ӱ�']);
%                 A(i,i)=0;
%                 break;              
%             else               
%             rand_data=randint(1,1,[1,length(a)]);  
%             jjj=a(rand_data);
%             A(i,jjj)=1;A(jjj,i)=1;
%             A(i,i)=0;
%             end
%         end
%     end
% end
 
for i=1:N 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2); 
            hold on;      %% ����NWС��������ͼ
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
 