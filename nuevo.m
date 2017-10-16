function nuevo
%base
guar=get(gcf,'UserData')
pos=get(gca,'UserData')
if isempty(pos.objeto)
rob=guar{2};
centro=rob.munecar.centro-rob.munecar.eje;
theta=0:0.1.*pi:2*pi;
rbase=0:0.05:0.25;
[rbm,tm]=meshgrid(rbase,theta);
xbm=rbm.*cos(tm);
ybm=rbm.*sin(tm);
h1=surf(xbm+centro(1),ybm+centro(2),centro(3)+0.5.*ones(size(xbm)));
hold on
r2=0.25.*ones(1,11);
[rpm,tpm]=meshgrid(r2,theta);
xpm=rpm.*cos(tpm);
ypm=rpm.*sin(tpm);
h2=surf(xpm+centro(1),ypm+centro(2),+centro(3)+ones(size(xpm))*diag(-0.5:0.1:0.5));
h3=surf(xbm+centro(1),ybm+centro(2),centro(3)-0.5.*ones(size(xbm)));
pos.objeto.h=[h1 h2 h3]
pos.objeto.peso=100.*rand;
pos.objeto.fmax=100.*rand;
pos.objeto.rugosidad=1.*rand;
pos.objeto.centro=centro;
pos.objeto.eje=[1 1 1];
set(gca,'UserData',pos)
else
    errordlg('ya hay un objeto creado, es necesario borrarlo antes de crear uno nuevo','error')
end