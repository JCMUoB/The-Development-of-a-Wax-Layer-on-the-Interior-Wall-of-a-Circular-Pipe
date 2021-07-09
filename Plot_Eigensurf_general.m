% Plot the Eigenvalue Surface

% The values of epsb and kb used to plot the eigenvalues should match those
% generated in the data file called below.

epsb        = [0.005,0.01,0.03,0.05,0.075,0.1,0.15,0.2,0.25,0.3,0.35, ...
                0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95, ...
                1]; 
                %values of eps 
kb          = [1.02,1.04,1.06,1.08,1.1,1.12,1.14,1.16,1.18,1.2,1.3, ...
                1.4,1.5,1.6,1.7,1.8,1.9,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5, ...
                7,7.5,8,8.5,9,9.5,10,11,12,13,14,15,16,17,18,19,20];
                %values of k

%Import Data                
T = readtable('0_Eigval_data_c=0.7.csv');                
S=table2array(T);
clear T

for i1=1:44
 
    for i2=1:24

        SF(i1,i2) = (S(24*(i1-1)+i2,6) + S(24*(i1-1)+i2,7))/2;

    end
    
end

surf(epsb,kb,SF)
xlabel('\epsilon');
ylabel('$k$','interpreter','latex');
xlim([0.005,1]);
xticks([0.1,0.5,1]);
ylim([1.02,20]);
yticks([1.02,2,10,20]);
zlim([min(min(SF)),max(max(SF))]);
zticks([min(min(SF)),1,max(max(SF))]);
view([1.105000001054893e+02,28.419304986515904]);
set(gca,'fontsize',16)
