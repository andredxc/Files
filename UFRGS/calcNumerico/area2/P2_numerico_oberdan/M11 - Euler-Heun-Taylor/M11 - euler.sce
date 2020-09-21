clear
/*
 * t_dado, u_dado: u dado -> u(t_dado) = u_dado
 * t_final: tempo final -> u(t_final)
 * h: tamanho do intervalo
 * 
 * [u]: aproximacao com o metodo de Euler 
 *      -> valor final e' o ultimo no vetor
 */
function [u]=euler(t_dado, u_dado, t_final, h)
    t(1)=t_dado; // t(0) -> init
    u(1)=u_dado;      
    Nint=(t_final-t(1))/h; // numero de intervalos
    for n=1:Nint
        t(n+1)=t(n)+h;
        u(n+1)=u(n)+h*f(t(n),u(n));
    end
    ufinal=u(n+1);
endfunction

//q1 Funcao u' (DERIVADA)
function y=f(t,u)
    y=12-t^2;
endfunction
disp("Questão 1");
disp(euler(2,1,4,0.1));
disp("---------");

//q2 Funcao u' (DERIVADA)
function y=f(t,u)
    y=6 - t^2;
endfunction
disp("Questão 2");
disp(euler(2,1,4,0.01));
disp("---------");

//q5 Funcao u' (DERIVADA)
function y=f(t,u)
    y=sin(u+t+10);
endfunction
disp("Questão 5");
disp(euler(0,1,3,0.1));
disp("---------");

//q6 Funcao u' (DERIVADA)
function y=f(t,u)
    y=cos(u+9);
endfunction
disp("Questão 6");
disp(euler(1,2,4,0.01));
disp("---------");
