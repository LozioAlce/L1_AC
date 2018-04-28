%% This script load the matrices of the navion and setup what is neeeded for the simulink ...
... take the structure from the example of pag 170 that is working

%%
Am = A_LONG-B_LONG*K_LONG; % [u w q theta]_dot=A_LONG*[u w q theta]'
Bm=B_LONG;

C = [1 0 0 0
     0 0 0 1];

x0_new = zeros(1,max(size(Am))); % Not used, assigned to the start status of the estimator

omega0 = eye(2); % nominal omega matrix in x_dot = Ax+Bm(omega u +d)+Bum u
s = tf('s');
%D = 1/s; % Test
%D = 1/(s*1/5+1) % Test
D = 1/(s+1);
D = 1/(5*s+1); % May 2018 Test

D = D*eye(2);
% construct the unmatched matrix
Bum = [ 0 -Bm(3,1) Bm(2,1) Bm(2,1) ;0 -Bm(3,1) Bm(2,1) -Bm(2,1)]'; % not control channel
Bum'*Bm ==0;

B = [Bm Bum]; % rebuild the control matrix

rank([Bum Bm]); % check is full rank
Kg = -(C*Am^-1*Bm)^-1; % the matrix from reference to input ('kindof dynamic inversion')

%% Scenario 1 semplice
%omega = [0.6 -0.2
%         0.2  1.2];
%dAm = .75*rand(size(Am))
% close all
%plot(eig(Am),'r+'),hold on
%plot(eig(Am+dAm),'gs')

%%
% close all


K =20*eye(2); % Constant for adaptive control u_ad = -K D(s)eta_hat
% supersided by state space rapresentation
% D_NUM11 = cell2mat(D.Numerator(1,1));
% D_DEN11 = cell2mat(D.Denominator(1,1));
% D_NUM12 = cell2mat(D.Numerator(1,2));
% D_DEN12 = cell2mat(D.Denominator(1,2));
% D_NUM21 = cell2mat(D.Numerator(2,1));
% D_DEN21 = cell2mat(D.Denominator(2,1));
% D_NUM22 = cell2mat(D.Numerator(2,2));
% D_DEN22 = cell2mat(D.Denominator(2,2));

Hm = C*(s*eye(size(Am))-Am)^-1*Bm;
Hum = C*(s*eye(size(Am))-Am)^-1*Bum;

TF_eta2m = D*(Hm\Hum);

%sorting out No needed anymore, state space is better
% NUM_TF_eta2m_11 = cell2mat(TF_eta2m.Numerator(1,1));
% NUM_TF_eta2m_12 = cell2mat(TF_eta2m.Numerator(1,2));
% NUM_TF_eta2m_21 = cell2mat(TF_eta2m.Numerator(2,1));
% NUM_TF_eta2m_22 = cell2mat(TF_eta2m.Numerator(2,2));
%
% DEN_TF_eta2m_11 = cell2mat(TF_eta2m.Denominator(1,1));
% DEN_TF_eta2m_12 = cell2mat(TF_eta2m.Denominator(1,2));
% DEN_TF_eta2m_21 = cell2mat(TF_eta2m.Denominator(2,1));
% DEN_TF_eta2m_22 = cell2mat(TF_eta2m.Denominator(2,2));

Ksp = -eye(size(Am))*0; %% No state predictor additional matrix (no reason behind) works well
x0hat = x0_new;         %% starting state of the state predictor
%% trasform in discrete state space form because is more compact than trasfer function and can be handled easier
sistemaLongitudinal = ss(TF_eta2m,'minimal');
DiscretesistemaLongitudinal= c2d(sistemaLongitudinal,Ts);
D_Longitudinal = ss(D,'minimal');
DiscreteD_Longitudinal = c2d(D_Longitudinal,Ts);
