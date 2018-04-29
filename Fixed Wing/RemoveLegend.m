function []=RemoveLegend()

FIG = get(0,'Children');
max_kk = max(size(FIG));


for kk =1 :max_kk
    h = figure(kk);
    set(h,'visible','off');
    legend(gca,'off');
end

end