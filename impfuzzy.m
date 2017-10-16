function impfuzzy
t=evalin('base','whos');
varn={t.name};
varc={t.class};
tfuzzy=strcmp('struct',varc);
if all(tfuzzy==0)
    modelos='no hay ningun modelo fuzzy en el workspace';
else
    modelos={varn{tfuzzy}};
    for i=1:size(modelos,2)
        gaita(i)=isfield(evalin('base',modelos{i}),'defuzzMethod')
    end
end
    mandani={modelos{gaita}}
[s,v] = listdlg('PromptString','Seleccionar una red',...
                'SelectionMode','single',...
                'ListString',mandani);
pos=get(gca,'UserData');
pos.fuzzy=evalin('base',mandani{s})
set(gca,'UserData',pos);

