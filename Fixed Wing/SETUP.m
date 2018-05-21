% This script runs everything is needed to setup the A/C and Controls
clc

INIT % set parameters of the A/C: Navion

% Define some condition where you want the a/c to be trimmed at (V_trim)
alpha_trim = 0;
beta_trim = 0;

TRIM % trim the aircraft
%% Define the control laws: Lateral and Longitudinal separately
POLE_PLACEMENT % define the nominal closed loop by pole  placement

TEST_NAVION_LONG  % AC LONGITUDINAL L1 AC design
TEST_NAVION_LAT   % AC LATERAL L1 AC design

%% Setup some initial condition X0 and target conditions
x0 = stato_trim_body;   %% Initial condition = Trim Conditions
x0(12) = 10;            %% initial Altitude
x0(11) = 0;             %% initial East Component (position)
x0(9)=-0.0*pi/180;      %% Initial Psi

target_point = stato_trim_body;     %% where we want to trim the A/C (can be different than x0)
target_point(12) = 0;               %% altitude we want to reach
target_point(9) = -45*pi/180;       %% Psi Target: target coincides with psi of the reference path
try
    target_point(1) = target_speed; % If it is defined elsewhere , inside MONTECARLO.m  use that one otherwise go on with default/ as initial/trim condition to reach (see the simulink model)
end

%%
close all
Ts_delay = 1*Ts; %Ts = 0.01 Nominally .It used in simulation in ...
...  the controller Zero-Order-Hold to represent delay

%% NOMINAL CASE

omega_true = eye(4);        % can add for example mismatches representing crosscoupling +0.05.*rand(4,4)
PARAMETERS_AC(2) = rho*7/8; %  nominal density 7/8 1.225
PARAMETERS_AC(2) = rho*8/8; %  test 1st may
PARAMETERS_AC_old = PARAMETERS_AC;

sim(model_name) %Name of the file that run the simulation
hold on

PLOTTING_SCRIPT  % plot state variable
PLOTTING_SCRIPT2 % plot state variable in a custom subplot
PLOTTING_SCRIPT3 % plot input history
PLOTTING_SCRIPT4

% figure(14) , hold on , grid on
% plot( time , h )  % plot altitude vs time
