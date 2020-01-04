function [max_1,Max_Sub,s,Q,min_path]=MaxSubPath(G,FLAG)
%�������ͨ��ͼ��ƽ�����·��
%C �������ֵĿ���
%con ÿ�б�ʾһ����ͨ���еĽڵ���
%s ����ͨ���ģ���ڵ�����
%min_path ƽ�����·���ĳ���
%Max_Sub �����ͨ��ͼ���ڵı��
n=size(G,1);%������G��������ֵ����n��Ҳ���ڵ�ĸ���
m=sum(sum(G))/2;
c=1;
q=zeros(n,1);%n*1��ȫ0����
Q=zeros(n,1);
for i=1:n
    if sum(G(i,:))==0  %G���еĺ�Ϊ0��˵��iΪ������
        q(i)=c;
        c=c+1;
    else   
        for j=1:n  
            if G(i,j)==1
                if q(i)==q(j)   %������֮���б��ұ����ͬ��������ͬһ��
                    if q(i)==0
                        q(i)=c;q(j)=c;
                        c=c+1;
                    end
                else    %����֮���бߵ���ǲ�ͬ
                    if q(i)==0   %i����δ��ñ��
                        q(i)=q(j);
                    elseif q(j)==0  %j����δ��ñ��
                        q(j)=q(i);
                    else   
                        for k=1:n   %���±��
                            if q(k)==q(i)
                                q(k)=q(j);
                            end
                        end
                    end
                end
            end
        end
    end
end

%���±�ţ��ų��յĿ��
C=0;
for k=1:c-1
    if ~isempty(find(q==k, 1))%����find�����ҵ�q==k���±�
        C=C+1;
        Q(q==k)=C;%�洢�����ڵ����ڵĿ��
        s(C,1)=length(find(q==k)); 
    end
end

sort(s,1,'descend');

Max_Sub=find(s==max(s));%�����ͨ��ͼ���ڵı��
len_Q = length(Q);


M = zeros(len_Q,len_Q)%����һ���µľ���洢�����ͨ��ͼ���ڽӾ���
for i=1:len_Q
  if Q(i)==Max_Sub
      for j=1:len_Q
          M(i,j)=G(i,j);
      end
  end
end

max_1 = s(1);%�ҵ������ͨ��ͼ�Ľڵ���
   for i=1:length(s)
       if s(i)>max_1
           max_1 = s(i);
       end
   end

A1=sum(abs(M'));%ɾ������Ϊ0����
index=find(A1==0);
M(index,:)=[];

A2=sum(abs(M));%ɾ������Ϊ0����
index=find(A2==0);
M(:,index)=[];

if nargin==1
    AveragePath(M);%���������ͨ��ͼ��ƽ�����·��
else
    min_path = AveragePath(M,FLAG);%���������ͨ��ͼ��ƽ�����·��
end  