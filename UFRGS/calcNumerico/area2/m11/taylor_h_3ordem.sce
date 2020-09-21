clear
function y=f(t,u)
    y=u*t
endfunction

function y=ft(t,u)
    y=(u*t)*t+u
endfunction

function y=ftt(t,u)
    y=(u*t^3)+2*u*t+u*t
endfunction

a = 0.1
T = 2
h = 0.1


u(1)=a;         //cond inicial
t(1)=1;         
N=(T-t(1))/h
for n=1:N
    t(n+1)=t(n)+h;
    F=f(t(n),u(n));
    Ft=ft(t(n),u(n))
    Ftt=ftt(t(n),u(n))           
    u(n+1)=u(n)+h*F+(h^2/2)*Ft+(h^3/6)*Ftt
end
ultimo=u(N+1);
plot(t,u,'r.-');xgrid

disp(u)

