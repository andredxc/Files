clear
/**
 * t_dado, u_dado: u dado -> u(t_dado) = u_dado
 * t_final: tempo final   -> u(t_final)
 * h: tamanho do intervalo
 * com_grafico: plota grafico da funcao se %T e nao se %F
 * 
 * [u]: aproximacao com o metodo de Taylor de segunda ordem 
 *      -> valor final e' o ultimo no vetor
 */
function [u]=taylor_2(t_dado, u_dado, t_final, h)
    t(1) = t_dado; // t(0) -> init
    u(1) = u_dado; // condicao inicial do PVI
    n_intervalos = (t_final-t(1))/h; // numero de intervalos
    for n=1:n_intervalos
        t(n+1) = t(n)+h;
        F      = f(t(n),u(n));
        Ft     = ft(t(n),u(n));
        u(n+1) = u(n) + h*F + (h^2/2)*Ft;
                   // + ... h^n/n!*derivada de F(tn, un) de ordem n
    end
    ultimo = u(n_intervalos+1);
endfunction

//q8 Funcao u' (DERIVADA DE PRIMEIRA ORDEM)
function y=f(t,u)
    y=cos(u + t);
endfunction

//q8 Funcao u'' (DERIVADA DE SEGUNDA ORDEM)
function y=ft(t,u)
    y= - sin(u + t);
endfunction

disp("Questão 8");
disp(taylor_2(1,0.61,2,0.0000001));
disp("---------");
