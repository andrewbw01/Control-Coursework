% qA4, discretize by zoh
clc
clear
close

L=200*1e-6;  %[H]
R_L = 0.2;   %[Ohm]
C = 22*1e-6; %[F]
ILoad = 0.2; %[A]
Vs = 15;     %[V]

xeq=[20 0.4]';
ueq = inv([0 +xeq(2)/C  ; +Vs/L -xeq(1)/L])*[+ILoad/C;-(R_L/L)*xeq(2)];

A = [ 0   ueq(2)/C ;  -ueq(2)/L , R_L/L ];
B = [ 0   xeq(2)/C ;  Vs/L    ,   -xeq(1)/L];
C = [1 0;0 1];
D = [0 0;0 0];
Sys_SS = ss(A, B, C, D);
tend_sim = 1e-5*200;
% -----------------------------------------------------

Tsample = 10*1e-6;
Sys_SS_Discrete = c2d(Sys_SS, Tsample, 'zoh');

t_sim_fordiscreet = [0: Tsample:tend_sim];
u_sim = repmat([0 0]', 1, length(t_sim_fordiscreet));

figure(3)
lsim(Sys_SS, u_sim, t_sim_fordiscreet, (xeq/norm(xeq))*20/100, 'zoh');
hold on
lsim(Sys_SS_Discrete, u_sim, t_sim_fordiscreet, (xeq/norm(xeq))*20/100, 'zoh');
title('linear system vs discretized (ZOH) linear system');

% qa5 -------------------------------------------------------------

xlin = xeq' + lsim(Sys_SS, u_sim, t_sim_fordiscreet, (xeq/norm(xeq))*20/100, 'zoh');
xlin_discreet = xeq' + lsim(Sys_SS_Discrete, u_sim, t_sim_fordiscreet, (xeq/norm(xeq))*20/100, 'zoh')

[vc_euler,il_euler,time] = eurler1(Tsample,tend_sim,xeq+(xeq/norm(xeq))*20/100,ueq,C,L,R_L,Vs,ILoad);

figure(4)
hold on
stairs(time,vc_euler, 'r');
stairs(t_sim_fordiscreet, xlin(:,1),'b')
stairs(t_sim_fordiscreet, xlin_discreet(:,1), 'g--')
xlabel('Time [s]')
ylabel('vc [V]')
legend('Discrete Euler', 'Continuous', 'Discrete ZOH')












