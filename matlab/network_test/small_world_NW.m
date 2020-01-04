% 基于Matlab 的小世界网络仿真
% 经过矩阵化修改后，生成速度已经大大加快
function matrix = small_world_NW(N,m,p)
% N=50;m=3;p=0.1;
% matrix=sparse([]);
matrix = zeros(N,N);
for i=m+1:N- m
    matrix(i,i- m:i+m)=1;
end
for i=1:m
    matrix(i,1:i+m)=1;
end
for i=N- m+1:N
    matrix(i,i- m:N)=1;
end
for i=1:m
    matrix(i,N- m+i:N)=1;
    matrix(N- m+i:N,i)=1;
end
% Random add edge
kk=(rand(N,N)<p);
matrix = logical(matrix + kk);
matrix = matrix - diag(diag(matrix));