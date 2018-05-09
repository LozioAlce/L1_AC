function dx = f_NAVION(state,input)
  u = state(1);
  v = state(2);
  w = state(3);
  p = state(4);
  q = state(5);
  r = state(6);
  phi = state(7);
  theta = state(8);
  psi = state(9);
  xg = state(10);
  yg = state(11);
  h = state(12);

  de = input(1);
  da = input(2);
  dr = input(3);
  dt = input(4);
%% Parameters AR = 6.04 e = 0.7 to implement into the setup
  global  g rho c b S CL_0 CL_alpha CL_eq CL_de CD_0 AR e CY_beta CY_dr ...
          Tmax Cl_beta Cl_p Cl_r Cl_da Cl_dr Cm_0 Cm_alpha Cm_eq Cm_de ...
          Cn_beta  Cn_p Cn_r Cn_da Cn_dr m Ixx Iyy Izz
%% From body to wind for forces and moments
  V = sqrt(u^2+v^2+w^2);
  alpha = atan(w/u);
  beta = asin(v/V);
%% CL CD and CY construction
  CL = CL_0+CL_alpha*alpha+CL_eq*(c/(2*V))*q+CL_de*de;
  CD = CD_0 + (CL^2)/(pi*AR*e);
  CY = CY_beta *beta +CY_dr *dr;
%% Forces
  Lift = 1/2*rho *V^2*S*CL;
  Drag = 1/2*rho *V^2*S*CD;
  Side_Force = 1/2*rho *V^2*S*CY;
  Thrust = dt*Tmax;
  delta_engine = 0; % angle in radiance of the thrust vector respect the longitudinal body axis
%% Thrust Force component calculation
  X_Thrust = Thrust * cos(delta_engine);
  Z_Thrust= Thrust * sin(delta_engine);
  Y_Thrust= 0;
%% Cl Cp Cn - Moments Coefficients
  Cl = Cl_beta*beta+Cl_p*(b/(2*V))*p+Cl_r *(b/(2*V))*r + Cl_da*da+Cl_dr*dr;
  Cm = Cm_0+Cm_alpha*alpha+Cm_eq*(c/(2*V))*q+Cm_de*de;
  Cn = Cn_beta*beta + Cn_p *(b/(2*V))*p +Cn_r * (b/(2*V))*r + Cn_da*da+Cn_dr*dr;
%% Moments
  ROLL_MOMENT = 1/2*rho*S*b*Cl*V^2;
  PITCH_MOMENT = 1/2*rho*S*c*Cm*V^2;
  YAW_MOMENT = 1/2*rho*S*b*Cn*V^2;
%% Differential Equations
  u_dot = (X_Thrust-g*m*sin(theta)-Drag*cos(alpha)+Lift*sin(alpha))/m + r*V*sin(beta)-q*V*sin(alpha)*cos(beta);
  v_dot = (Y_Thrust+g*m*sin(phi)*cos(theta)+Side_Force)/m + p*V*sin(alpha)*cos(beta)-r*V*cos(alpha)*cos(beta);
  w_dot = (Z_Thrust+g*m*cos(phi)*cos(theta)-Drag*sin(alpha)-Lift*cos(alpha))/m + q*V*cos(alpha)*cos(beta)-p*V*sin(beta);

  p_dot = (ROLL_MOMENT  + (Iyy-Izz) *q*r)/Ixx;
  q_dot = (PITCH_MOMENT + (Ixx-Izz) *p*r)/Iyy;
  r_dot = (YAW_MOMENT+(Ixx-Iyy)*p*q)/Izz;

  phi_dot = p+q*sin(phi)*tan(theta)+r*cos(phi)*tan(theta);
  theta_dot = q*cos(phi)-r*sin(phi);
  psi_dot = q*sin(phi)*sec(theta) + r*cos(phi)*sec(theta);

% xg_dot = u*cos(psi)*cos(theta)+v*(cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi))+w*(cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi));
% yg_dot = u*sin(psi)*cos(theta)+v*(sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi))+w*(sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi));
% h_dot  = u*sin(theta)-v*cos(theta)*sin(phi)-w*cos(theta)*cos(phi);

  xg_dot = u*cos(psi)*cos(theta)+v*(cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi))+w*(cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi));
  yg_dot = u*sin(psi)*cos(theta)+v*(sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi))+w*(sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi));
  h_dot  = u*sin(theta)-v*cos(theta)*sin(phi)-w*cos(theta)*cos(phi);
%% dx_dt output

  dx = [u_dot v_dot w_dot p_dot q_dot r_dot phi_dot theta_dot psi_dot xg_dot yg_dot h_dot]';

end
