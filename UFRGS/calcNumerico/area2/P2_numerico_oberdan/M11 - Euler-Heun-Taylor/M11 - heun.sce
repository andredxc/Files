clear
/**
 * t_dado, u_dado: u dado -> u(t_dado) = u_dado
 * t_final: tempo final -> u(t_final)
 * h: tamanho do intervalo
 * com_grafico: plota grafico da funcao se %T e nao se %F
 * 
 * [u]: aproximacao com o metodo de Heun
 *      -> valor final e' o ultimo no vetor
 */
function [u]=heun(t_dado, u_dado, t_final, h)
    t(1)=t_dado // t(0) -> init
    u(1)=u_dado          
    Nint=(t_final-t(1))/h
    for n=1:Nint
        t(n+1)=t(n)+h;
        util=u(n)+h*f(t(n),u(n))
        F1=f(t(n),u(n))
        F2=f(t(n+1),util)
        u(n+1)=u(n)+(h/2)*(F1+F2)
    end
    ufinal=u(n+1);
endfunction

//q3 Funcao u' (DERIVADA)
function y=f(t,u)
    y=9-t^2;
endfunction
disp("Questão 3");
disp(heun(2,1,4,0.1));
disp("---------");

//q4 Funcao u' (DERIVADA)
function y=f(t,u)
    y=8-t^2;
endfunction
disp("Questão 4");
disp(heun(2,1,4,0.01));
disp("---------");

//q7 Funcao u' (DERIVADA)
function y=f(t,u)
    y=cos(u+11);
endfunction
disp("Questão 7");
disp(heun(1,2,4,0.01));
disp("---------");
