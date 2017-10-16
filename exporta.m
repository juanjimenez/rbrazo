function exporta
suck=get(gcf,'UserData');
datos=suck{3};
nombre=genvarname('datos',evalin('base','who'));
assignin('base',nombre,datos);
helpdlg(['los datos acumulados se han guardado en la estructura ' nombre '.  Datos exportados al workspace'],'Aviso')