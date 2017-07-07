%%     Robustness to parameter uncertanties

PARAMETERS_AC = PARAMETERS_AC_MONTECARLO; % to re use the other script
omega_true = OMEGA_MONTECARLO;

sim ('L1AC_NAVION_Latest3')
hold on
PLOTTING_SCRIPT 
if max(time)>199
    PLOTTING_SCRIPT2
    PLOTTING_SCRIPT3
    
    figure(14),hold on,grid on
    plot(time,h)

    xlabel('Time [sec]')
    ylabel('Altitude error [m]')
end