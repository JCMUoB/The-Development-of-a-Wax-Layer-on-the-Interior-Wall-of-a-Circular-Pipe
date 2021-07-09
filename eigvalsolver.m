% Eigenvalue solver

% Requires several pre-defined variables inluding us, hs, x and Lambda

% Set dx
dx      = hs/(Nx-1);

% Set the temporary eigenfunction (tempu)
tempu   = zeros(Nx,2);

% Set left boundary to be 1
tempu(1) = 1; 
tempu(2) = 1+ (dx*k)/Diffusivity(1/k,D0,option);
        
% Solve the ODE in the interior using a 4-th order Runge-Kutta Method

for p=3:Nx
   
    tempu(p)    = 2*tempu(p-1) - tempu(p-2) ... 
                - (dx^2)*eps*Lambda*tempu(p-1) ... 
                /Diffusivity(us(p-1),D0,option);
    
end

%Check right end condition

if((tempu(Nx)-tempu(Nx-1))/dx - Lambda*tempu(Nx) < 0)

    RBC     = -1;

else

    RBC     = 1;

end

% Check for tempu non-decreasing 1 if increasing, -1 if not.

% By default we set the variable to 1 and change it following a check.
% i.e. inc = 1 if increasing and -1 if not increasing.
inc = 1;

for p=2:Nx

    if(tempu(p)-tempu(p-1) < 0) 

        inc     = -1;

    end
    
end