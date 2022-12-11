function dxdt = odefun(t,x,u,C,L,ILoad,R_L,Vs)
    dxdt = zeros(2,1);
    dxdt(1) = (x(2)/C)*u(2)-ILoad/C;
    dxdt(2) = (R_L/L)*x(2) + (Vs/L)*u(1)-(x(1)/L)*u(2);
end