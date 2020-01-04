function dy=func_SEIR(~,y)
global alpha beta0 beta1 gamma mu 
S = y(1);
E = y(2);
I = y(3);
tt = y(4);
x=beta0*(cos(2*pi*tt)*beta1+1);
dS = mu-x*S*I-mu*S;
dE = x*S*I-(mu + alpha)*E;
dI = alpha*E-(mu+gamma)*I;
ds = 1;
dy=[dS;dE;dI;ds];
end
