%% This script load the matrices of the navion and setup what is neeeded for the simulink ...
% ... take the structure from the example of pag 170 that is working

Am = A_LONG-B_LONG*K_LONG; % [u w q theta]_dot=A_LONG*[u w q theta]'
Bm=B_LONG;

C = [1 0 0 0
     0 0 0 1];

x0_new = zeros(1,max(size(Am))); % Assigned to the start status of the estimator

omega0 = eye(2); % nominal omega matrix in x_dot = Ax+Bm(omega u +d)+Bum u
s = tf('s');

D = 1/(.25*s+1); % May 2018 Test ok tuned

D = D*eye(2);
% construct the unmatched matrix
Bum = [ 0 -Bm(3,1) Bm(2,1) Bm(2,1) ;0 -Bm(3,1) Bm(2,1) -Bm(2,1)]'; % not control channel
Bum'*Bm ==0; % chech it is zero. Necessary condition 

B = [Bm Bum]; % rebuild the control matrix

rank([Bum Bm]); % check is full rank
Kg = -(C*Am^-1*Bm)^-1; % the matrix from reference to input ('kindof dynamic inversion')

K =2*eye(2);  % Test May2018 06

Hm = C*(s*eye(size(Am))-Am)^-1*Bm;
Hum = C*(s*eye(size(Am))-Am)^-1*Bum;

TF_eta2m = D*(Hm\Hum);

Ksp = -eye(size(Am))*0; %% No state predictor additional matrix (no reason behind) works well
x0hat = x0_new;         %% starting state of the state predictor

%%~~~~~~~~~ Trasform in discrete state space form because is more compact than
%~~~~~~~~~~ trasfer function and can be handled easier
sistemaLongitudinal = ss( TF_eta2m , 'minimal' );
DiscretesistemaLongitudinal= c2d( sistemaLongitudinal , Ts );

D_Longitudinal = ss( D , 'minimal' );
DiscreteD_Longitudinal = c2d( D_Longitudinal , Ts);
