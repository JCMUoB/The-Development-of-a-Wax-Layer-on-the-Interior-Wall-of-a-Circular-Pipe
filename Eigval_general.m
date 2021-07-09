%Eigenvalue solver

% First load the bulk parameters: Nx and ETol

Nx      = 161;
Etol    = 0.001; %difference between max-min in bisection method
ps      = 0.1; %positive step size in initial eigval search.

% Set values of eps and k to be considered in epsb and kb.
% Also set the values of D(u) via optionb (row 1 are labels, row 2 define
% the Diffusivity functions and row 3 specifies the value of D0.

epsb        = [0.005,0.01,0.03,0.05,0.075,0.1,0.15,0.2,0.25,0.3,0.35, ...
                0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95, ...
                1]; 
                %values of eps 
kb          = [1.02,1.04,1.06,1.08,1.1,1.12,1.14,1.16,1.18,1.2,1.3, ...
                1.4,1.5,1.6,1.7,1.8,1.9,2,2.5,3,3.5,4,4.5,5,5.5,6, ...
                6.5,7,7.5,8,8.5,9,9.5,10,11,12,13,14,15,16,17,18,19,20]; 
optionb     = [1;2;0.1]; %Diffusivity function

% The counter is just to indicate progress

counter = 1

%Define the summary data file. Requires columns for k, eps, number, D
%option, D0, Eigmin, Eigmax, inc, RBCeval, ETol, Elapsed time  

data    = zeros(size(kb,2)*size(epsb,2)*size(optionb,2),12);

% In the following loops graphs are generated to indicate the eigenvalue
% solver has worked.

for kn=1:size(kb,2)

 k = kb(kn);
    
    for optionsn=1:size(optionb,2)
         
        %store the columns index for variables
        colindx = optionsn;
        
        option  = optionb(2,optionsn);
        D0      = optionb(3,optionsn);            
            
        %Compute the steady state of u
        steadystate_u
        
        for epsn=1:size(epsb,2)    
            
            tic
            
            eps = epsb(epsn);
                        
            % Set initial bounds on Lambda        
            Lambdamin   = 0;
            Lambdamax   = (1/eps)*((pi/hs)^2);
            Lambda      = 0;
            
            % 
            while (Lambdamax == (1/eps)*((pi/hs)^2))
               
                eigvalsolver
                
                if(inc == -1)
                    
                    Lambdamax = Lambda;
                    
                end
                
                if(inc == 1 && RBC == 1)
                    
                    Lambdamin   = Lambda;
                    Lambda      = Lambda + ps;
                    
                end
               
                if(inc == 1 && RBC == -1)
                    
                    Lambdamax   = Lambda;
                                        
                end
                
            end
                       
            % To increase accuracy run another bisection method
            
           while (Lambdamax - Lambdamin > Etol)
               
                eigvalsolver
                
                if(inc == -1)
                    
                    Lambdamax   = Lambda;
                    Lambda      = (Lambdamax + Lambdamin)/2;
                    
                end
                
                if(inc == 1 && RBC == 1)
                    
                    Lambdamin   = Lambda;
                    Lambda      = (Lambdamax + Lambdamin)/2;
                    
                end
               
                if(inc == 1 && RBC == -1)
                    
                    Lambdamax   = Lambda;
                    Lambda      = (Lambdamax + Lambdamin)/2;
                    
                end
                
            end
            
            RBCeval     = (tempu(Nx)-tempu(Nx-1))/dx - Lambda*tempu(Nx);
            
            elapsedtime = toc
            
            data(counter,:) = [k,eps,optionb(1,optionsn),option,D0, ...
                            Lambdamin,Lambdamax,inc,RBCeval,Etol,ps, ... 
                            elapsedtime];       
            
            counter     = counter + 1
                        
        end
        
    end
    
end

% Output data

OutputData = array2table(double(data),'VariableNames',{'k','eps', ...
                'Option1','Option2','D_0','Lambdamin','Lambdamax', ...
                'Increasing','RBDeval','ETol','ps','Elapsed Time'});
            
writetable(OutputData,strcat('Summary_Data.csv'));
