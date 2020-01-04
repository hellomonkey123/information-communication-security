function [mean_path]=AveragePath( G ,FLAG)
%��һ��ͼ��ƽ�����·��(Average Shortest Path Length)

len=length(G);%�ڵ����
m = G;
m(m==0)=len*2; %����Ϊ�������������Ҳ���ǲ��ɴ�

for i=1:len
    m(i,i)=0;%�ڽӾ���ĶԽ���Ԫ�ؾ�Ϊ0
end

if len<=1%����һ����
    mean_path = 0;
end

for k=1:len%���������㷨
    for i=1:len
        for j=1:len
            if m(i,j)>m(i,k)+m(k,j)
               m(i,j) = m(i,k)+m(k,j);
            end
        end
    end
end


for i=1:len
    m(m==len*2)=0;%���ɴ��ľ��뻯Ϊ0
end


    each_path = sum(m')/(length(m)-1);%ÿ�����ƽ�����·�����ȣ���һ�Ǽ�ȥ���Լ��ľ��루�����ڣ�
    mean_path = sum(sum(m'))/length(nonzeros(m'));%���������ƽ�����·������


     if nargin==1%����Ĳ���Ϊһ����Ҳ���ǲ�����FLAG��ֵ
     bar(each_path,'b');
     title('Average Shortest Path-Length');
     xlabel('Node');
     ylabel('Path length');
     legend(num2str( mean_path),'Location','NorthEastOutside');
    end  
