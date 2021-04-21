%Surface plots for u vs x and t

for qp=1:qvconv
up(qp,:)=v(qp,:);
tp(qp)=t(qp);
hp(qp)=h(qp);
end

X   = linspace(0,1,Nx);
Xvec = zeros(size(up,1),size(up,2));
for ki=1:qvconv
Xvec(ki,:)=X*h(ki);
end

hold on
xlabel('x');
ylabel('t');
zlabel('Y');
title(strcat('Surface plot of Y=u(x,t): eps=',num2str(eps), ...
   ', k=',num2str(k),' D_',num2str(optionb(1,optionsn)), ... 
   '(u)=1+(',num2str(optionb(3,optionsn)),')u(1-u), Nx=',num2str(Nx))); 
fig = surf(Xvec,tp,up);
view([-40.199999999999989,29.9416332866431]);
hold off

filename = [strcat('u(x,t)_Surface_eps=',num2str(eps),'_k=', ... 
            num2str(k),'_D_',num2str(optionb(1,optionsn)), ... 
            '(u)=1+(',num2str(optionb(3,optionsn)),')u(1-u))_Nx=', ...
            num2str(Nx),'.jpg')];
saveas(fig,filename);
close all;

clear tp up hp Xvec fig ki;