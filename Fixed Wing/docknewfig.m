function docknewfig()
% DOCKNEWFIG Docks the figure in one single box

FIG = get(0,'Children');

set(FIG,'WindowStyle','Docked');

for kk = max(size(FIG)):-1:1
    figure(FIG(kk));
    pause(.01);
    hold on;
end

end
