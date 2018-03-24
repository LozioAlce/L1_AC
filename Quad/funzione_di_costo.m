function J = funzione_di_costo(x) %as input V alpha beta
    stato = x(1:12); input = x(13:end);
%     [stato(1),stato(2),stato(3)] = wind2body(x(1),x(2),x(3));

    [stato_dot]=QUADROTOR(stato(1:12),input); % in body axis
    R=zeros(12);
    R(1:6,1:6)=eye(6);  %(u v w p q r phi theta psi)dot
    R(4:6,4:6)=eye(3)*60;  %(p q r)dot the weight need to be higher to give a good cost function meaning
    R(12,12)=1;         %hdot
    J=stato_dot'*R*stato_dot;% u v w p q r phi theta psi dot
end