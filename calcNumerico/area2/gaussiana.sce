function S = gaussiana(a, b, n, nodes)
    
    h = (b - a)/n
    x = linspace(a, b, n+1)
    
    w1 = 5/9
    w2 = 8/9
    w3 = w1
    
    t1 = -sqrt(3/5)
    t2 = 0
    t3 = -t1
    
    // 1 node
    t1 = [0]
    w1 = [2]
    // 2 nodes
    t2 = [-sqrt(3)/3, sqrt(3)/3]
    w2 = [1, 1]
    // 3 nodes
    t3 = [-sqrt(3/5), 0, sqrt(3/5)]
    w3 = [5/9, 8/9, 5/9]
    // 4 nodes
    i = sqrt((3 - 2*sqrt(6/5))/7)
    j = sqrt((3 + 2*sqrt(6/5))/7)
    t4 = [i, -i, j, -j]
    i = (18 + sqrt(30))/36
    j = (18 - sqrt(30))/36
    w4 = [i, i, j, j]
    // 5 nodes
    i = 1/3*sqrt(5 - 2*sqrt(10/7))
    j = 1/3*sqrt(5 + 2*sqrt(10/7))
    t5 = [0, -i, i, -j, j]
    i = (322 + 13*sqrt(70))/900
    j = (322 - 13*sqrt(70))/900
    w5 = [128/225, i, i, j, j]
    
    S = 0
    for i = 1:n
        alpha = (x(i+1) - x(i))/2
        bet = (x(i+1) + x(i))/2
        
        if nodes == 1 then
            x1 = alpha*t1(1) + bet
            A = w1(1)*f(x1)
        else if nodes == 2 then
            x1 = alpha*t2(1) + bet
            x2 = alpha*t2(2) + bet
            A = w2(1)*f(x1) + w2(2)*f(x2)
        end
        
        x1 = alpha*t1 + bet
        x2 = alpha*t2 + bet
        x3 = alpha*t3 + bet
        
        A = (w1*f(x1) + w2*f(x2) + w3*f(x3))*h/2
        S = S + A
    end
    
endfunction

function y = f(x)
    y = x.^6
endfunction
