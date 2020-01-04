clear;
clc;
B = [0 3 1 1;3 0 3 2;1 3 0 3;1 2 3 0];
C = [0 2 2 2;2 0 1 3;2 1 0 1;2 3 1 0];
n = 4;
P=8;
cvx_begin
variable x(n,n)
d=C.*x;
minimize(sum(d(:)));
subject to
 (sum(x(:))/2)==P;  
for i=1:n
    for j=1:n
        x(i,j)<=B(i,j);
        x(i,j)>=0;
    end
end
cvx_end


