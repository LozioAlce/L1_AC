% clear

Ix = 0.1676;    % kg m2
Iy = 0.1676;    % kg m2
Iz = 0.29743;   % kg m2
m = 2.356;% [kg]
n_=7; %state variables  [phi theta psi w p q r]
m_=4; %control channels [Thrust rollMoment pitchMoment yawMoment]
A = [0 0 0 0 1 0 0
     0 0 0 0 0 1 0
     0 0 0 0 0 0 1
     0 0 0 0 0 0 0
     0 0 0 0 0 0 0
     0 0 0 0 0 0 0
     0 0 0 0 0 0 0];

B = [0 0 0 0
     0 0 0 0
     0 0 0 0
  -1/m 0 0 0
     0 1/Ix 0 0
     0 0 1/Iy 0
     0 0 0 1/Iz];

C = [1 0 0 0 0 0 0
     0 1 0 0 0 0 0
     0 0 1 0 0 0 0
     0 0 0 1 0 0 0];

EIG_A =eig(A)
pole_TARGET=EIG_A-[1 .8 .9 .7 .6 1.5 1.3]'*8;
% pole_TARGET=EIG_A-[1 .8 .9 .7 .6 1.5 1.3]'*4;
% pole_TARGET=EIG_A-[1 .8 .9 .7 .6 1.5 1.3]'*1
% pole_TARGET=EIG_A-[1 .8 .9 .7 .6 1.5 1.3]'*2
K_PP=place(A,B,pole_TARGET);
omega0 = eye(m_);

Am = A-B*K_PP;
Bm = B;

plot(real(eig(Am)),imag(eig(Am)),'*r'),hold on,grid on
plot(real(eig(A)),imag(eig(A)),'ok');
7*4
Bum = [1 0 0
       0 1 0
       0 0 1
       0 0 0
       0 0 0
       0 0 0
       0 0 0 ];
rank([Bm Bum])

   Kg= -(C*Am^-1*Bm)^-1


x0 =zeros(1,n_)'+.1*randn(n_,1)
Ksp = -eye(size(Am))*0;
omega0 = eye(m_);
omega_true = omega0;%+0.2*randn(size(omega0));
Ts = 0.01

% K_rope = 50;
%% Hard stuff

s = tf('s')
D = .5*s/(0.1*s+1)/s;
% D = (.1*s+1)/(1*s+1)/s;
% D = (.1*s+1)/(1*s+1)/(.2*s+1);
% D = 1/s*(s/(0.1*s+1))
% D = (s+1)/(.1*s+1)/s
% D = s/(1*s+1)^2
D = 1/s
% D = 1/(.5*s+1)/s
numD = cell2mat(D.Numerator);
denD = cell2mat(D.Denominator);
% D = D*eye(4);

K = 10*eye(m_);
K = 80*eye(m_);
K = 180*eye(m_);
Hm = C*((s*eye(size(Am))-Am)\Bm);
Hum = C*((s*eye(size(Am))-Am)\Bum);

inv_Hm = inv(Hm);
TF_eta2m = D*(Hm\Hum);

NUM_TF_eta2m_11 = cell2mat(TF_eta2m.Numerator(1,1)); DEN_TF_eta2m_11 = cell2mat(TF_eta2m.Denominator(1,1));
NUM_TF_eta2m_12 = cell2mat(TF_eta2m.Numerator(1,2)); DEN_TF_eta2m_12 = cell2mat(TF_eta2m.Denominator(1,2));
NUM_TF_eta2m_13 = cell2mat(TF_eta2m.Numerator(1,3)); DEN_TF_eta2m_13 = cell2mat(TF_eta2m.Denominator(1,3));
% NUM_TF_eta2m_14 = cell2mat(TF_eta2m.Numerator(1,4)); DEN_TF_eta2m_14 = cell2mat(TF_eta2m.Denominator(1,4));

NUM_TF_eta2m_21 = cell2mat(TF_eta2m.Numerator(2,1)); DEN_TF_eta2m_21 = cell2mat(TF_eta2m.Denominator(2,1));
NUM_TF_eta2m_22 = cell2mat(TF_eta2m.Numerator(2,2)); DEN_TF_eta2m_22 = cell2mat(TF_eta2m.Denominator(2,2));
NUM_TF_eta2m_23 = cell2mat(TF_eta2m.Numerator(2,3)); DEN_TF_eta2m_23 = cell2mat(TF_eta2m.Denominator(2,3));
% NUM_TF_eta2m_24 = cell2mat(TF_eta2m.Numerator(2,4)); DEN_TF_eta2m_24 = cell2mat(TF_eta2m.Denominator(2,4));

NUM_TF_eta2m_31 = cell2mat(TF_eta2m.Numerator(3,1)); DEN_TF_eta2m_31 = cell2mat(TF_eta2m.Denominator(3,1));
NUM_TF_eta2m_32 = cell2mat(TF_eta2m.Numerator(3,2)); DEN_TF_eta2m_32 = cell2mat(TF_eta2m.Denominator(3,2));
NUM_TF_eta2m_33 = cell2mat(TF_eta2m.Numerator(3,3)); DEN_TF_eta2m_33 = cell2mat(TF_eta2m.Denominator(3,3));
% NUM_TF_eta2m_34 = cell2mat(TF_eta2m.Numerator(3,4)); DEN_TF_eta2m_34 = cell2mat(TF_eta2m.Denominator(3,4));

NUM_TF_eta2m_41 = cell2mat(TF_eta2m.Numerator(4,1)); DEN_TF_eta2m_41 = cell2mat(TF_eta2m.Denominator(4,1));
NUM_TF_eta2m_42 = cell2mat(TF_eta2m.Numerator(4,2)); DEN_TF_eta2m_42 = cell2mat(TF_eta2m.Denominator(4,2));
NUM_TF_eta2m_43 = cell2mat(TF_eta2m.Numerator(4,3)); DEN_TF_eta2m_43 = cell2mat(TF_eta2m.Denominator(4,3));
% NUM_TF_eta2m_44 = cell2mat(TF_eta2m.Numerator(4,4)); DEN_TF_eta2m_44 = cell2mat(TF_eta2m.Denominator(4,4));

%% Some perturbation on the inertia matrices!!!
Ix = 0.1676*.7;    % kg m2
Iy = 0.1676*.4;    % kg m2
Iz = 0.29743*2;   % kg m2
m = 2.356;% [kg]
inertia =  diag([Ix,Iy,Iz])
LAMBDA_true = LAMBDA +0.005*randn(size(LAMBDA))*0
