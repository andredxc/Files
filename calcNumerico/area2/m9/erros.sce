/*
Ao utilizar o método do trapézio para calcular uma integral com 30 intervalos temos um erro de aproximadamente 0.001. Se utilizarmos 90 intervalos, de quando será o erro aproximadamente?
*/

function n = erro_trap(err_antes, int_antes, int_depois)
    vezes_mais = int_depois/int_antes
    n = err_antes/(vezes_mais^2)
endfunction



e = erro_trap(0.001, 30, 90)
disp(e)
