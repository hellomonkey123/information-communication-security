% The simulation of WS-smallworld network
% the algorithm of WS-smallworld's generation has been improved in speed,
% and tend to be easily understood
% writen by winter-my-dream@hotmail.com
% Example:
% N = 100; %network size (number of nodes)
% m = 6; %2*m is the average edges of each nodes
% p = 0.1; %rewiring probability
% matrix = small_world_WS_new(N,m,p);
function matrix = small_world_WS_new(N,m,p)
rng('default')
rng('shuffle')
matrix=zeros(N,N);
% generate regular network
for i=m+1:N-m
    matrix(i,i-m:i+m)=1;
end
for i=1:m
    matrix(i,1:i+m)=1;
end
for i=N-m+1:N
    matrix(i,i-m:N)=1;
end
for i=1:m
    matrix(i,N-m+i:N)=1;
    matrix(N-m+i:N,i)=1;
end
% rewiring the network
for i = 1:N
    % then rewiring the edges with the probability of p
    [series1,series2] = range_sort(N,m,i);
    index0 = series1(rand(2*m,1)>1-p);
    if(~isempty(index0))
        matrix(i,index0) = 0;
        matrix(i,series2(randperm(length(series2),length(index0))))=1;
    end
end
matrix = matrix -diag(diag(matrix));
end