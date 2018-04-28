%% This script load the matrices of the navion and setup what is neeeded for the simulink ...
... take the structure from the example of pag 170 that is working

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
D = 1/(1*s+1); %OK 06-18

D = D*eye(2);
% construct the unmatched matrix
Bum_LAT = [ 0 -Bm_LAT(3,1) Bm_LAT(2,1) Bm_LAT(2,1) ;0 -Bm_LAT(3,1) Bm_LAT(2,1) -Bm_LAT(2,1)]'; % not control channel
Bum_LAT'*Bm_LAT == 0;

B_LAT = [Bm_LAT Bum_LAT];

rank([Bum_LAT Bm_LAT]);%check  the full rank
Kg_LAT = -(C_LAT*Am_LAT^-1*Bm_LAT)^-1; % the matrix from reference to input ('kindof dynamic inversion')

% K_const_LAT = 20*eye(2)  %NEW TEST
K_const_LAT = 20*eye(2)*2; % 2018-April
% K_const_LAT = 20*eye(2)*2.5; % 2018-April
% supersided by state space rapresentation
% D_NUM11_LAT = cell2mat(D.Numerator(1,1));
% D_DEN11_LAT = cell2mat(D.Denominator(1,1));
%
% D_NUM12_LAT = cell2mat(D.Numerator(1,2));
% D_DEN12_LAT = cell2mat(D.Denominator(1,2));
%
% D_NUM21_LAT = cell2mat(D.Numerator(2,1));
% D_DEN21_LAT = cell2mat(D.Denominator(2,1));
%
% D_NUM22_LAT = cell2mat(D.Numerator(2,2));
% D_DEN22_LAT = cell2mat(D.Denominator(2,2));

Hm = C_LAT*(s*eye(size(Am_LAT))-Am_LAT)^-1*Bm_LAT;
Hum = C_LAT*(s*eye(size(Am_LAT))-Am_LAT)^-1*Bum_LAT;

TF_eta2m = D*(Hm\Hum);

%sorting out No needed anymore, state space is better
% NUM_TF_eta2m_11_LAT = cell2mat(TF_eta2m.Numerator(1,1));
% NUM_TF_eta2m_12_LAT = cell2mat(TF_eta2m.Numerator(1,2));
% NUM_TF_eta2m_21_LAT = cell2mat(TF_eta2m.Numerator(2,1));
% NUM_TF_eta2m_22_LAT = cell2mat(TF_eta2m.Numerator(2,2));
%
% DEN_TF_eta2m_11_LAT = cell2mat(TF_eta2m.Denominator(1,1));
% DEN_TF_eta2m_12_LAT = cell2mat(TF_eta2m.Denominator(1,2));
% DEN_TF_eta2m_21_LAT = cell2mat(TF_eta2m.Denominator(2,1));
% DEN_TF_eta2m_22_LAT = cell2mat(TF_eta2m.Denominator(2,2));

Ksp_LAT = -eye(size(Am_LAT))*0;
x0hat_LAT = x0_new_LAT;

sistemaLateral = ss(TF_eta2m,'minimal');

DiscretesistemaLateral= c2d(sistemaLateral,Ts);
D_Lateral = ss(D,'minimal');
DiscreteD_Lateral = c2d(D_Lateral ,Ts);
