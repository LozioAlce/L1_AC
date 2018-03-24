if ~exist('u_trim')
    u_trim =input('insert u to trim the a/c \n')
end
if ~exist('v_trim')
    v_trim = input('insert v to trim the a/c \n')
end
if ~exist('w_trim')
    w_trim = input('insert w to trim the a/c \n')
end

phi_trim = 0/60;
theta_trim = 0;
psi_trim = 0;
Aeq=zeros(16,16);

for i=4:6 %set p q r
Aeq(i,i)=1;
end

Aeq(12,12)=0; %select height
Aeq(1,1) = 1;   %select u
Aeq(2,2) = 1;   %select v
Aeq(3,3) = 1;   %select w
Aeq(7,7)=1;  %select phi if you wish
Aeq(8,8)=1;  %select theta if you wish
Aeq(9,9)=0;  %select psi if you wish, but it actually does not really matter, obviously

h=0;
beq = [u_trim v_trim  w_trim 0 0 0 phi_trim theta_trim psi_trim 0 0 h 0 0 0 0]';
%%
options = optimoptions(@fmincon,'MaxFunEvals',100000);
options.ConstraintTolerance=1e-12;
options.StepTolerance=1e-12;
options.MaxIterations =1000;
options.Algorithm = 'interior-point'
options.UseParallel=0;

x0 = zeros(16,1);%12+4 
x0(1) = u_trim ;x(16) = .3;
x0(12) = 0;
% x0(1:12) = randn(1,12);
x0(13:16)=1;
[stato]  =	fmincon('funzione_di_costo',x0,[],[],Aeq,beq,[],[],[],options);