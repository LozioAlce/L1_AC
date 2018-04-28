% TRIM the f_NAVION model that is described in body axis
if ~exist( 'V_trim' )
  V_trim = input( 'insert V to trim the a/c \n' )
else
  fprintf( 'Trim velocity already present is = %d \n' , V_trim )
end
if ~exist('alpha_trim')
  alpha_trim = input( 'insert alpha to trim the a/c \n' )
end
if ~exist('beta_trim')
  beta_trim = input( 'insert beta to trim the a/c \n' )
end

% is not anymore needed because eventhough the f_NAVION is in body
% coordinate, the cost function takes wind coordinates
% [u_trim,v_trim,w_trim] = wind2body(V_trim,alpha_trim,beta_trim);

phi_trim = 0;
theta_trim = 0;
psi_trim = 0;

Aeq=zeros(16,16); % 0= do not select, 1 = select;

for i=4:6 %set p q r
  Aeq(i,i) = 1;
end

Aeq(12,12) = 0; % select height
Aeq(1,1) = 1;   % select V
Aeq(2,2) = 0;   % select alpha
Aeq(3,3) = 1;   % select beta
Aeq(7,7) = 1;   % select phi if you wish
Aeq(9,9) = 1;   % select psi if you wish, but it actually does not really matter, obviously

h = 0;          % trim at zero Altitude

beq = [V_trim alpha_trim  beta_trim 0 0 0 ...   % select where you wwant to trim at
        phi_trim theta_trim psi_trim 0 0 h 0 0 0 0]';

% Some setting proved to work out nicely
options = optimoptions(@fmincon,'MaxFunEvals',100000);

options.ConstraintTolerance=1e-12;
options.StepTolerance=1e-12;
options.MaxIterations =1000;
options.Algorithm = 'interior-point'
options.UseParallel=0;

x0 = zeros(16,1);%16 decision variable = 12 state + 4 Input
x0(1) = V_trim ;x(16) = .3;
x0(12) = 0;


[stato]  =	fmincon ('funzione_di_costo', x0 , [] , [] , Aeq , beq , [] , [] , [] , options);
[ u , v , w ] = wind2body( stato(1) , stato(2) ,stato(3));
stato_body = [ u , v , w , stato(4:end-4)']';
stato_trim_body = stato_body;
trim_input = stato(end-3:end); % take the last 4 from the decision variable stato(12+4)
