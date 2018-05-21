function [u,v,w] = wind2body(V,alpha,beta)
  % [u,v,w] = wind2body(V,alpha,beta)
  % This function converts from wind to body coordinates

    u = V * cos(alpha) * cos(beta);
    v = V * sin(beta);
    w = V * sin(alpha) * cos(beta);
end
