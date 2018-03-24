All_STATE_VARIABLE;
time = All_STATE_VARIABLE.ATTITUDE.Time;	
phi_theta_psi = All_STATE_VARIABLE.ATTITUDE.Data;
u_v_w = All_STATE_VARIABLE.V_BODY.Data;
u_v_w_NEW = reshape(u_v_w,3,max(size(u_v_w)));
u_v_w = u_v_w_NEW;
p_q_r = All_STATE_VARIABLE.OMEGA_BODY.Data;
x_y_z = All_STATE_VARIABLE.POS.Data;
x_y_z_NEW = reshape(x_y_z,3,max(size(x_y_z)));
x_y_z = x_y_z_NEW;

NAME = {'\phi','\theta','\psi'};
for ii = 1:3
    figure(ii)
    plot(time,phi_theta_psi(:,ii))
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('deg [\circ]')
end

%%
NAME = {'u','v','w'};
for ii = 1:3
    figure(ii+3)
    plot(time,u_v_w(ii,:))
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[m/sec]')
end
%%
NAME = {'p','q','r'};
for ii = 1:3
    figure(ii+6)
    plot(time,p_q_r(:,ii))
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[rad /sec]')
end
%%
NAME = {'x','y','z'};
for ii = 1:3
    figure(ii+9)
    plot(time,x_y_z(ii,:))
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[meters]')
end