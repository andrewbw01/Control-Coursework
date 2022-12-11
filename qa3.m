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

% A3 --------------------------------------------------------

yeq=xeq(1);
Sys_SS = ss(A, B, C, D); 
tend_sim = 1e-5*200;
t_sim = [0:1e-6:tend_sim];
u_sim = repmat([0 0]',1,length(t_sim));

for i=0:20:100 %10:100
    x0_sim = xeq/norm(xeq)*i/100;    % calculates a perturbation 
    y = lsim(Sys_SS,u_sim,t_sim,x0_sim,'zoh'); %This plots deltaY
    figure(1)
    hold on
    plot(t_sim,xeq(1)+y(:,1),'-r')
    figure(2)
    hold on
    plot(t_sim,xeq(2)+y(:,2),'-r')
end

tspan = [0,tend_sim];

ymat = [];
tmat = [];

for i = 0:20:100 %10:100
    x0_sim =  xeq+(xeq/norm(xeq))*i/100; %This calculates a perturbation for the initial state
    [t,x] = ode45(@(t,x) odefun(t,x,ueq,C,L,ILoad,R_L,Vs), tspan, x0_sim);
    figure(1)
    hold on
    plot(t,x(:,1),'--b')
    figure(2)
    hold on
    plot(t,x(:,2),'--b')

end

figure(1)
xlabel('time [s]');
ylabel('vc [V]');
title('Comparison of Vc')
figure(2)
xlabel('time [s]');
ylabel('iL [A]');
title('Comparison of iL')








