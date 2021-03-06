clc; clear all
%%%% Analisis de iteraciones
data = readtable('iteraciones.xlsx');
% Valores de referencia
ref.desp = data.Desplazamiento(1);
ref.carga = data.CargaCriticaPandeo(1);
ref.ply = data.IndicesFalloPLY(1);
ref.masa = data.Masa(1);
% Valores porcentaje de cambio
cambio.desp = (data.Desplazamiento-ref.desp)/ref.desp*100;
cambio.carga = (data.CargaCriticaPandeo-ref.carga)/ref.carga*100;
cambio.ply = (data.IndicesFalloPLY-ref.ply)/ref.ply*100;
cambio.masa = (data.Masa-ref.masa)/ref.masa*100;

cambio_M = [cambio.desp,cambio.carga,cambio.ply,cambio.masa];
%% Plots
color = [120,94,240;...
         220, 38,127;...
         135,227,253;...
         255,176,0]./255;
% Figure desplazamiento     
f = figure();
name = {'Referencia';'Anillo Inferior';'Anillo Superior';...
        'Anillo Int. 1';'Anillo Int. 2'; 'Anillo Int. 3';...
        'Verticales';'Helicoidales'};
h = bar(data.Desplazamiento,0.3);
h(1).FaceColor = color(1,:);
axis([0 9 0.4 0.48]) 
grid on
set(gca,'xticklabel',name)
set(gca,'TickLabelInterpreter','Latex');
% xlabel('Iteraciones')
ylabel('Desplazamiento [mm]')
Save_as_PDF(f,'Desplazamientos' ,'vertical');

%% Figure carga     
f = figure();
name = {'0';'1';'2';'3';'4';'5';'6';'7'};
h = bar(data.CargaCriticaPandeo,0.3);
h(1).FaceColor = color(2,:);
axis([0 9 0.95 1.2]) 
set(gca,'xticklabel',name)
grid on
set(gca,'xticklabel',name)
set(gca,'TickLabelInterpreter','Latex');
xlabel('Iteraciones')
ylabel('\xi_c')
Save_as_PDF(f,'Carga_Critica' ,'vertical');

%% Figure PLY     
f = figure();
name = {'0';'1';'2';'3';'4';'5';'6';'7'};
h = bar(data.IndicesFalloPLY,0.3);
h(1).FaceColor = color(3,:);
axis([0 9 0.1 0.35]) 
set(gca,'xticklabel',name)
grid on
set(gca,'xticklabel',name)
set(gca,'TickLabelInterpreter','Latex');
xlabel('Iteraciones')
ylabel('\xi_c')
Save_as_PDF(f,'PLY' ,'vertical');

%% Figure Masa     
f = figure();
name = {'0';'1';'2';'3';'4';'5';'6';'7'};
h = bar(data.Masa,0.3);
h(1).FaceColor = color(4,:);
axis([0 9 115 123]) 
grid on
set(gca,'xticklabel',name)
set(gca,'TickLabelInterpreter','Latex');
xlabel('Iteraciones')
ylabel('Masa [g]')
Save_as_PDF(f,'Masa' ,'vertical');

%% Histogramas
f= figure();
h = bar(cambio_M(2:end,:),0.7,'FaceColor',"flat");
hold on
xlabel('Iteraciones')
ylabel('Cambio porcentual [%]')
%colormap cool
for k = 1:size(cambio_M,2)
    h(k).CData = color(k,:);
end
set(gca,'TickLabelInterpreter','Latex');
set(gca,'xticklabel',name(2:8))
legend(h,'Desplazamiento','Carga cr??tica',...
                         '??ndice de fallo PLY','Masa','Location','Best')
Save_as_PDF(f,'Cambios_Iteraciones' ,'vertical');