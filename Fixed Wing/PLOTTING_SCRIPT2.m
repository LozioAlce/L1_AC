% This script plots V alpha beta p q r phi theta and psi, with
% custom position to maximize the space  and look
% Plot everything in the same 3x3 Plot
kk=13;
set(groot, 'CurrentFigure', kk)


pos1 = [0.04 0.71 0.27 0.25]; % [left bottom width height]
subplot('Position',pos1)

hold on,grid on
plot(time,V)
xlabel('Time [s]','FontSize', 14)
ylabel('V [m/sec]','FontSize', 14)


pos2 = [0.04 0.38 0.27 0.25]; % [left bottom width height]
subplot('Position',pos2)
hold on,grid on
plot(time,alpha)
xlabel('Time [s]','FontSize', 14)
ylabel('\alpha [\circ]','FontSize', 14)

pos3 = [0.04 0.06 0.27 0.25]; % [left bottom width height]
subplot('Position',pos3)
hold on,grid on
plot(time,beta)
xlabel('Time [s]','FontSize', 14)
ylabel('\beta [\circ]','FontSize', 14)

pos4 = [0.37 0.71 0.27 0.25]; % [left bottom width height]
subplot('Position',pos4)
hold on,grid on
plot(time,p*180/pi)
xlabel('Time [s]','FontSize', 14)
ylabel('p [\circ/sec]','FontSize', 14)

pos5 = [0.37 0.38 0.27 0.25]; % [left bottom width height]
subplot('Position',pos5)
hold on,grid on
plot(time,q*180/pi)
xlabel('Time [s]','FontSize', 14)
ylabel('q [\circ/sec]','FontSize', 14)

pos6 = [0.37 0.06 0.27 0.25]; % [left bottom width height]
subplot('Position',pos6)
hold on,grid on
plot(time,r*180/pi)
xlabel('Time [s]','FontSize', 14)
ylabel('r [\circ/sec]','FontSize', 14)

pos7 = [0.7 0.71 0.27 0.25]; % [left bottom width height]
subplot('Position',pos7)
hold on,grid on
plot(time,phi)
xlabel('Time [s]','FontSize', 14)
ylabel('\phi [\circ]','FontSize', 14)

pos8 = [0.7 0.38 0.27 0.25]; % [left bottom width height]
subplot('Position',pos8)
hold on,grid on
plot(time,theta)
xlabel('Time [s]','FontSize', 14)
ylabel('\theta [\circ]','FontSize', 14)

pos9 = [0.7 0.06 0.27 0.25]; % [left bottom width height]
subplot('Position',pos9)
hold on,grid on
plot(time,psi)
xlabel('Time [s]','FontSize', 14)
ylabel('\psi [\circ]','FontSize', 14)
