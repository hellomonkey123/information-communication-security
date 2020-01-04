%% Solving HJB
syms x1 x2 real

f = [x1*x2-x1^3-x1*x2*x2; 
	 x1+2*x2];

q0 = x1^2+x2^2;

r = 0.01*eye(2);

g = [0 0.5; 0.5 0.1];

u1 = [10.283*x1-13.769*x2; -10.7*x1-3.805*x2];

Options.Vdmax = 4;
Options.itnum = 20;
Options.Omg = [-1,1,-1,1];

[Vold,Vnew,unew] = HJB_SOS(f,g,u1,q0,r,Options)


%% Visulization & Comparsion
close all
figure(1)
xx1=-1:0.1:1;
xx2=-1:0.1:1;
vn=zeros(length(xx1),length(xx2));
v1=zeros(length(xx1),length(xx2));
vs=[];
us=[];
un=vn;
ulqr = un;
kn=vn;
k1=v1;
x3=0;
x4=0;
for i=1:length(xx1)
    x1 = xx1(i);
    for j=1:length(xx2)
        x2 = xx2(j);
        vn(i,j)=eval(Vnew);
        v1(i,j)=eval(Vold);
    end
end
surf(xx1,xx2,vn')
hold on
surf(xx1,xx2,v1')
hold off
xlabel('x_1', 'FontSize', 12)
ylabel('x_2', 'FontSize', 12)
view(gca,[-30.5 28]);
% Create textarrow
annotation(gcf,'textarrow',[0.210714285714286 0.174535137214669],...
    [0.895238095238095 0.631440045897884],'TextEdgeColor','none','FontSize',12,...
    'String',{'V_{old}(x1,x2)'});

% Create textarrow
annotation(gcf,'textarrow',[0.139285714285714 0.186735060271868],...
    [0.183333333333333 0.386454388984516],'TextEdgeColor','none','FontSize',12,...
    'String',{'V_{new}(x1,x2)'});


%% Simulation & Comparsion

figure(2)
ode45(@(t,x)mysys(t,x,f,g,unew),[0,1],[1;1])
title('With optimized controller')

figure(3)
ode45(@(t,x)mysys(t,x,f,g,u1),[0,1],[1;1])
title('With original controller')

