function [vc,il,time] = eurler1(T,tf,x0,u,C,L,R_L,Vs,ILoad)

vc=x0(1);
il=x0(2);
d1=u(1);
d2=u(2);
time=0

    for t=[0:T:tf]
        vcnext = vc(end)+(T*d2/C)*il(end)-T*(ILoad/C);
        ilnext = il(end)+(T*R_L/L)*il(end)-T*(d2/L)*vc(end)+T*(d1/L)*Vs;
        vc = [vc,vcnext];
        il = [il,ilnext];
        time =[time,time(end)+T];
    end
end