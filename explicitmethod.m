% Wax Deposition code (Explicit Method)

%Parameters;
% !!! When running this in a batch, remember to comment out the
% 'Parameters' line above. If running as a 1-off then uncomment it. 

%Set Grid Spacing (or number of grid nodes) and time to iterate to

dx = 1/(Nx-1);

% Set parameter(s) in the BVP and t0

[D1,derD1] = Diffusivity(1,D0,option);

% Now choose t0.
c1 = 2*(((eps*(k-1)+k)*k)^(-1));
% c1 denotes a condition on t0 so that the h0 approximation is valid.
c2 = abs(2*(eps*(k-1) + (derD1*k))^(-1));
% c2 denotes a condition on t0 so that the v0 approximation is valid.
t0 = min([c1,c2,(T/100)])/10;
% The condition on t0 ensures that the second order terms in the
% representations of h0 and v0 are, at least, a factor of 10 smaller than
% the order 1 terms. 

% From k, eps and t0, the initial data for u and h is set to be...

%(t^2 accurate)
h0=(k-1)*t0-((k/2)*(k-1)*(eps*(k-1)+k))*(t0^2);
X = linspace(0,1,Nx);
v0 = 1 + k*h0*(X-1)-(1/2)*(h0^2)*((eps*k*(k-1) - derD1*k^2)*((X-1).^2));

% Calculate step size so that the method remains 'stable' for small t.

U = linspace(0,1,1001);

[P,derP] = Diffusivity(U,D0,option); 

M = max(P);
M1 = max(abs(derP));

dt = min([((h0*dx)^2)*eps/(2*M),dx*h0/(k-1),(dx^2)/2, ((dx*h0)^2)*2*eps/(M1),(T-t0)/(20*Nt)]);

clear P derP U;

% Commence the numerical method

vold    = v0;
hold    = h0;
told    = t0;

% Storage arrays 

p       = 1; % counter for storing v and h
v       = zeros(Nt,Nx);
v(p,:)  = vold;
h       = zeros(Nt,1);
h(p)    = h0;
t       = linspace(t0,T,Nt);
p       = p+1;
pdt     = 1; %counter for updating the timesetep (helps for small t0 case).

while(p < Nt+1)

    % Declare vnew

    vnew        = zeros(1,Nx);
    
    % Apply RHS boundary condition to vnew
    
    vnew(Nx)    = 1;    
    
    % Determine hnew

    hnew = hold + dt*(((vold(Nx)-vold(Nx-1))/(dx*hold))-1);

    %Determine vnew in the interior of the domain

    for m=2:Nx-1
   
        [du,du1]    = Diffusivity(vold(m),D0,option);
        ux          = (vold(m+1)-vold(m-1))/(2*dx);
        uxx         = (vold(m-1)-(2*vold(m))+vold(m+1))/(dx^2);
   
        p1  = du*uxx;
        p2  = eps*X(m)*((hnew-hold)/dt)*hold*ux;
        p3  = du1*(ux^2);
   
        vnew(m)     = vold(m) + (dt/(eps*(hold^2)))*(p1+p2+p3);
   
    end
    
    % Apply LHS boundary condition to vnew
    
    vnew(1)     = vnew(2)-(dx/Diffusivity(vnew(2),D0,option))*hnew*k*vnew(2);
    
    %Update t

    tnew = told + dt;
    
    %If statement stores data and updates dt
    
    if (tnew >= t(p) && told <= t(p))
        
       h(p)     = hnew;
       v(p,:)   = vnew;
       t(p)     = tnew;
       %p
       p        = p+1;
       pdt      = 0;        
       
       dt = min([((hnew*dx)^2)*eps/(2*M),dx*hnew/(k-1),(dx^2)/2, ((dx*hnew)^2)*2*eps/(M1),(T-t0)/(20*Nt)]);       
       
    end

    %update all variables for the next loop
    
    told = tnew;
    hold = hnew;
    vold = vnew;
    pdt = pdt +1;    
    
    % Condition for updating the timestep
    
    if (pdt>500)
        
       dt   = min([((hnew*dx)^2)*eps/(2*M),dx*hnew/(k-1),(dx^2)/2, ((dx*hnew)^2)*2*eps/(M1),(T-t0)/(20*Nt)]); 
       pdt  = 1;
       
    end
        
end