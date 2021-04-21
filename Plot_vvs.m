% Plot v vs v(T,:) to observe convergence (numerically)

hold on;
fig = plot(X,v(Nt,:),'--');
plot(X,vs,':+');
xlabel('X');
ylabel('Y');
legend({strcat('Y(X) = v(',num2str(t(Nt)),',X)'),'Y(X) = vs(X)'}, ...
    'Location','northwest');
title(strcat('Convergence to steady state: eps=',num2str(eps), ...
    ', k=',num2str(k),', D_',num2str(optionb(1,optionsn)),'(u)=1+(', ... 
    num2str(optionb(3,optionsn)),')u(1-u), Nx=',num2str(Nx)));    
hold off;

filename = [strcat('Steady_States_eps=',num2str(eps),'_k=', ... 
            num2str(k),',_D_',num2str(optionb(1,optionsn)), ...
            '(u)=1+(',num2str(optionb(3,optionsn)),')u(1-u), Nx=', ... 
            num2str(Nx),'.jpg')];    
saveas(fig,filename);
close all;
clear fig;