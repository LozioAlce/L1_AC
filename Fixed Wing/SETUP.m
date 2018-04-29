% this script runs everything is needed to setup
clc
% close all
INIT % set parameters

alpha_trim =0;
beta_trim =0;

TRIM % trim the aircraft
%%
POLE_PLACEMENT % define the nominal closed loop by pole  placement
%
x0 = stato_trim_body;

x0(12) = 10; %% initial Altitude
x0(11) = 0;  %% initial East Component

target_point = stato_trim_body;   %% where we want to trim the A/C

target_point(12) = 0; % altitude we want to reach

folder = pwd;

TEST_NAVION_LONG % AC LONGITUDINAL L1 AC design
%%
TEST_NAVION_LAT % %  AC LATERAL L1 AC design

close all

cd(folder)

Ts_delay = 1*Ts; %Ts = 0.01 Nominally .It used in simulation in ...
...  the controller Zero-Order-Hold to represent delay
    
% psi_reference = 15*pi/180;    %% psi we want to follow
target_point(9) = 10*pi/180;  %%Psi Target: target coincides with psi of the reference path

x0(9)=-0.0*pi/180;              %%initial psi

% NOMINAL CASE
%
omega_true = eye(4);% can add for example mismatches representing crosscoupling +0.05.*rand(4,4)
PARAMETERS_AC(2) = rho*7/8; %  nominal density 7/8 1.225
PARAMETERS_AC_old = PARAMETERS_AC;

sim('Copy_3_of_L1AC_NAVION_Latest3') %Name of the file that run the simulation
hold on
% ll=1; %% for some reason I dont remember was here
PLOTTING_SCRIPT % plot state variable
PLOTTING_SCRIPT2 % plot state variable in a custom subplot
PLOTTING_SCRIPT3 % plot input history
figure(14),hold on,grid on
plot(time,h)     % plot altitude vs time
%%     Robustness to parameter uncertanties [fixed not randomized]
if ~exist('MONTECARLO_EXE') %% performs only if the script is not in a MONTECARLO ROBUSTNESS TEST (just a trick to reuse the same script)
    AR =(1.5*b)^2/(S*2);   e=0.7;
    
    PARAMETERS_AC = [g rho*4/8 c b*1.5 S*2 CL_0/2 CL_alpha*1.6 CL_eq*.8 CL_de*2 CD_0*2 AR e CY_beta*2 CY_dr*4 ...
        Tmax*.7 Cl_beta*1 Cl_p*1 Cl_r*0.3 Cl_da*.3 Cl_dr*.4 Cm_0 Cm_alpha*-1 Cm_eq*1 Cm_de/1 ...
        Cn_beta*-1  Cn_p*0.2 Cn_r*.1 Cn_da*1 Cn_dr m*1.75 Ixx*.7 Iyy*.7 Izz*1.5 ];
    
    omega_true = eye(4);
    
    sim (model_name) % File of the simulation
    
    
    hold on
    PLOTTING_SCRIPT
    if max(time)>199 %% PLOTS only if simulation ends before a singularities (in order to speed up tuning of controller and PID  and investigate parameter variation that can be handled safely)
        PLOTTING_SCRIPT2
        PLOTTING_SCRIPT3
        legend('No parameter uncertanties','With Parameter Uncertanties')
        figure(14),hold on,grid on
        plot(time,h)
        legend('No parameter uncertanties','With Parameter Uncertanties')
        xlabel('Time [sec]')
        ylabel('Altitude error [m]')
    end
    
    max_figure=findall(0,'type','figure');
    if exist('IMAGE_FOLDER')
        cd IMAGE_FOLDER %% Probably won't work to be removed
        % print images high  quality
        for i = 1:max(size(max_figure))
            
            figure(i)
            frame_h = get(handle(gcf),'JavaFrame');
            set(frame_h,'Maximized',1);
            print(['MONTECARLO',num2str(i)],'-depsc','-r600')
            
        end
    end
    cd(folder)
end
