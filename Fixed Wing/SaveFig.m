function SaveFig()
FIG = get( 0 , 'Children' );
% FullScreen
for kk = max ( size (FIG) ): -1 : 1
%     POS = get(FIG(kk),'paperposition');
%     set ( FIG(kk),'paperposition',[0 0 POS(3:4)],'Papersize',[POS(3:4)]),pause(.1)
%     pause(1)
    h = figure(FIG(kk))
    legend(gca,'off')
    print -depsc2 -painters  -r1600 %-loose
    
%     NOME = ['FIGURA_',num2str(kk)];
%     print2eps(NOME,h,110);
end
end
