%% Plot all the variable
close all
set(0, 'DefaultFigureVisible', 'off');
set(groot, 'DefaultFigureVisible', 'off');
cc=waitbar(1/(MAX_RUN+1),'Plotting everything');
kkk=1;
for ll=1:MAX_RUN+1
    BODY_Variables = BODY_Variables_RUNs(ll);
    ACTUATOR_TRUE = ACTUATOR_RUNs(ll);
    PLOTTING_SCRIPT % plot everything in a different figure
    if max(time)>199
        PLOTTING_SCRIPT2 % plot time variable all in one figure [V alpha beta p q r phi theta psi]
        PLOTTING_SCRIPT3 % plot input
        PLOTIING_SCRIPT4 % plot altitude
    end
    waitbar(ll/(MAX_RUN+1),cc);
end

set(groot, 'CurrentFigure', 12);
plot(time,-Reference_Altitude.data,'k','Linewidth',2) %% Reference_Altitude = -h Ref
% AddLegend(MAX_RUN);
Legenda = get(gca,'legend');
try
    LegendaNew = [Legenda.String  ,'Reference'];
    legend(LegendaNew);
end
HideFig;
close(cc)
