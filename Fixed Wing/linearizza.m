function [A,B]=linearizza(fun,stato,input,step)
%Linearize fun around a trim point stato input
%Be sure for my control to use the right referece, hence body axis
x_trim=stato(1:12); input_trim=input(1:4);
% step=1e-3;
for j=1:12
    dx=zeros(size(x_trim));
    dx(j)=step;
    A(:,j)=(fun(x_trim+dx,input_trim)-fun(x_trim-dx,input_trim))/(2*step);
end
% step=1e-3;
for j=1:4
    du=zeros(size(input_trim));
    du(j)=step;
    B(:,j)=(fun(x_trim,input_trim+du)-fun(x_trim,input_trim-du))/(2*step);
end
end
