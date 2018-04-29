function AddLegend(N_MAX)
% Add legends as Nominal + N_MAX
FIG = get(0,'Children');

stringa2 = ['legend(''','NOMINAL','''',','];

for kk =1:N_MAX
	stringa2 = [stringa2,'''','DATA _ ',num2str(kk),'''',','];
end

stringa2(end) = ')';


for kk = max(size(FIG)):-1:1
%     figure(FIG(kk))
    set(groot, 'CurrentFigure', FIG(kk));

    eval(stringa2);
end
