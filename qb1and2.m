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











