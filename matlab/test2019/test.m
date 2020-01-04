%create the small world network
%initial parameter
n = 5000;
k = 3;
p = 0.1;
mat = zeros(n);
%initial the circle
for i=1:n
   for j=i+1:i+k
      jj = j;
      if jj>n
         jj = mod(jj,n); 
      end
      mat(i,jj)=1;mat(jj,i)=1;
   end
end
%create weak connection
for i=1:n
   for j=i+1:i+k
      jj = j;
      if jj>n
          jj = mod(jj,n);
      end
      p1 = rand(1);
      if p1<p
         mat(i,jj)=0;mat(jj,i)=0;
         mat(i,i) = inf;
         a = find(mat(i,:)==0);
         r = randi(length(a));
         jjj = a(r);
         mat(i,jjj)=1;mat(jjj,i)=1;
         mat(i,i)=0;
      end
   end
end

xa = zeros(n*n,1);
ya = zeros(n*n,1);
k=1;
for i=1:n
   for j=1:n
      if mat(i,j)==1
         xa(k)=i;
         ya(k)=j;
         k=k+1;
      end
   end
end
scatter(xa,ya)

state = zeros(n,1);
sus = 1;
infe = 2;
recov = 3;
t = zeros(n,1);
ti = 4;
tr = 5;
to = ti+tr;
inip = 0.1;
%initialize the infection
for i=1:n
   r = rand(1);
   if r<inip
       state(i) = infe;
       t(i) = 1;
   else
      state(i) = sus;
      t(i) = 0;
   end
end
%begin infection
period = 1000;
rate = zeros(period,1);
for k=1:period
   cnt = 0;
   for i=1:n
       if t(i)==0
           neigh = find(mat(i,:)==1);
           neighn = length(neigh);
           neighi = length(find(state(neigh)==infe));
           prob = neighi/neighn;
           r = rand(1);
           if r<prob
               t(i) = 1;
           else
               t(i) = 0;
           end
       elseif t(i)>=1 && t(i)<to
           t(i) = t(i)+1;
       elseif t(i)==to
           t(i) = 0;
       end

       if t(i) == 0
           state(i) = sus;
       elseif t(i)>=1 && t(i)<=ti
           state(i) = infe;
           cnt=cnt+1;
       else
           state(i) = recov;
       end

   end
   rate(k) = cnt/n;

end
for i=1:period
   plot(1:1:k, rate(1:k));
   hold on 
end
