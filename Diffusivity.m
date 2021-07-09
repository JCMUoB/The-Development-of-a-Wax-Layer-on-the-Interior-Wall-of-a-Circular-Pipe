function [D,derD] = Diffusivity(u,c,opt)

% u is the variable at which the function D is evaluated.
% c is a parameter used to define D.
% opt = 1, 2, 3 picks the case of Diffusivity function.

if(opt==1)
    
    D       = c;
    derD    = 0;
    
end

if(opt==2)
    
    D       = (1-c)*u+c;
    derD    = 1-c;

end

if(opt==3)
   
    D       = 1+c*u.*(1-u);
    derD    = c*((1-2.*u));
    
end
    
end