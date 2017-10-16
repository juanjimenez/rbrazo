function fuerza
pos=get(gca,'UserData')
if isempty(pos.fuzzy)
    errordlg('No hay ningun modelo fuzzy cargado','error')
    return
end




if ~isempty(pos.objeto)
objeto=pos.objeto
fnec=objeto.peso./objeto.rugosidad;

fefector=evalfis([objeto.peso; objeto.rugosidad; objeto.fmax],pos.fuzzy)
if fefector>=fnec
    datos=get(gcf,'UserData')
    rob=datos{2}
    rob.objeto=pos.objeto
    %Aquí abría que añadir una condición de rotura del carcharro si la
    %fuerza se pasa de objeto.fmax.... a lo mejor basta un mensaje, este
    %trozo te  lo dejo a ti, que ya esta bien
  
    datos{2}=rob;
    set(gcf,'UserData',datos)

end
else
  errordlg('No hay ningun objeto para agarrar con la pinza','error')  
end

