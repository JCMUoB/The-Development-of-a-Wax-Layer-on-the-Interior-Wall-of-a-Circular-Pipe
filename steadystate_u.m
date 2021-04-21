%Steady state approximation

% Under specific circumstances (including some considered in the paper) the
% inverse of F can be symoblically represented (take care to choose the
% correct branch of the symbolically computed inverse.

syms x;

F = int(Diffusivity(x,D0,option),x);
%F calculates the indefinite integral, which in this case, is eqivalent to
%the integral from 0 to x of the diffusivity function.

%Finv = finverse(F,x);
%Calculate the inverse function of F. This is at best ... not reliable
%since it picks out incorrect branches, etc. 

%Instead of the 3 lines above, a bisection method is used to numerically
%approximate the inverse of F.

hs      = subs(F,1) - subs(F,1/k);
x       = linspace(0,hs,Nx);
us      = zeros(Nx,1);
FXmax   = subs(F,1);
us(1)   = 1/k;

for m=2:Nx
   
    ytemp = x(m) + subs(F,1/k);
    %set domain value for F inverse coresponding to index m of u_s.
    
    %Calculate F inverse evaluated at X(m)*hs+F(1/k) via a bisection
    %method.
    
    xtemp = 1/2;
    bstep = 1/4;
    
    p=1;
    while p<20
       
       if(ytemp > subs(F,xtemp))
            
            xtemp = xtemp + bstep;
            bstep = bstep/2;
            p=p+1;
           
        else
            
            xtemp = xtemp - bstep;
            bstep = bstep/2;
            p=p+1;
        end
        
    end
    
    %update vs and clear unreuqired variables. 
    us(m)= xtemp;
    clear xtemp ytemp bstep p;
    
end