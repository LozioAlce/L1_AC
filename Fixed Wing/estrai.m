function [A_LONG , A_LATERAL , B_LONG , B_LATERAL , A_LONG_aug , B_LONG_aug , A_LATERAL_aug , B_LATERAL_aug] = estrai(A , B)
% Extract the A and B matrix for longitudinal and lateral dynamic
% [A_LONG,A_LATERAL,B_LONG,B_LATERAL,A_LONG_aug,B_LONG_aug,A_LATERAL_aug,B_LATERAL_aug]=estrai(A,B)
%
% Longitudinal dynamic :
% [u w q theta]_dot = A_LONG*[u w q theta]' + B_LONG * [de dt]'
%
% Lateral dynamics:
% [v p r phi]_dot = A_LATERAL*[v p r phi]' + B_LATERAL * [da dr]'
%
% Augumented Longitudinal dynamic :
% [u w q theta h]_dot = A_LONG_aug*[u w q theta]' + B_LONG_aug * [de dt]'
%
% Augumented Lateral dynamics:
% [v p r phi psi y]_dot=A_LATERAL_aug*[v p r phi psi y] + B_LATERAL_aug * [da dr]'

% LONGITUINAL dynamic%
  A_LONG = [A(1,1) A(1,3) A(1,5) A(1,8)         % [u w q theta]_dot=A_LONG*[u w q theta]'
            A(3,1) A(3,3) A(3,5) A(3,8)
            A(5,1) A(5,3) A(5,5) A(5,8)
            A(8,1) A(8,3) A(8,5) A(8,8)];

  B_LONG = [B(1,1) B(1,4)                       % [de dt]
            B(3,1) B(3,4)
            B(5,1) B(5,4)
            B(8,1) B(8,4)];

% LATERAL DIRECTIONAL dynamic
  A_LATERAL = [A(2,2) A(2,4) A(2,6) A(2,7)      % [v p r phi]_dot=A_LATERAL*[v p r phi]'
               A(4,2) A(4,4) A(4,6) A(4,7)
               A(6,2) A(6,4) A(6,6) A(6,7)
               A(7,2) A(7,4) A(7,6) A(7,7)];

  B_LATERAL = [B(2,2) B(2,3)                    %[da dr]
               B(4,2) B(4,3)
               B(6,2) B(6,3)
               B(7,2) B(7,3)];                  % has been changed from [B(8,2) B(8,3)] may be a misprint

% Augumented Longitudinal dynamic :
  A_LONG_aug = [A(1,1)  A(1,3)  A(1,5)  A(1,8)  A(1,12)         % [u w q theta h]_dot=A_LONG*[u w q theta h]'
                A(3,1)  A(3,3)  A(3,5)  A(3,8)  A(3,12)
                A(5,1)  A(5,3)  A(5,5)  A(5,8)  A(5,12)
                A(8,1)  A(8,3)  A(8,5)  A(8,8)  A(8,12)
                A(12,1) A(12,3) A(12,5) A(12,8) A(12,12)];

  B_LONG_aug = [B(1,1) B(1,4)
                B(3,1) B(3,4)
                B(5,1) B(5,4)
                B(8,1) B(8,4)
                B(12,1) B(12,4)];

% Augumented Lateral dynamics:
  A_LATERAL_aug = [A(2,2)   A(2,4)  A(2,6)  A(2,7)    A(2,9)    A(2,11) % [v p r phi psi y]_dot=A_LATERAL*[v p r phi psi y]'
                   A(4,2)   A(4,4)  A(4,6)  A(4,7)    A(4,9)    A(4,11)
                   A(6,2)   A(6,4)  A(6,6)  A(6,7)    A(6,9)    A(6,11)
                   A(7,2)   A(7,4)  A(7,6)  A(7,7)    A(7,9)    A(7,11)
                   A(9,2)   A(9,4)  A(9,6)  A(9,7)    A(9,9)    A(9,11)
                   A(11,2)  A(11,4) A(11,6) A(11,7)   A(11,9)   A(11,11) ];

  B_LATERAL_aug = [B(2,2)  B(2,3)
                   B(4,2)  B(4,3)
                   B(6,2)  B(6,3)
                   B(7,2)  B(7,3)
                   B(9,2)  B(9,3)
                   B(11,2) B(11,3)];

end
