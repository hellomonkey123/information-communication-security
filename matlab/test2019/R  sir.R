#等概率链接
#记得每次运行的时候需要初始化
rm(list=ls())
library("igraph")
b=matrix(0,nrow=3,ncol=3)
b[2,3]=1
b[1,2]=1
b[1,3]=1
b
xulie=c(1,2, 1,3, 2,3)
#u <- graph(xulie, directed=F)
#plot(u, layout=layout.fruchterman.reingold)

for(i in 3 :100){
b=rbind(cbind(b,rep(0,i)),rep(0,i+1))###这里的系数一个是i  一个是i+1
x=sample(1:i,1)
b[x,i+1]=1#  j代表抽到哪个数  假设4与2 建立连接
#这一块是补充为对称矩阵
for(k in 1:i) {
for(m in (k+1):(i+1)){
b[m,k]=b[k,m]
}
}
#which(a[,i+1]!=0)#余数后面要使用
xulie=c(xulie,i+1,which(b[,i+1]!=0))
u <- graph(xulie, directed=F)
#plot(u, layout=layout.fruchterman.reingold)
}
plot(u, layout=layout.fruchterman.reingold)
degree(u)
#————————————————————————————————————————————
#上面部分是构造初始的随机网络
max(degree(u))#度最大为
MaxPoint<-which(degree(u)==max(degree(u)))
#共同节点数（感染节点）
NumV=length(which(b[MaxPoint,]!=0))
#健康 节点为
NumH=100-length(which(b[MaxPoint,]!=0))
有效传播速率=x/y=NumV/NumH
x<-0.00869
y=0.2
for(cishu in 1:10){
#通过下面我们发现3的度是最大，3为最大度的节点
MaxPoint<-which(degree(u)==max(degree(u)))
#查看最大度节点和哪些节点链接 即共同节点的数量
NumV=length(which(b[MaxPoint,]!=0))
#计算健康节点的数量
NumH=100-length(which(b[MaxPoint,]!=0))
#假设其他节点以x概率与最大度节点链接，共同节点以y概率脱离链接。
#共101个节点  此时9个是感染节点 91个为健康节点
Numganran=floor(NumH*x)#为感染的人数  假设为10
Numkangfu=floor(NumV*y)#为康复的人数   假设为4
total=c(1:101)[-MaxPoint]
#这个地方应如下处理
#抽取感染的数需在健康个体里抽
ganranxulieid=which(b[MaxPoint,]!=0)
jiankangxulieid=which(b[MaxPoint,]==0)
#抽取健康的数 需要在感染个体里抽
sum1=sample(total[-ganranxulieid],Numganran)#要多抽取一个数 因为很可能抽到3  ，这是感染的数
sum2=sample(total[-jiankangxulieid],Numkangfu)#多抽一个数 表示健康的数
for(p in 1:Numganran){
b[MaxPoint,sum1[p]]<-1
b[sum1[p],MaxPoint]<-1
}
for(q in 1:Numkangfu){
b[MaxPoint,sum2[q]]<-0
b[sum2[q],MaxPoint]<-0
}
}#与for循环对应
#View(b)
#上面部分只是经过了十次的演化，下面是绘图
#下一步是如何从矩阵提取坐标数组 记住这个时候是对称矩阵

#化成方阵
b=b[-101,]
#换成上三角矩阵
for(i in 1:100 ){
for(j in 1:100){
if(i>=j){
b[i,j]=0
}else{
b[i,j]=b[i,j]
}
}
}

#求行
xulie2=c(which(b!=0)[1]%%100,round(which(b!=0)[1]/100,0)+1)
for(po in 2:length(which(b!=0))){
xulie2=c(xulie2,which(b!=0)[po]%%100,round(which(b!=0)[po]/100,0)+1)
#求列
#round(which(b!=0)[3]/100,0)+1
}
#绘制网络图
u <- graph(xulie2, directed=F)
plot(u, layout=layout.fruchterman.reingold)
degree(u)
#最开始的时候u是对称矩阵 所以在计算degree的时候会不会出错，这是个问题
