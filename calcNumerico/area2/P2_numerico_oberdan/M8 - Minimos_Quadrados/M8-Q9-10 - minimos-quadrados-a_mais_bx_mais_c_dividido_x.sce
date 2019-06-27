//a+ bx + c/x
/**
 * Coloca em a os coeficientes do polinomio de GRAU ESPECIFICADO EM P que
 * melhor se ajuste aos pares x,y.
 * PARA RETAS     -> p=1
 * PARA PARABOLAS -> p=2...
 */
clear
p = 1 // Ordem do polinomio a ser gerado
x = [1:0.1:2.5]' //q9-10
//y = cos(x./8 + 3) // q9
y = cos(x./3 + 3) // q10
n = size(x,1)
// Monta matriz simetrica de minimos quadrados
for i=1:p+1 //for (i=1; i<= p+1; i++)
    for j=1:p+1
        M = [
             n  sum(x)  sum(1 ./x)
             sum(x) sum(x.^2)   n
             sum(1 ./x) n   sum(1 ./(x.^2))]
    end
end
// Monta matriz de resultado b
for i=1:p+1
b = [sum(y)
     sum(x.*y)
     sum(y./x)]
end
a = inv(M)*b;
//disp(a(3)) //q9
disp(a(1)+a(2)*2.25+a(3)/2.25) //q10
