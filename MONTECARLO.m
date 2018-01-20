close all,clear
MONTECARLO_EXE =1; %% montecralo is running do not override AC parameters
kkk=1
SETUP
clear kkk
ACTUATOR_NOMINAL = ACTUATOR_TRUE;
BODY_Variables_NOMINAL =  BODY_Variables;
Reference_Altitude_NOMINAL = - Reference_Altitude.Data;
%
pause(.1)
warning off;

max_figure=findall(0,'type','figure');
max_figure = max(size(max_figure));
% Set nominal to First

warning off;pause(1), 
%
for ii=1:max_figure
    figure(ii)
    legend('NOMINAL')
end
%
    FIG = get(0,'Children');
    set(FIG,'Visible','off');

PARAMETERS_AC_old = PARAMETERS_AC; % old aircraft parameter, NOMINAL stored to then add the parameter uncertanties
omega_true=eye(4);                 % omega_NOMINAL 
kk=0;
PARAMETRI_SIMULATI = zeros(33,10);
PARAMETRI_SIMULATI_FAIL_INDEX = zeros(10,1);

MAX_RUN = 25;
ACTUATOR_RUNs(MAX_RUN) = ACTUATOR_TRUE;
BODY_Variables_RUNs(MAX_RUN) =  BODY_Variables;
    cc1=waitbar(0/(MAX_RUN),'simulation running');

for ii=1:MAX_RUN                       % RUN 100 simulation with different PARAMETERS_AC +-30% of the nominal (even gravity has been changed), Cmalpha can be even unstable!! and it recovers
    omega_true=eye(4);
%     PARAMETERS_AC_MONTECARLO = PARAMETERS_AC_old *0.3.*rand(size(PARAMETERS_AC))+PARAMETERS_AC_old;
    PARAMETERS_AC_MONTECARLO = PARAMETERS_AC_old + PARAMETERS_AC_old./3 .*rand(size(PARAMETERS_AC)).*sign(randn(size(PARAMETERS_AC)));
    PARAMETERS_AC_MONTECARLO(1) = PARAMETERS_AC_old(1);
    PARAMETERS_AC_MONTECARLO(2) = 1.225 + 1.225/2 *rand(1).*sign(randn(1)); % density
    PARAMETERS_AC_MONTECARLO(2) = 1.225 - 1.225/1.4 *rand(1); % density
%     SIGN = 1;
%     PARAMETERS_AC_MONTECARLO(9) = rand(1).*SIGN; %CLde;
%     PARAMETERS_AC_MONTECARLO(24) = rand(1)*SIGN; %Cmde

    PARAMETERS_AC_MONTECARLO(22)= rand(1).*sign(randn(1)); % Cmalpha
    PARAMETERS_AC_MONTECARLO(15)=abs(1-abs(0.4*rand(1)))*Tmax;  % maximum thrust available reduced up to 30%
    OMEGA_MONTECARLO = omega_true+randn(4,4)*0.15*0;                % add cross coupling uo to 0.1 % per control channel
    
%     OMEGA_MONTECARLO(1:3,4) =0;
%     OMEGA_MONTECARLO(4,1:3) =0;
%     OMEGA_MONTECARLO(4,4) =1;
    SETUP_MONTECARLO;                                           % RUN a simulation and plot the new data
    
    ACTUATOR_RUNs(ii) = ACTUATOR_TRUE;
    BODY_Variables_RUNs(ii) =  BODY_Variables;
   
    PARAMETRI_SIMULATI(:,ii)=PARAMETERS_AC_MONTECARLO ;         % store all the parameters
    waitbar(ii/MAX_RUN,cc1);
    if max(time)<199                                            % if the simulation aborted store the parameter that triggered the singularities
        kk=kk+1
        PARAMETRI_SIMULATI_FAIL(:,kk) = PARAMETERS_AC_MONTECARLO;
%     PARAMETRI_SIMULATI_FAIL_INDEX(ii) = 1;
    end
end
close(cc1)

BODY_Variables_RUNs(MAX_RUN+1)=BODY_Variables_NOMINAL;
ACTUATOR_RUNs(MAX_RUN+1) = ACTUATOR_NOMINAL;

save(datestr(now),'BODY_Variables_RUNs','ACTUATOR_RUNs','PARAMETRI_SIMULATI','Reference_Altitude_NOMINAL','-v7.3');
%%
clear all,close all
NOME = dir('*mat*');
NOME = NOME(end).name
load(NOME)

LABEL_NEXT = {'g', 'rho', 'c', 'b', 'S', 'CL_0', 'CL_{alpha}', 'CL_{eq}', 'CL_{de}', 'CD_0', 'AR', 'e', 'CY_{beta}', 'CY_{dr}', ...
        'T_{max}', 'Cl_{beta}', 'Cl_p', 'Cl_r', 'Cl_{da}', 'Cl_{dr}', 'Cm_0', 'Cm_{alpha}', 'Cm_{eq}', 'Cm_{de}' ...
        ,'Cn_{beta}',  'Cn_p', 'Cn_r' ,'Cn_{da}' ,'Cn_{dr}' ,'m', 'Ixx', 'Iyy', 'Izz' }    
    
MAX_RUN = max(size(BODY_Variables_RUNs))-1;
    
PLOT_ALL
clear BODY_Variables_RUNs ACTUATOR_RUNs ACTUATOR_TRUE
    
    %%
    MAX_PARAM = 33;
    for ii =1:MAX_PARAM
        h = figure
        FIG = get(0,'Children');
        set(FIG,'Visible','off');
        
        for kk = 1:MAX_RUN
            plot(kk-1,PARAMETRI_SIMULATI(ii,kk),'^','LineWidth',2),hold on,grid on
            title (LABEL_NEXT{ii})
             
            set(h,'Name',LABEL_NEXT{ii},'NumberTitle','off')  
            
        end
        title (LABEL_NEXT{ii})
        
    end
    AddLegend(MAX_RUN)
%%
%     clear
    FIG = get(0,'Children'); 
    
    set(FIG,'Visible','off');
    docknewfig
%     UnDockAll
%     FullScreen
    pause(1)
%     SaveFig
%     RemoveLegend
