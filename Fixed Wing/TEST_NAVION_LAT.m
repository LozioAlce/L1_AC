%% This script implements the L1 adaptive controller main features for the Longitudinal Dynamics

Am_LAT = A_LATERAL-B_LATERAL*K_LAT; % [v p r phi]_dot=A_LONG*[u w q theta]'
Bm_LAT=B_LATERAL;

plot(eig(Am_LAT),'*r')
hold on, grid on
plot(eig(A_LATERAL),'*')

C_LAT = [1 0 0 0
         0 0 0 1];
%%
x0_new_LAT = zeros( 1 , max(size(Am_LAT)));

omega0 = eye(2);
s = tf('s');
D = 1/(.25*s+1); % May 2018 Test ok tuned As the Longitudinal

D = D*eye(2);

% construct the unmatched matrix
Bum_LAT = [ 0 -Bm_LAT(3,1) Bm_LAT(2,1) Bm_LAT(2,1) ;0 -Bm_LAT(3,1) Bm_LAT(2,1) -Bm_LAT(2,1)]'; % not control channel
Bum_LAT'*Bm_LAT == 0; % just to check it out

B_LAT = [Bm_LAT Bum_LAT];

rank([Bum_LAT Bm_LAT]);                 %check  the full rank
Kg_LAT = -(C_LAT*Am_LAT^-1*Bm_LAT)^-1;  % the matrix from reference to input ('kindof dynamic inversion')

K_const_LAT = 2.5*eye(2);   % Test

Hm = C_LAT*(s*eye(size(Am_LAT))-Am_LAT)^-1*Bm_LAT;
Hum = C_LAT*(s*eye(size(Am_LAT))-Am_LAT)^-1*Bum_LAT;

TF_eta2m = D*(Hm\Hum);

Ksp_LAT = -eye(size(Am_LAT))*0; % Speedup the estimation of the state
x0hat_LAT = x0_new_LAT;

% Computes the controller in a statespace representation
sistemaLateral = ss(TF_eta2m,'minimal');
DiscretesistemaLateral= c2d(sistemaLateral,Ts);

% Computes the lowpass filter in a statespace representation
D_Lateral = ss(D,'minimal');
DiscreteD_Lateral = c2d(D_Lateral ,Ts);
