function atomov2
masc=[0 1 2 3 4];
art=1;
c=get(gcf,'UserData');
rob=c{2};
datos=c{3};
pos=get(gca,'UserData');
tt=get(gcf,'UserData');
activo=tt{1};
if isempty(pos.objetivo)
    data
    pos=get(gca,'UserData');
    if isempty(pos.objetivo)
        return
    end
end
if isa(pos.red.base,'network')&isa(pos.red.hombro,'network')&isa(pos.red.codo,'network')&&isa(pos.red.mver,'network')                                         
    ini=pos.ini;
    artic={'base','hombro','codo','munecav','munecar'};
    n=0;
    dbaseini=atan2(pos.ini(2),pos.ini(1));
    dbasefin=atan2(pos.objetivo(2),pos.objetivo(1));
    rini=sqrt(pos.ini(1)^2+pos.ini(2)^2);
    rfin=sqrt(pos.objetivo(1)^2+pos.objetivo(2)^2);
    zini=pos.ini(3);
    zfin=pos.objetivo(3);
    angulos=zeros(1,4)


    while (sqrt((dbaseini-dbasefin).^2)>pos.tolerancia)|abs(rini-rfin)>pos.tolerancia|abs(zini-zfin)>pos.tolerancia
        angulos(1)=sim(pos.red.base,[dbaseini;dbasefin]);
        angulos(2)=sim(pos.red.hombro,[rini;zini;rfin;zfin;angulos(2:4)']);
        angulos(3)=sim(pos.red.codo,[rini;zini;rfin;zfin;angulos(2:4)']);
        angulos(4)=sim(pos.red.mver,[rini;zini;rfin;zfin;angulos(2:4)']);
        angulos=round(angulos)
        d=find(angulos~=0)

        if isempty(d)
            break
        end
        for j=1:size(d,2)
            rob=rotador(rob,artic{d(j)},angulos(d(j)));
            drawnow
            pos.ini=rob.munecar.centro-1.5*rob.munecar.eje;
            dbaseini=atan2(pos.ini(2),pos.ini(1));
            rini=sqrt(pos.ini(1)^2+pos.ini(2)^2);
            zini=pos.ini(3);
            datos.efector=[datos.efector;pos.ini];
            datos.angulo=[datos.angulo;angulos];
            %if masc(d)>1
            %    activo=masc(d);
            %end
            set(gcf,'UserData',{art,rob,datos})
            set(gca,'UserData',pos)
            %leyenda(activo)
        end
    end
else
    datosred=[isa(pos.red.base,'network') isa(pos.red.hombro,'network') isa(pos.red.codo,'network') isa(pos.red.mver,'network')];
    index=find(datosred==0);
    texto={'Falta una red para la base' 'Falta una red para el hombro' 'Falta una red para el codo' 'Falta una red para el hombro'}

    falta={texto{index}};
    errordlg(falta,'Error');

end