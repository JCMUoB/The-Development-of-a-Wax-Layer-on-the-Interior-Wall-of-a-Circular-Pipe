%Steady state approximation

% Under specific circumstances (including some considered in the paper) the
% inverse of F can be symoblically represented (take care to choose the
% correct branch of the symbolically computed inverse.

%Parameters;

%!!! Remember to uncomment Parameters when not running this in bulk !!!

%Declare symbol variables for the integration

syms x;

%F calculates the indefinite integral, which in this case, is eqivalent to
%the integral from 0 to x of the diffusivity function.

F = int(Diffusivity(x,D0,option),x);

%Calculate the inverse function of F. For simple functions one can
%use Finv = finverse(F,x); . This is at best ... not reliable
%since it picks out incorrect branhes, etc. Instead of the 3 lines above, 
%a bisection method is used to numerically approximate the inverse of F.

X       = linspace(0,1,Nx);
vs      = zeros(Nx,1);
hs      = subs(F,1) - subs(F,1/k);
FXmax   = subs(F,1);
vs(1)   = 1/k;

for m=2:Nx
   
    %set domain value for F inverse coresponding to index m of v_s.
    
    ytemp = (hs*X(m)) + subs(F,1/k);
        
    %Calculate F inverse evaluated at X(m)*hs+F(1/k) via a bisection
    %method.
    
    Xtemp = 1/2;
    bstep = 1/4;
    
    p=1;
    
    while p<20
       
       if(ytemp > subs(F,Xtemp))
            
            Xtemp = Xtemp + bstep;
            bstep = bstep/2;
            p=p+1;
           
        else
            
            Xtemp = Xtemp - bstep;
            bstep = bstep/2;
            p=p+1;
        end
        
    end
    
    %update vs and clear unreuqired variables. 
    
    vs(m)= Xtemp;
    clear Xtemp ytemp bstep p;
    
end