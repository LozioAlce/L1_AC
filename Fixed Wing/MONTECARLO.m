tic,close all,clear,warning off

addpath(genpath('..')) % Add current Folder to the path, otherwise would not find some function and files
Ts =0.01; % Controller frequency 100Hz=0.01s, Simulation step is Ts/10 (CTRL+E in Simulink file)
MONTECARLO_EXE = 1; % Only simulate the Nominal parameter set
OUTPUT_DISTURBANCE = 0; %%Add sinusoidal to input/output
INPUT_DISTURBANCE = 0;  %%Add sinusoidal to input/output
VARIANCE = diag([ones(12,1)])*1e-8; %% if you want to test it againt noisy measurements
MAX_RUN = 5; % How many runs do you want to perform?
UncertantiesParameters = 25/100; % Parameter variation
InputCrossCoupling = 5/100; % CrossCoupling in the inputs
ThrustReduction = 30/100; % Max Thrust Reduction in percentage

model_name = dir('*.slx');
model_name = model_name.name ; model_name = strrep(model_name,'.slx','');
open(model_name)

set_param(model_name,'FixedStep','Ts/10');
pause(1)
close_system
%
V_trim = 60; % define trim speed
SETUP % Run Nominal Parameter simulation and setup of the L1AC control system :) !!!
%%
ACTUATOR_NOMINAL = ACTUATOR_TRUE; % save nominal input history [de da dr dt]
BODY_Variables_NOMINAL =  BODY_Variables; % save nominal output history [u v w p q r phi theta psi x y z]

pause(.1)
warning off; % stop annoying warning error messages

max_figure=findall(0,'type','figure'); % find all open figure
max_figure = max(size(max_figure));

% print "nominal" in all the figures
for ii=1:max_figure
    figure(ii)
    legend('NOMINAL')
end
%
FIG = get(0,'Children'); % find all the figures and axes
set(FIG,'Visible','off'); % set it invisible so we speed things up

PARAMETERS_AC_old = PARAMETERS_AC; % old aircraft parameter, NOMINAL stored an on top add the parameter uncertanties
omega_true=eye(4);                 % omega_NOMINAL
kk=0;                              % index of the failed parameter

PARAMETRI_SIMULATI = zeros(33,MAX_RUN); % Preallocate the parameter
PARAMETRI_SIMULATI_FAIL_INDEX = zeros(10,1); %

% initialize the RUNs where the variable are stored
ACTUATOR_RUNs(MAX_RUN) = ACTUATOR_TRUE;
BODY_Variables_RUNs(MAX_RUN) =  BODY_Variables;
cc1 = waitbar(0/(MAX_RUN),'simulation running'); % show a progressingbar saying the simulation is running

for ii = 1:MAX_RUN % RUN MAX_RUN simulation with different PARAMETERS_AC +-30% of the nominal , Cmalpha can be even unstable!! and it recovers
    omega_true=eye(4);
    % uncertainties in the Parameter describing the aircraft dynamic
    PARAMETERS_AC_MONTECARLO = PARAMETERS_AC_old + UncertantiesParameters * PARAMETERS_AC_old .*rand(size(PARAMETERS_AC)).*sign(randn(size(PARAMETERS_AC)));
    PARAMETERS_AC_MONTECARLO(1) = PARAMETERS_AC_old(1); % gravity g does not change

    PARAMETERS_AC_MONTECARLO(2) = 1.225 - 1.225*UncertantiesParameters*rand(1); % density varies only in negative sense
    %     SIGN = 1;
    %     PARAMETERS_AC_MONTECARLO(9) = rand(1).*SIGN; %CLde; the sign would change omega too much and goes outside the assumption of omega diagonally dominant and does not change its sign
    %     PARAMETERS_AC_MONTECARLO(24) = rand(1)*SIGN; %Cmde

    PARAMETERS_AC_MONTECARLO(22) = rand(1).*sign(randn(1));      % Cmalpha also unstable
    PARAMETERS_AC_MONTECARLO(15) = abs(1-abs(ThrustReduction*rand(1)))*Tmax;  % maximum thrust available reduced up to 30%
    OMEGA_MONTECARLO = omega_true+randn(4,4)*InputCrossCoupling;              % add cross coupling up to 10 % per control channel

    %     OMEGA_MONTECARLO(1:3,4) =0;
    %     OMEGA_MONTECARLO(4,1:3) =0;
    %     OMEGA_MONTECARLO(4,4) =1;
      SETUP_MONTECARLO;   % RUN the simulation simulation with the new data/parameter
    % store all the actuator and body history
    ACTUATOR_RUNs(ii) = ACTUATOR_TRUE;
    BODY_Variables_RUNs(ii) =  BODY_Variables;

    PARAMETRI_SIMULATI(:,ii)=PARAMETERS_AC_MONTECARLO ;         % store all the parameters
    waitbar(ii/MAX_RUN,cc1);                                    % update the waitbar
    if max(time)<199                                            % if the simulation aborted store the parameter that triggered the singularities
        kk=kk+1                                                 % add the counter
        PARAMETRI_SIMULATI_FAIL(:,kk) = PARAMETERS_AC_MONTECARLO; % store the failure one separately
        %     PARAMETRI_SIMULATI_FAIL_INDEX(ii) = 1;
    end
