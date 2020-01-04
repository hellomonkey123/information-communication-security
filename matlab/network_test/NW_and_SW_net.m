clear,clc,close all
% load A.txt
N=3000;
m=6;
p=0.1;
A= small_world_WS_new(N,m,p);
% A = small_world_NW(N, m, p);
t=linspace(0,2*pi,N+1);
x=sin(t);
y=cos(t);
figure
set(gcf,'color','w')
plot(x,y,'o','markerfacecolor','k'),hold on
for i=1:N
    for j=1:N
        if (A(i,j)==1)
        fp1=plot([x(i),x(j)],[y(i),y(j)],'r-'); hold on
        set(fp1,'linesmoothing','on')
        end
    end
end
axis([-1.05,1.05,-1.05,1.05])
axis square
axis off
sum(sum(A))