%extracción y manipulación de los ángulos de la base y de la posicion en 
%en el plano vertical (r,z) del efector.

%si se han extraidos los datos en una misma sesión, los datos estáran en
%extructuras de la forma datosnº (datos, datos1, datos2, datos3 ...)
%calculamos, a partir de la posición del efector (x,y) cual sería la
%orientación horizonatal de brazo (angulo que forma con la posición de
%garaje del brazo)

%primero lo hacemos con la primera colección, guardada en datos, lo hacemos
%así simplemente por claridad.

%angulo de orientación horizontal
ang=atan2(datos.efector(:,2),datos.efector(:,1));
%añadimos la horientación final (objetivo) del efector como segunda entrada
%a la red 
ang=[ang(1:size(ang,1)-1) ang(size(ang,1)).*ones(size(ang,1)-1,1)];

%posición radial del efector
r=sqrt(datos.efector(:,1).^2+datos.efector(:,2).^2);
%añadimos la posición radial final(objetivo) 
r=[r(1:size(r,1)-1) r(size(r,1)).*ones(size(r,1)-1,1)];

%posión vertical del efector
z=datos.efector(:,3)
%añadimos la posición vertical final(objetivo)
z=[z(1:size(z,1)-1) z(size(z,1)).*ones(size(z,1)-1,1)];

%unimos todas las variables de entrada en una sola tabla...
rz=[r z]

%salida que la red para la base(hacia donde mover eje de giro de la base)
angcon=datos.angulo(:,1);

%salida de la red par el movimiento del resto de las articulaciones, (hacia
%donde mover el resto de las articulaciones)

angconhcm=datos.angulo(:,2:4);

%creamos unas nuevas estructuras para agrupar todos los datos de todos los
%ensayos. de este modo, podemos emplear una colección de datos única para
%entrenar la red, además tendremos las colecciones individuales de cada
%ensayo tambien preparadas para entrenar.
angt=ang;
angcont=angcon;
rzt=rz;
angconhcmt=angconhcm;

%Iniciamos un bucle para extraer los datos del resto es el mimo calculo de
%antes pero ahora usamos eval para poder modificar el nombre de la
%estructura que contiene los datos de cada ensayo
for i=1:size(who('datos*'),1)-1
    eval(['ang' num2str(i) '=' 'atan2(datos' num2str(i) '.efector(:,2),datos' num2str(i) '.efector(:,1));'])
    eval(['ang' num2str(i) '=[ang' num2str(i) '(1:size(ang' num2str(i) ',1)-1) ang'...
        num2str(i) '(size(ang' num2str(i) ',1)).*ones(size(ang' num2str(i) ',1)-1,1)];'])
    
    
    eval(['r' num2str(i) '= sqrt(datos' num2str(i) '.efector(:,1).^2 + datos' num2str(i) '.efector(:,2).^2)'])
    eval(['r' num2str(i) '=[r' num2str(i) '(1:size(r' num2str(i) ',1)-1) r'...
        num2str(i) '(size(r' num2str(i) ',1)).*ones(size(r' num2str(i) ',1)-1,1)];'])

    eval(['z' num2str(i) '= datos' num2str(i)  '.efector(:,3)']) 
    eval(['z' num2str(i) '=[z' num2str(i) '(1:size(z' num2str(i) ',1)-1) z'...
        num2str(i) '(size(z' num2str(i) ',1)).*ones(size(z' num2str(i) ',1)-1,1)];'])
    eval(['rz' num2str(i) '=[r' num2str(i) ' z' num2str(i) '];'])
    
    
    eval(['angcon' num2str(i) '=datos' num2str(i) '.angulo(:,1);'])
    
    eval(['angconhcm' num2str(i) '=datos' num2str(i) '.angulo(:,2:4);'])
    %de nuevo, creamos una estructura que acumule todos los ensayos
    %seguidos... 
    eval(['angt=[angt; ang' num2str(i) '];'])
    eval(['angcont=[angcont; angcon' num2str(i) '];'])
    eval(['rzt=[rzt; rz' num2str(i) '];'])
    
    eval(['angconhcmt=[angconhcmt; angconhcm' num2str(i) '];'])
end
%trasponemos los datos resultantes para que se los pueda tragar el
%entrenador de la toolbox de redes
angt=angt';
rzt=rzt';
angcont=angcont';
angconhcmt=angconhcmt';
        