end
close(cc1); % close the waitbar

BODY_Variables_RUNs(MAX_RUN+1)=BODY_Variables_NOMINAL; % store at the end the body variable NOMINAL
ACTUATOR_RUNs(MAX_RUN+1) = ACTUATOR_NOMINAL;

%% save all the time hystory in v7.3 because   otherwise could crash!!! Do not know why
NOME = datestr(now) ;
NOME = strrep(NOME,':','_')
save(NOME,'BODY_Variables_RUNs','ACTUATOR_RUNs','PARAMETRI_SIMULATI','Reference_Altitude');%,'-v7.3');
%%
clear all,close all, clear force all % to clean everything and then reload what you have just saved
warning off
NOME = dir('*.mat*'); % load the latest most recent mat file
NOME = NOME(end).name;
load(NOME);
% Label of all parameters
LABEL_NEXT = {'g', 'rho', 'c', 'b', 'S', 'CL_0', 'CL_{alpha}', 'CL_{eq}', 'CL_{de}', 'CD_0', 'AR', 'e', 'CY_{beta}', 'CY_{dr}', ...
    'T_{max}', 'Cl_{beta}', 'Cl_p', 'Cl_r', 'Cl_{da}', 'Cl_{dr}', 'Cm_0', 'Cm_{alpha}', 'Cm_{eq}', 'Cm_{de}' ...
    ,'Cn_{beta}',  'Cn_p', 'Cn_r' ,'Cn_{da}' ,'Cn_{dr}' ,'m', 'Ixx', 'Iyy', 'Izz' };

MAX_RUN = max(size(BODY_Variables_RUNs))-1; % BODY_Variables_RUNs is a time series of 1x(MAX_RUN -1) variable run
%
PLOT_ALL % state and control variable

MAX_PARAM = 33; % Total number of parameters
for ii =1:MAX_PARAM % for each parameter
    h = figure;
    FIG = get(0,'Children');
    set(FIG,'Visible','off'); %plot in invisible mode

    for kk = 1:MAX_RUN % for each simulation
        plot(kk-1,PARAMETRI_SIMULATI(ii,kk),'^','LineWidth',2),hold on,grid on,grid minor
        title (LABEL_NEXT{ii}) % set the title as the name of the parameter
    end
    set(h,'Name',LABEL_NEXT{ii},'NumberTitle','off') % change name of the figure itself not only the title!!!
    title (LABEL_NEXT{ii})
end
% AddLegend(MAX_RUN)
%     clear
FIG = get(0,'Children'); % find all figure
set(FIG,'Visible','off'); % make all figure invisible
docknewfig
%     UnDockAll
FullScreen % set all figure full screen automatically
pause(10)
%\\
% RemoveLegend
% docknewfig

%     SaveFig
% Finished play music
toc
load handel % play aleluia song to wake me up
sound(y,Fs)
