function leyenda(d)
x=1;
c=get(gcf,'Userdata');
f=get(gca,'Userdata');
if (isfield(f,'objeto'))
if (isempty(f.objeto))&&(isempty(f.objetivo))
    x=1;
elseif(isempty(f.objeto))&&(~isempty(f.objetivo))
    x=2;
elseif(~isempty(f.objeto))&&(isempty(f.objetivo))
    x=4;
else
    x=5;
end
end
rob=c{2};
a=rob.munecar.centro-1.5*rob.munecar.eje;
t=get(gca,'Children');
set(t(x),'XData',a(1),'YData',a(2),'Zdata',a(3)) %aqui estamos pintando el desplazamiento del centro del efector...
texto=num2str(a);
mensaje={'hombro activo','Codo Activo','Muñeca vertical activo','Muñeca rotacion activo','pinza activa'};
colorin=[1 1 1;0 1 0;0 1 1;1 1 0];
title([mensaje{d},'    efpos->    ',texto],'Color',[0 0 0],'BackGroundColor',colorin(d,:))
   
