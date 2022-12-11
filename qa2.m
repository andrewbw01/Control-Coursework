L = 200*1e-6;
R_L = 0.2;
C = 22*1e-6;
ILoad = 0.2;
Vs = 15;

xeq = [20 0.4]';
ueq = inv([0 xeq(2)/C ; Vs/L -xeq(1)/L]) * [ILoad/C ; -(R_L/L)*xeq(2)]

A = [0 ueq(2)/C ; -ueq(2)/L R_L/L]  % change R_L/L to -R_L/L
B = [0 xeq(2)/C ; Vs/L -xeq(1)/L]
C = [1 0]
D = 0