clc;
clear;
f=0;
n=10;
sum=0;
Pone = 1;
Ptot=5;
delta=0.5;
g=[1 2 3 4 5 5 4 3 2 1];
cvx_begin
variable p(n)
for i=1:n
    f=f+log(1+p(i)*g(i)/(delta^2));
    sum=sum+p(i);
end
maximize(f);

subject to
sum<=Ptot;
for i=1:n
    p(i)<=Pone;
end
    cvx_end
