function [series1,series2] = range_sort(N,m,i)
% select the index of nodes in row i for rewiring
if(i-m>0 && i+m<=N)
    series1 = i-m:i+m;
    series2 = setdiff(1:N,series1);
elseif(i-m<=0)
    series1 = [1:i+m,N-m+i:N];
    series2 = setdiff(1:N,series1);
else
    series1 = [1:m-N+i,i-m:N];
    series2 = setdiff(1:N,series1);
end
% Without considering the connection of diagonal elements
series1(series1==i) = [];
end