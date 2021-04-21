%Surface plots for v vs X and t

for qp=1:qvconv
vp(qp,:)=v(qp,:);
tp(qp)=t(qp);
end

hold on
xlabel('X');
ylabel('t');
zlabel('Y');
title(strcat('Surface plot of Y=v(X,t): eps=',num2str(eps), ...
   ', k=',num2str(k),', D_',num2str(optionb(1,optionsn)), ... 
   '(u)=1+(',num2str(optionb(3,optionsn)),')u(1-u), Nx=',num2str(Nx))); 
fig = surf(X,tp,vp);
view([-40.199999999999989,29.9416332866431]);
hold off

filename = [strcat('v(X,t)_Surface_eps=',num2str(eps),'_k=', ... 
            num2str(k),'_D_',num2str(optionb(1,optionsn)), ... 
            '(u)=1+(',num2str(optionb(3,optionsn)),')u(1-u))_Nx=', ...
            num2str(Nx),'.jpg')];
saveas(fig,filename);
close all;

clear tp vp fig;