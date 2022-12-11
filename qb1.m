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


ContolMatrix = [B A*B]
rank(ContolMatrix)

co = ctrb(Sys_SS)
rank(co)