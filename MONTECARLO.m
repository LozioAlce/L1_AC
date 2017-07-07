close all,clear
MONTECARLO_EXE =1; %% montecralo is running do not override AC parameters
SETUP
%%

max_figure=findall(0,'type','figure');
max_figure = max(size(max_figure));
% Set nominal to First
for ii=1:max_figure
    figure(ii)
    legend('NOMINAL')
end

PARAMETERS_AC_old = PARAMETERS_AC; % old aircraft parameter, NOMINAL stored to then add the parameter uncertanties
omega_true=eye(4);                 % omega_NOMINAL 
kk=0;

for ii=1:10                        % RUN 100 simulation with different PARAMETERS_AC +-30% of the nominal (even gravity has been changed), Cmalpha can be even unstable!! and it recovers
    omega_true=eye(4)
    PARAMETERS_AC_MONTECARLO = PARAMETERS_AC_old *0.3.*rand(size(PARAMETERS_AC))+PARAMETERS_AC_old;
    PARAMETERS_AC_MONTECARLO(22)=randn(1);
    PARAMETERS_AC_MONTECARLO(15)=abs(1-abs(0.3*rand(1)))*Tmax;  % maximum thrust available reduced up to 30%
    OMEGA_MONTECARLO = omega_true+rand(4,4)*0.1;                % add cross coupling uo to 0.1 % per control channel
    SETUP_MONTECARLO;                                           % RUN a simulation and plot the new data
    PARAMETRI_SIMULATI(:,ii)=PARAMETERS_AC_MONTECARLO ;         % store all the parameters
    ii
    if max(time)<199                                            % if the simulation aborted store the parameter that triggered the singularities
        kk=kk+1
        PARAMETRI_SIMULATI_FAIL(:,kk) = PARAMETERS_AC_MONTECARLO;
    end
end

% plot parameters variability

figure(20),hold off

LABEL_NEXT = {'g', 'rho', 'c', 'b', 'S', 'CL_0', 'CL_alpha', 'CL_eq', 'CL_de', 'CD_0', 'AR', 'e', 'CY_beta', 'CY_dr', ...
        'Tmax', 'Cl_beta', 'Cl_p', 'Cl_r', 'Cl_da', 'Cl_dr', 'Cm_0', 'Cm_alpha', 'Cm_eq', 'Cm_de' ...
        ,'Cn_beta',  'Cn_p', 'Cn_r' ,'Cn_da' ,'Cn_dr' ,'m', 'Ixx', 'Iyy', 'Izz' }

for ii =1:max(size(PARAMETRI_SIMULATI))
    figure

    plot(PARAMETRI_SIMULATI(ii,:),'*'),hold on
    title (LABEL_NEXT{ii})
end
    