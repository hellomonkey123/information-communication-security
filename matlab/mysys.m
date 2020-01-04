function dx = mySusp(t,x,f,g,u)
x1 = x(1);
x2 = x(2);
dx = eval(f+g*u);
end