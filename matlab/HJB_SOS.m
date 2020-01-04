function [Vold,Vnew,unew] = HJB_SOS(f,g,u1,q0,rx,Options)
% This function solves for a suboptimal solution to the HJB equation of a
% SECOND ORDER polynomial system. This function dependents on SOSTOOLS.
%
% Copyright 2013-2014 Yu Jiang
%
% Description 
% function [V0,Vnew,unew] = HJB_SOS(f,g,u1,q0,rx,Options)
% Input:
% f  := f(x1,x2)
% g  := g(x1,x2)
% q0 := weighting function Q(x1,x2)>0
% rx := weighting matrix R
% Options.Vdmax  := maximum degree of the Lyapunov function
% Options.itnum  := maximum number of iteration
% Options.Omg    := The most intersted area to have improved performance in the state space
%
% Ouput:
% Vold   := initial value function (if exists)
% Vnew := suboptimal solution to the HJB
% u    := suboptimal but GLOBALLY stabilizing control policy
%
%
% Example:
% syms x1 x2 real
% f = [x1*x2-x1^3-x1*x2*x2; x1 + 2*x2];
% q0 = x1^2+x2^2;
% r = 0.01*eye(2);
% g = [0 0.5; 0.5 0.1];
% u1 = [10.283*x1-13.769*x2; -10.7*x1-3.805*x2];
% Options.Vdmax = 4;
% Options.itnum = 20;
% Options.Omg = [-1,1,-1,1];
% HJB_SOS(f,g,u1,q0,r,Options)



% =============================================
% Feasibility test
syms x1 x2 real
vars = [x1;x2];
prog = sosprogram(vars);
[prog,V] = sospolyvar(prog,monomials([x1;x2],2:Options.Vdmax),'wscoeff');
myObj= int(int(V,Options.Omg(1),Options.Omg(2)),Options.Omg(3),Options.Omg(4));
prog = sosineq(prog,V-0.0001*(x1^2+x2^2));
expr = -[diff(V,x1) diff(V,x2)]*(f+g*u1)-q0;
prog = sosineq(prog,expr);
[prog, info] = sossolve(prog);
V0 = sosgetsol(prog,V);
Vold =V0;
u_prev = u1;

if info.pinf || info.dinf 
 error('HJBSOS: Problem Infeasible. Please double-check if the controller is stabilizing.');
end

% Policy iteration
for i=1:Options.itnum
	clear prog V
	prog = sosprogram(vars);
	[prog,V] = sospolyvar(prog,monomials([x1;x2],2:Options.Vdmax),'wscoeff');
	prog = sosineq(prog,V0-V);
	prog = sosineq(prog, V);
	u_prev = -1/2*inv(rx)*g'*[diff(V0,x1) diff(V0,x2)].';
	q = q0+u_prev'*rx*u_prev;
	expr = -[diff(V,x1) diff(V,x2)]*(f+g*u_prev)-q;
	prog = sosineq(prog,expr);
	prog = sossetobj(prog, myObj);
	prog = sossolve(prog);
	V0 = sosgetsol(prog,V)
end

Vnew = V0;
unew = u_prev;

end