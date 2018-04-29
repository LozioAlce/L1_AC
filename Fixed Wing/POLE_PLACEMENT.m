% this script execute the linearization of the model and the pole placement
% design
step_dxdu = 1e-9;
% Take the Jacobian matrix derivative numercally (could be done symboliccaly for better precision)
[A , B ]= linearizza ( @f_NAVION , stato_body(1:12) , trim_input , step_dxdu);
% sort out the matrix from the linearization
[ A_LONG , A_LATERAL , B_LONG , B_LATERAL , A_LONG_aug , B_LONG_aug , A_LATERAL_aug , B_LATERAL_aug ] = estrai( A , B );

figure(1)
%% computes the eigenvalues of A Longitudinal and Longitudinal
  ... augumented (augumented not used by L1)
subplot(2,3,1)

EIG_A_LONG=eig(A_LONG);
EIG_A_LONG_aug=eig(A_LONG_aug);

plot(real(EIG_A_LONG_aug),imag(EIG_A_LONG_aug),'or','Linewidth',2);grid on,hold on
plot(real(EIG_A_LONG),imag(EIG_A_LONG),'xgr','Linewidth',2);

title('Longitudinal Dynamics')
legend('A_{LONG_{aug}}','A_{LONG}')

%% computes the eigenvalues of A lateral and lateral
    ... augumented

subplot(2,3,4)
EIG_A_LATERAL=eig(A_LATERAL);
EIG_A_LATERAL_aug=eig(A_LATERAL_aug);

plot(real(EIG_A_LATERAL_aug),imag(EIG_A_LATERAL_aug),'or','Linewidth',2);
grid on,hold on
plot(real(EIG_A_LATERAL),imag(EIG_A_LATERAL),'xgr','Linewidth',2);
title('Lateral Dynamics')
legend('A_{LAT_{aug}}','A_{LAT}')

%% computes the gain matrices for longitudinal dynamics and lateral dynamic OK

pole_TARGET_LONG=EIG_A_LONG+[-2.5 -2.5 -2.5 -2.5]'; % shift all the eigenvalue to the LHS
K_LONG = place (A_LONG , B_LONG , pole_TARGET_LONG);

subplot(2,3,2)
plot ( real(EIG_A_LONG) , imag(EIG_A_LONG) ,' xgr' , 'Linewidth' , 2);
grid on,hold on
plot( eig (A_LONG - B_LONG*K_LONG), 'k+' , 'Linewidth' , 2);
hold on , grid on
legend('A_{LONG}','A_{LONG} K')
title('Longitudinal Dynamics with state feedback')

% pole_TARGET_LAT = EIG_A_LATERAL+[+7 -2.5 -2.5 -1.5]'+1; %%test
% pole_TARGET_LAT = EIG_A_LATERAL+[+8 -2.5 -2.5 -1.5]'+1; %%test
% pole_TARGET_LAT(1)= -.5;  %%test 2018 April
% pole_TARGET_LAT = [-1 -1.2 -1.3 -1.25]';

pole_TARGET_LAT = [-1 -1.1 -1.2 -.9]'; % TradeOff robustness and adaptation/stability speed
% pole_TARGET_LAT = [-1.3 -1.1 -1.2 -.9]'; % TradeOff robustness and adaptation/stability speed
% pole_TARGET_LAT = [-1 -1.1 -1.2 -.9]';
% pole_TARGET_LAT = EIG_A_LATERAL+[+7 -2.5 -2.5 -1.5]'+1; %%test 2018-may
K_LAT=place(A_LATERAL,B_LATERAL,pole_TARGET_LAT);

subplot(2,3,5)
plot ( real ( EIG_A_LATERAL ) , 0 , 'xgr' , 'Linewidth' , 2);
grid on , hold on
plot( eig ( A_LATERAL - B_LATERAL * K_LAT ),0, 'k+' , 'Linewidth' , 2);
hold on , grid on
legend('A_{LAT}','A_{LAT} K')
title('Lateral Dynamics with state feedback')
h = figure(1);
fprintf('Closing Window ...'),
pause(1),fprintf('...'),
pause(1),fprintf('... \n')
pause(10)
close(h)
