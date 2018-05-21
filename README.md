# L1_AC
This is a project where an Adaptive Flight Control based on L1 adaptive control is designed and tested using MATLAB/Simulink
I started with a nonlinear aircraft model. The contained description is inside the simulink MATLAB/Function

Aircraft parameters (NOMINAL) are set by INIT.m 
The Aircraft is trimmed in some given condition in terms of TAS, and attitude (simply a steaty state level flight)
The TRIM.m script gives back the input needed to keep the aircraft in a given flight condition.
L1AC works in a linear systems representation, therefore the system is linearized around the trimmed condition.
The dynamics and control matrices A and B are extracted by "estrai.m"

The A and B matrices are then used by POLE_PLACEMENT.m to compute the feedback matrices K for LATERAL and LONGITUDINAL dynamics

The design of the control laws parameters is the job for the script TEST_NAVION and TEST_NAVION_LAT

PLOTTING.m plots the main state variables in single figures
PLOTTING2.m plots the main state variables in a subplot figure
PLOTTING3.m plots the main input variables in a subplot figure

SETUP.m run the above script all in onces and set some more variables

MONTECARLO runs different simulations in order to test system robustness, recalls plotting to compares the behaviour in different conditions.

19/01/2018 Some functions have been added that helps clean up plotting a bit

24/03/2018 Files have been moved into Fixed wing and Quad

Quad folder contains a first implementation for a Quadrotor: Quad implementation does not come with MONTECARLO scripts and robustness analysis yet.

29/04/2018 Files have been reorganized in order to be more readable. Furthermore a state space implementation of the transfer matrix has been used since it was deemed to be easier to manage (TEST_NAVION_LAT, TEST_NAVION_LONG).

21/05/2018 Scripts and functions have been cleaned up.

I hope that someone will eventually flight testing it in the real world.
