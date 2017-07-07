%% This script load the matrices of the navion and setup what is neeeded for the simulink ...
... take the structure from the example of pag 170 that is working
%     clear
% load('MATRICI')
% clearvars *aug*
%%
Am = A_LONG-B_LONG*K_LONG; % [u w q theta]_dot=A_LONG*[u w q theta]'
Bm=B_LONG

% close all
plot(eig(Am),'*r'),hold on,grid on
plot(eig(A_LONG),'*')

C = [1 0 0 0
     0 0 0 1];
%%
x0_new = zeros(1,max(size(Am)))
% close all
omega0 = eye(2);
s = tf('s')
D = 1/s;

D = 1/(s*1/5+1)
D = 1/(s+1)

D = D*eye(2)

Bum = [ 0 -Bm(3,1) Bm(2,1) Bm(2,1) ;0 -Bm(3,1) Bm(2,1) -Bm(2,1)]'; % not control channel
Bum'*Bm ==0;

B = [Bm Bum]

rank([Bum Bm])
Kg = -(C*Am^-1*Bm)^-1

%% Scenario 1 semplice
omega = [0.6 -0.2 
         0.2  1.2];
dAm = .75*rand(size(Am))
% close all
plot(eig(Am),'r+'),hold on
plot(eig(Am+dAm),'gs')

%%
% close all


K =20*eye(2)
D_NUM11 = cell2mat(D.Numerator(1,1));
D_DEN11 = cell2mat(D.Denominator(1,1));

D_NUM12 = cell2mat(D.Numerator(1,2));
D_DEN12 = cell2mat(D.Denominator(1,2));

D_NUM21 = cell2mat(D.Numerator(2,1));
D_DEN21 = cell2mat(D.Denominator(2,1));

D_NUM22 = cell2mat(D.Numerator(2,2));
D_DEN22 = cell2mat(D.Denominator(2,2));

Hm = C*(s*eye(size(Am))-Am)^-1*Bm
Hum = C*(s*eye(size(Am))-Am)^-1*Bum

TF_eta2m = D*(Hm\Hum)

%sorting out
NUM_TF_eta2m_11 = cell2mat(TF_eta2m.Numerator(1,1));
NUM_TF_eta2m_12 = cell2mat(TF_eta2m.Numerator(1,2));
NUM_TF_eta2m_21 = cell2mat(TF_eta2m.Numerator(2,1));
NUM_TF_eta2m_22 = cell2mat(TF_eta2m.Numerator(2,2));

DEN_TF_eta2m_11 = cell2mat(TF_eta2m.Denominator(1,1));
DEN_TF_eta2m_12 = cell2mat(TF_eta2m.Denominator(1,2));
DEN_TF_eta2m_21 = cell2mat(TF_eta2m.Denominator(2,1));
DEN_TF_eta2m_22 = cell2mat(TF_eta2m.Denominator(2,2));

Ksp = -eye(size(Am))*0;
x0hat = x0_new;
%%
Ts = 0.01;
