clc
clear
close


L=200*1e-6;  %[H]
R_L = 0.2;   %[Ohm]
C = 22*1e-6; %[F]
ILoad = 0.2; %[A]
Vs = 15;     %[V]

xeq=[20 0.4]';
ueq = inv([0 +xeq(2)/C  ; +Vs/L -xeq(1)/L])*[+ILoad/C;+(R_L/L)*xeq(2)];

A = [ 0   ueq(2)/C ;  -ueq(2)/L , -R_L/L ];
B = [ 0   xeq(2)/C ;  Vs/L    ,   -xeq(1)/L];
C = [1 0;0 1];
D = [0 0;0 0];
Sys_SS = ss(A,B,C,D);

% ---------------------------------------------------------------------
ContolMatrix = [B A*B] 
rank(ContolMatrix)

% rank of controllability matrix is 2, = n, so sys is completely
% controllable
% qb2 ------------------------------------------------------------------

xi = 0.86;
omega_d = 2000;
p1 = -xi*omega_d + sqrt(1-xi^2)
p2 = -xi*omega_d + sqrt(1-xi^2)

K = place(A, B, [p1 p2])

% calc closed loop dynamics
Acl = A - B*K;
syscl = ss(Acl, B, C, D);
pcl = pole(syscl)
step(syscl)

% qb3 -------------------------------------------------------------------

tend_sim = 1e-5*200;
Tsample = 10*1e-6;
t_sim_fordiscreet = [0: Tsample:tend_sim];
u_sim = repmat([0 0]', 1, length(t_sim_fordiscreet));

lsim(syscl, u_sim, t_sim_fordiscreet,(xeq/norm(xeq))*50/100, 'zoh')

xlinCL = xeq' + lsim(syscl, u_sim, t_sim_fordiscreet,(xeq/norm(xeq))*50/100, 'zoh');
xlinOL = xeq' + lsim(Sys_SS, u_sim, t_sim_fordiscreet,(xeq/norm(xeq))*50/100, 'zoh');
figure(6)
plot(t_sim_fordiscreet, xlinCL, 'r')
hold on 
plot(t_sim_fordiscreet, xlinOL, '--b')
title('Response for closed loop and open loop system starting from perturbed point')

xlinCLEQ = xeq' + lsim(syscl, u_sim, t_sim_fordiscreet*10,(xeq/norm(xeq))*0/100, 'zoh');
xlinOLEQ = xeq' + lsim(Sys_SS, u_sim, t_sim_fordiscreet*10,(xeq/norm(xeq))*0/100, 'zoh');
figure(7)
plot(t_sim_fordiscreet, xlinCLEQ, '-r')
hold on
plot(t_sim_fordiscreet,xlinOLEQ, '--b')
title('Response for closed loop and open loop system starting from equilibrium point ')












