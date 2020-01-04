#记得每次运行的时候需要初始化
library("igraph")
a=matrix(0,nrow=3,ncol=3)
a[2,3]=1
a[1,2]=1
a[1,3]=1
a
xulie=c(1,2, 1,3, 2,3)
g <- graph(xulie, directed=F)
plot(g, layout=layout.fruchterman.reingold)

for(i in 3 :200){
a=rbind(cbind(a,rep(0,i)),rep(0,i+1))###这里的系数一个是i  一个是i+1
x=sample(1:i,1)
a[x,i+1]=1#  j代表抽到哪个数  假设4与2 建立连接
#这一块是补充为对称矩阵
for(k in 1:i) {
for(m in (k+1):(i+1)){
a[m,k]=a[k,m]
}
}
#which(a[,i+1]!=0)#余数后面要使用
xulie=c(xulie,i+1,which(a[,i+1]!=0))
g <- graph(xulie, directed=F)
plot(g, layout=layout.fruchterman.reingold)
}
#上面部分完成了等概率链接网络生成____________________________________________________________________________
#下面部分是不等概率网络生成
设置图形的参数
plot(g, layout=layout.fruchterman.reingold,vertex.size=12)
V(g)$color <- 'green'
E(g)$color <- 'red'
plot(g, layout=layout.fruchterman.reingold)
#度分布图
 plot(degree.distribution(g), xlab="node degree")
 lines(degree.distribution(g))
degree(g)
length(V(g))
length(E(g))
_____________________________________________________________________________
graph.density(g)
clusters(g)
transitivity(g, type="global")
edge.connectivity(g)
degree(g)
 # Closeness (inverse of average dist)
 closeness(g)
# Betweenness
 betweenness(g)
 # Local cluster coefficient
 transitivity(g, type="local")
 # Eigenvector centrality
 evcent(g)$vector
 # Now rank them
 order(degree(g))
order(closeness(g))
 order(betweenness(g))
order(evcent(g)$vector)



