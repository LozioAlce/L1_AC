
time = BODY_Variables.Time;
if max(time)>199
u = BODY_Variables.Data(:,1);
v = BODY_Variables.Data(:,2); 
w = BODY_Variables.Data(:,3);
p = BODY_Variables.Data(:,4);
q = BODY_Variables.Data(:,5);
r = BODY_Variables.Data(:,6);
phi = BODY_Variables.Data(:,7)*180/pi;
theta = BODY_Variables.Data(:,8)*180/pi;
psi = BODY_Variables.Data(:,9)*180/pi;
x = BODY_Variables.Data(:,10);
y = BODY_Variables.Data(:,11);
h = BODY_Variables.Data(:,12);

de = ACTUATOR_TRUE.Data(:,1)*180/pi;
da = ACTUATOR_TRUE.Data(:,2)*180/pi;
dr = ACTUATOR_TRUE.Data(:,3)*180/pi;
dt = ACTUATOR_TRUE.Data(:,4);

%%
V = sqrt(u.^2+v.^2+w.^2);
alpha = atan(w./V)*180/pi;
beta = asin(v./V)*180/pi;

%%
ETICHETTA = {'V [m/sec]','\alpha [\circ]','\beta [\circ]','p [\circ/sec]','q[\circ/sec]','r[\circ/sec]','phi[\circ]','theta[\circ]','psi[\circ]','x [m]','y [m]','h [m]','de [\circ]','da [\circ]','dr [\circ]','dt [\circ]'}
kk = 1
    figure(kk)
    plot(time,BODY_Variables.Data(:,kk)),plot(time,ones(size(time))*sqrt(sum(target_point(1:3)))),grid on,hold on
    xlabel('Time [sec]')
    ylabel(ETICHETTA(kk))
kk = 2
    figure(kk)
    plot(time,alpha),grid on,hold on
    xlabel('Time [sec]')
    ylabel(ETICHETTA(kk))

kk = 3
    figure(kk)
    plot(time,beta),grid on,hold on
    xlabel('Time [sec]')
    ylabel(ETICHETTA(kk))

    
for kk=4:6
    figure(kk)
    plot(time,BODY_Variables.Data(:,kk)),grid on,hold on
    xlabel('Time [sec]')
    ylabel(ETICHETTA(kk))
end

for kk=7:9
    figure(kk)
    plot(time,BODY_Variables.Data(:,kk)*180/pi),grid on,hold on
    xlabel('Time [sec]')
    ylabel(ETICHETTA(kk))
end

for kk=10:12
    figure(kk)
    plot(time,BODY_Variables.Data(:,kk)),grid on,hold on
    xlabel('Time [sec]')
    ylabel(ETICHETTA(kk))
end
end
