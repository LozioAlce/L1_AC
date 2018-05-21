function [] = PrintAll2PDF()
%PRINTALL2PDF Summary of this function goes here
% Saves all figures in a PDF
PrevFolder = pwd;
if  isempty(dir('Immagini'))
    mkdir('Immagini')
    cd('Immagini')
else
    cd('Immagini')
end
NOMI = dir('*.pdf')
if ~isempty(NOMI)
    delete(NOMI.name);
end
FullScreen
FIG = get(0,'children');

NmaxFig = length(FIG);

for kk = 1:NmaxFig
    h = figure(FIG(kk)) ;
    NOME = h.Name;
    set(h,'PaperOrientation','landscape');
    set(h,'PaperUnits','normalized');
    set(h,'PaperPosition', [0 0 1 1]);

    print (NOME,'-dpdf','-painters', '-r1600')
end
cd(PrevFolder);
end
