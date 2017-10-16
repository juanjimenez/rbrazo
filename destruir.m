function destruir
pos=get(gca,'UserData');
if ~isempty(pos.objeto)
    handles=pos.objeto.h
    delete(handles(1))
    delete(handles(2))
    delete(handles(3))
    pos.objeto=[];
    set(gca,'UserData',pos)
end
datos=get(gcf,'UserData')
rob=datos{2};
if ~isempty(rob.objeto)
    rob.objeto=[];
    datos{2}=rob;
    set(gcf,'UserData',datos)
end


