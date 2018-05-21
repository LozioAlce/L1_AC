function J = funzione_di_costo(x)
  %% J = funzione_di_costo(x)
  % This function is the cost function for the trim, we want to minimize it. It means that the minimum is where some stato_dot
  % components are stationary;
  % x = [state+input] J = state_dot R state_dot, where R is not zero if want to minimize the variable,zero if it is free.
  % Example: V is given but has to be  constant therefore V_dot has be as close as possible to zero

    stato = x( 1 : 12); input = x(13:end);
    [stato(1) , stato(2) , stato(3)] = wind2body( x(1) , x(2) , x(3) );

    [stato_dot] = f_NAVION( stato(1:12) , input); % in body axis

    R = zeros(12);
    R(1:6,1:6) = eye(6);        % (u v w p q r phi theta psi)dot
    R(4:6,4:6) = eye(3) * 60;     % (p q r)dot the weight need to be higher to give a good cost function meaning
    R(12,12) = 100;             % hdot

    J = stato_dot' * R * stato_dot; % u v w p q r phi theta psi dot
end
