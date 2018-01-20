function [] = FullScreen()
FIG = get(0,'Children');

for kk = max(size(FIG)):-1:1
    figure(FIG(kk))
    set(FIG(kk),'units','normalized','outerposition',[0 0 1 1])
end

end
