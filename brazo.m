function brazo
%% creamos una figura nueva, le asignamos un handle h y además definimos
%% cual va ha ser la función que va a ejecutar cuando pulsemos una tecla,
%% estando activa la figura
h=figure('KeypressFcn',@rplot);
rob=bracito;
rob.objeto=[];
%% para pintar una 'x' en el centro del efector 
datos.efector=rob.munecar.centro-1.5*rob.munecar.eje;
texto=num2str(rob.munecar.centro-1.5*rob.munecar.eje);
plot3(datos.efector(1),datos.efector(2),datos.efector(3),'x')
%% definimos un nueva estructura para guardar datos que manejaran los
%% modulo de fuzzy y de redes neuronales
datos.angulo=[];
pos.ini=datos.efector;
pos.fin=[];
pos.red.base=[];
pos.red.hombro=[];
pos.red.codo=[];
pos.red.mver=[];
pos.tolerancia=0.1;
pos.objeto=[];
pos.objetivo=[];
pos.hdl=[]
pos.fuzzy=[];
%% guardamos en el userdata de la figura los datos del robot y en el
%% userdata de los ejes los datos de las posiciones para redes y fuzzy
set(h,'UserData',{1,rob,datos})
set(gca,'Userdata',pos)
%% creamos una nueva barra de menus para poder manipular algunos parámetros
%% del robot
% Guarda datos de las posiciones del robot en el workspace o en archivo,
% permite reiniciar la captura de datos.
f = uimenu('Label','datos');
    uimenu(f,'Label','reiniciar captura','Callback','reini');
    uimenu(f,'Label','exportar datos al workspace','Callback','exporta');
    uimenu(f,'Label','guardar datos','Callback','guardar');
    % Específico para manejar redes neuronales que mueva el brazo siguiendo una
    % trayectoria específica
g = uimenu('Label','red');
    uimenu(g,'Label','Marcar posiciones efector','Callback','data');
    l=uimenu(g,'Label','Importar  redes');
    uimenu(l,'label','base','Callback','rednueva(''base'')');
    uimenu(l,'label','hombro','Callback','rednueva(''hombro'')');
    uimenu(l,'label','codo','Callback','rednueva(''codo'')');
    uimenu(l,'label','muñeca ver.','Callback','rednueva(''mver'')'); 
    uimenu(g,'Label','Tolerancia','Callback','tolerancia');
    uimenu(g,'Label','Movimiento automatico','Callback','atomov2');
j=  uimenu('Label','reset');
    uimenu(j,'Label','volver a la posicion de reposo','Callback','resetea');
    %fuzzy para el manejo del efector, genera un objeto para que lo coja el
    %robot, etc, etc
k=  uimenu('Label','fuzzy');
    uimenu(k,'label','generar objeto','Callback','nuevo')
    uimenu(k,'label','borrar objeto','Callback','destruir')
    uimenu(k,'label','importar un modelo fuzzy desde el workspace','Callback','impfuzzy')
    uimenu(k,'label','Activar efector','Callback','fuerza')
    % Aqui puedes añadir las llamadas a tus funciones fuzzy
%% Titulamos   
title(['Hombro Activo' '    efpos->    ' texto],'BackGroundColor',[1 1 1])
