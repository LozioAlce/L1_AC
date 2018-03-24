function state_dot = QUADROTOR(state,input)

u = state(1);
v = state(2);
w = state(3);
V = [u v w]';

p = state(4);
q = state(5);
r = state(6);
omega = [p q r]';

x = state(7);
y = state(8);
z = state(9);

phi = state(10);
theta = state(11);
psi = state(12);

global inertia m g



T = input(1);
L_ = input(2);
M_ = input(3);
N_ = input(4);

F = m*g *[-sin(theta);cos(theta)*sin(phi);cos(theta)*cos(phi)]+[0 0 -T]';
M = [L_ M_ N_]';
%%%%%%%%%%%%%
m_V_dot  = F -  cross (omega,m*V);
V_dot = m_V_dot/m;
%%%%%%%%%%%%
I_omega_dot = M-cross (omega,inertia*omega);
omega_dot= inv(inertia)*I_omega_dot;
%%%%%%%%%%%%
MATRIX = [1          0                  -sin(theta)
          0        cos(phi)     sin(phi)*cos(theta)
          0       -sin(phi)     cos(theta)*cos(phi)];

ATTITUDE_DOT = inv(MATRIX)*omega;
%%%%%%%%%%%%
MATRIX2 = [cos(psi)*cos(theta) cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi) cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi)
            sin(psi)*cos(theta) sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi) sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi)
           -sin(theta) cos(theta)*sin(phi) cos(theta)*cos(phi)];

POS_DOT = MATRIX2 * V;
%%
state_dot = [V_dot;omega_dot;POS_DOT;ATTITUDE_DOT];

end
