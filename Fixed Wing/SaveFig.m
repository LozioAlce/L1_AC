function SaveFig()
% SaveFig() save figure in eps format for quality printing in Latex
FIG = get( 0 , 'Children' );
for kk = max ( size (FIG) ): -1 : 1
%     IF you want full screen when printing
%     POS = get(FIG(kk),'paperposition');
%     set ( FIG(kk),'paperposition',[0 0 POS(3:4)],'Papersize',[POS(3:4)]),pause(.1)
%     pause(1)
    h = figure(FIG(kk))
    legend(gca,'off')
    print -depsc2 -painters  -r1600 %-loose

end
end
