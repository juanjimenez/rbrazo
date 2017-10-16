function data
c=get(gcf,'UserData');
rob=c{2};
posact=rob.munecar.centro-1.5*rob.munecar.eje;
pos=get(gca,'UserData');
respuesta = inputdlg({'Posicion inicial','Posicion final'},'Introducir posiciones',1,{num2str(posact),num2str(pos.objetivo)});

if ~isempty(respuesta)
    pos.ini=str2num(respuesta{1}); %si se introduce a mano esto puede dar problemas
    pos.objetivo=str2num(respuesta{2});
    if isempty(pos.hdl)
        pos.hdl=plot3(pos.objetivo(1),pos.objetivo(2),pos.objetivo(3),'*r')
    else
        set(pos.hdl,'XData',pos.objetivo(1),'YData',pos.objetivo(2),'Zdata',pos.objetivo(3))
    end
    set(gca,'UserData',pos)

end