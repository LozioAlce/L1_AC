close all
set(0, 'DefaultFigureVisible', 'off');
set(groot, 'DefaultFigureVisible', 'off');
 cc=waitbar(1/(MAX_RUN+1))
 kkk=1
for ll=1:MAX_RUN+1
	


    BODY_Variables = BODY_Variables_RUNs(ll);
    ACTUATOR_TRUE = ACTUATOR_RUNs(ll);
  
    PLOTTING_SCRIPT
    if max(time)>199
        
        PLOTTING_SCRIPT2
        PLOTTING_SCRIPT3
        PLOTTING_SCRIPT4        
        
       
    end
    
   waitbar(ll/(MAX_RUN+1),cc);
end
set(groot, 'CurrentFigure', 14)

plot(time,Reference_Altitude_NOMINAL,'k','Linewidth',4)


AddLegend(MAX_RUN+1);HideFig
close(cc)
