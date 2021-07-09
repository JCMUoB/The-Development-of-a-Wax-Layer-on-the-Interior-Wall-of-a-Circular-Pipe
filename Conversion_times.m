% For batch creating all of graphs for consideration within the paper and
% the data table.

% First load the bulk parameters (importantly Nt, Nx and T).
% Other things defined in Parameters are over-written in the loops that
% follow.

Parameters;

% Set values of eps and k to be considered in epsb and kb.
% Also set the values of D(u) via optionb (row 1 are labels, row 2 define
% the Diffusivity functions and row 3 specifies the value of D0.

epsb        = [0.1,0.5,1]; %values of eps 
kb          = [10,20]; 
optionb     = [4;2;0.1]; %Diffusivity function 
                %[number;option in D;c value]

% The counter is just to indicate progress

counter = 1

%Define the summary data file

data    = zeros(size(kb,2)*size(epsb,2)*size(optionb,2),19);

% In the following loops graphs are generated concerning each of the cases
% of [IBVP*] for parameters in epsb, kb and optionb. Additionally summary
% data is computed concerning run time and convergence.

for kn=1:size(kb,2)
   
    k = kb(kn);
    
    for epsn=1:size(epsb,2)
    
        eps = epsb(epsn);
        
        for optionsn=1:size(optionb,2)
            
            %store the columns index for variables
            colindx = optionsn;
            
            tic
            
            option  = optionb(2,optionsn);
            D0      = optionb(3,optionsn);
            
            %Compute the steady state of v with k, eps and D(v) defined by
            %choices above            
            
            steadystate_v
            
            %Run the explicit finite difference method to compute the
            %numerical approximation to v            
            
            explicitmethod
            
            %Set the convergence times to be the upper time limit (to be
            %updated in a few lines).
            
            tvconv = T;
            thconv = T;

            %Set the index to indicate the convergence criteria to be the
            %upper time index (to be updated in a few lines).
            
            qvconv = Nt;
            qhconv = Nt;
            
            %Set the error (difference between steady vs and v) to be 0 (to
            %be updated in a few lines).
            
            errv = zeros(1,Nt);
            
            % These 2 loops calculate the difference of v and vs and
            % calculates the 'conversion time' for v.
            
            for q=1:Nt
                
                errv(q) = max(abs(v(q,:)-vs(:)'));
                              
            end
            
            for q=1:Nt
                
                if(abs(errv(q)) < 0.01)
                   
                    tvconv = t(q);
                    qvconv = q;
                    break;
                    
                end
            
            end
            
            %Set the error (difference between steady hs and h) to be 0 (to
            %be updated in a few lines).
            
            errh = zeros(1,Nt);
            
            % These 2 loops calculate the difference of h and h_s, and
            % the 'conversion time' for h.
                                    
            for q=1:Nt
                
                errh(q) = abs(h(q)-hs);
                               
            end
            
            for q=1:Nt
               
                if(abs(errh(q)) < 0.01)

                thconv = t(q);
                qhconv = q;
                break;

                end                
                
            end
            
            % Relative error calculation
            
            relerr      = errh(qhconv)/round(double(hs),3);
            relerrF     = errh(Nt)/round(double(hs),3);
            
            % Compute time taken to complete each item in the innermost 
            % loop
            
            elapsedtime = toc;
            
            % Update summary data
            
            data(counter,:) = [k,eps,optionb(1,optionsn),option,D0,h0, ...
                                round(double(hs),3),h(Nt),t0,tvconv, ... 
                                thconv,errv(qvconv),errv(Nt), ...
                                errh(qhconv), elapsedtime,Nx,relerr, ...
                                relerrF,errh(Nt)];               
            
            % Store t, h, v(:) for eps, k, D_i                
                            
            filename        = strcat('t_h_v_eps=',num2str(eps), ...
                                '_k=',num2str(k),'_D_', ...
                                num2str(optionb(1,optionsn)), ... 
                                '(u)=(',num2str(optionb(3,optionsn)), ...
                                ')+(1-(', ...
                                num2str(optionb(3,optionsn)),'))u.csv');
                                                        
            writematrix([t',h,v],filename);
            
            % Store steady state for eps, k, D_i
            
            filename        = strcat('X_vs_eps=',num2str(eps), ...
                                '_k=',num2str(k),'_D_', ...
                                num2str(optionb(1,optionsn)), ... 
                                '(u)=(',num2str(optionb(3,optionsn)), ...
                                ')+(1-(', ...
                                num2str(optionb(3,optionsn)),'))u.csv');
                                                        
            writematrix([X,vs'],filename);
                        
            counter = counter+1   
                        
            % Plot stuff and store images
           
            Plot_vvs;
            Plot_v;
            Plot_h;
            Plot_discrepancy;
            Plot_u
            
            %Tidy up un-required data
            clear errv errh tconv
            clear c1 c2 D0 D1 derD1 dt du du1 h h0 hnew hold m M M1 p ...
                    p1 p2 p3 pdt t0 tnew told unew uold ux uxx v v0 X;
            clear F FXmax hs m vs x X;
            clear filename elapsedtime relerr relerrF;
            
        end
        
    end
        
end

%Output Summary data

OutputData = array2table(double(data),'VariableNames',{'k','eps', ...
                'Option1','Option2','D_0','h_0','h_s','h(20)', ...
                't_0','tvconv','thconv', ...
                '||v(tvconv)-vs||_\infty','||v(Nt)-vs||_\infty', ...
                '|h(thconv)-h_s|','Elapsed_time','Nx', ...
                'rel err h(tconv)','rel err h(Nt)','errh(Nt)'});
            
writetable(OutputData,strcat('Summary_Data.csv'));
