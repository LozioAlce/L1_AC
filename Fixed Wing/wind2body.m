function [u,v,w] = wind2body(V,alpha,beta)
    u = V*cos(alpha)*cos(beta);
    v = V*sin(beta);
    w = V*sin(alpha)*cos(beta);  
end
