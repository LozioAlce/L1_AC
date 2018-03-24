function SaveFig()
FIG = get( 0 , 'Children' );

for kk = max ( size (FIG) ): -1 : 1
   h = figure(FIG(kk))
    legend(gca,'off')
    print -depsc2 -painters  -r1600 %-loose
end
end
