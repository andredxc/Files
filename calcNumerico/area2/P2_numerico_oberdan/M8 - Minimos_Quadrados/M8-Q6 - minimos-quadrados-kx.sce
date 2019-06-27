clear //q6
x=[-2:0.1:2]'
b=exp(x/12)-1
A=[x^1]
k=(A'*A)\(A'*b)

disp(k)
