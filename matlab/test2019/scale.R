 #————————————————————————————————————————————————————
library("igraph")
a=matrix(0,nrow=3,ncol=3)
a[2,3]=1
a[1,2]=1
a[1,3]=1
a
xulie=c(1,2, 1,3, 2,3)
g <- graph(xulie, directed=F)
plot(g, layout=layout.fruchterman.reingold)

for(i in 3 :500){
a=rbind(cbind(a,rep(0,i)),rep(0,i+1))###这里的系数一个是i  一个是i+1

#在这一块插入如何选择和谁链接
c=apply(a,2,sum)
d=sum(apply(a,2,sum))
e=c/d
x=sample(1:(length(e)-1),1,replace = T ,prob =e[1:(length(e)-1)])#非概率抽样
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
degree(g)
