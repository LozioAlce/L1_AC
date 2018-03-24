trim_input = stato(13:end); step_dxdu = 1e-7;

[A,B]=linearizza(@QUADROTOR,stato(1:12),trim_input,step_dxdu);
Q = 100*eye(12); 
R = eye(4);
[K_baseline,S,E] = lqr(A,B,Q,R);

