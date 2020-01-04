clear;
clc;
% syms SS RR II LI LR a b c d e g P_I P_R
% f1=sym(-b*e*SS*((II+RR)*g+(II*(1-P_I )+RR* P_R )*(1-g))+d*(LR+LI)+a*(II+RR)+c*(LR*(1-P_R )+LI* P_I )==0)
% 
% f2=sym(-a*II+b*e*II* RR*(1-P_R-P_I )+c*(1-P_I )* LI+b*e*(1-g)*II* SS*(1-P_I )==0)
% f3=sym(-a*RR-b*e*II *RR*(1-P_R-P_I )+b*e*SS* RR* P_R* (1-g)+c*P_R* LR==0)
% f4=sym(-(c+d)* LR+b*e*g*SS* RR==0)
% f5=sym(-(c+d)* LI+b*e*g*SS* II==0)
% f6=sym(SS+RR+II+LI+LR==1)
% [SS, RR, II, LI, LR] = solve([f1,f2,f3,f4,f5,f6],[SS, RR, II, LI, LR])

% syms SS RR LR a b c d e g P_I P_R
% 
% f3=sym(SS+RR+LR==1)
% f1=sym(-(c+d)* LR+b*e*g*SS* RR==0)
% f2=sym(-a*RR+b*e*SS* RR* P_R* (1-g)+c*P_R* LR==0)
% [SS, RR, LR] = solve([f1,f2,f3],[SS, RR, LR])

% P_R+P_I >1ʱ
% SS = (a*c + a*d)/(P_R*b*c*e + P_R*b*d*e - P_R*b*d*e*g)
%  
% RR = -(a*c + a*d - P_R*b*c*e - P_R*b*d*e + P_R*b*d*e*g)/(P_R*b*c*e + P_R*b*d*e + a*b*e*g - P_R*b*d*e*g)
%  
% LR = -(a^2*c*g + a^2*d*g + P_R*a*b*d*e*g^2 - P_R*a*b*c*e*g - P_R*a*b*d*e*g)/(b*e*P_R^2*c^2 - 2*b*e*P_R^2*c*d*g + 2*b*e*P_R^2*c*d + b*e*P_R^2*d^2*g^2 - 2*b*e*P_R^2*d^2*g + b*e*P_R^2*d^2 + a*b*e*P_R*c*g - a*b*e*P_R*d*g^2 + a*b*e*P_R*d*g)
%  

syms SS II LI a b c d e g P_I P_R

f3=sym(-(c+d)* LI+b*e*g*SS* II==0)
f2=sym(-a*II+c*(1-P_I )* LI+b*e*(1-g)*II* SS*(1-P_I )==0)
f1=sym(SS+II+LI==1)
[SS, II, LI] = solve([f1,f2,f3],[SS, II, LI])

SS = (a*c + a*d)/(b*c*e + b*d*e - P_I*b*c*e - P_I*b*d*e - b*d*e*g + P_I*b*d*e*g)
 
 
II =  -(a*c + a*d - b*c*e - b*d*e + P_I*b*c*e + P_I*b*d*e + b*d*e*g - P_I*b*d*e*g)/(b*c*e + b*d*e - P_I*b*c*e - P_I*b*d*e + a*b*e*g - b*d*e*g + P_I*b*d*e*g)
 
 
LI = -(a^2*c*g + a^2*d*g - a*b*c*e*g - a*b*d*e*g + a*b*d*e*g^2 - P_I*a*b*d*e*g^2 + P_I*a*b*c*e*g + P_I*a*b*d*e*g)/(b*e*P_I^2*c^2 - 2*b*e*P_I^2*c*d*g + 2*b*e*P_I^2*c*d + b*e*P_I^2*d^2*g^2 - 2*b*e*P_I^2*d^2*g + b*e*P_I^2*d^2 - 2*b*e*P_I*c^2 + 4*b*e*P_I*c*d*g - 4*b*e*P_I*c*d - a*b*e*P_I*c*g - 2*b*e*P_I*d^2*g^2 + 4*b*e*P_I*d^2*g - 2*b*e*P_I*d^2 + a*b*e*P_I*d*g^2 - a*b*e*P_I*d*g + b*e*c^2 - 2*b*e*c*d*g + 2*b*e*c*d + a*b*e*c*g + b*e*d^2*g^2 - 2*b*e*d^2*g + b*e*d^2 - a*b*e*d*g^2 + a*b*e*d*g)
 
