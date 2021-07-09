%Plot of h vs t

hold on
fig = plot(t,h);
fig = plot(t,double(hs*ones(1,Nt)),'--');
xlabel('t');
ylabel('Y');
title(strcat('Y=h(t): eps=',num2str(eps),', k=',num2str(k), ... 
    ', D_',num2str(optionb(1,optionsn)),'(u)=(', ...
    num2str(optionb(3,optionsn)),')+(1-(', ...
    num2str(optionb(3,optionsn)),'))u, Nx=',num2str(Nx)));
hold off

filename = [strcat('(t,Y)=(t,h(t))_eps=',num2str(eps),'_k=', ... 
    num2str(k),'_D_',num2str(optionb(1,optionsn)),'(u)=(', ... 
    num2str(optionb(3,optionsn)),')+(1-(', ...
    num2str(optionb(3,optionsn)),'))u_Nx=',num2str(Nx),'.jpg')];
saveas(fig,filename);
close all;
clear fig;