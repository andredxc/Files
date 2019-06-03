function S = gaussiana(a, b, n, nodes)
    
    f = fm4
    h = (b - a)/n
    x = linspace(a, b, n+1)
        
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
            A = (w1(1)*f(x1))*h/2
        elseif nodes == 2 then
            x1 = alpha*t2(1) + bet
            x2 = alpha*t2(2) + bet
            A = (w2(1)*f(x1) + w2(2)*f(x2))*h/2
        elseif nodes == 3 then
            x1 = alpha*t3(1) + bet
            x2 = alpha*t3(2) + bet
            x3 = alpha*t3(3) + bet
            A = (w3(1)*f(x1) + w3(2)*f(x2) + w3(3)*f(x3))*h/2
        elseif nodes == 4 then
            x1 = alpha*t4(1) + bet
            x2 = alpha*t4(2) + bet
            x3 = alpha*t4(3) + bet
            x4 = alpha*t4(4) + bet
            A = (w4(1)*f(x1) + w4(2)*f(x2) + w4(3)*f(x3)...
                 + w4(4)*f(x4))*h/2
        elseif nodes == 5 then
            x1 = alpha*t5(1) + bet
            x2 = alpha*t5(2) + bet
            x3 = alpha*t5(3) + bet
            x4 = alpha*t5(4) + bet
            x5 = alpha*t5(5) + bet
            A = (w5(1)*f(x1) + w5(2)*f(x2) + w5(3)*f(x3)...
                + w5(4)*f(x4) + w5(5)*f(x5))*h/2
        else
            error("Invalid number of nodes")
        end 
        S = S + A
    end
endfunction

function y = f0(x)
    y = x.^6
endfunction

function y = fm1(x)
    y = sin(8*x)
endfunction

function y = fm4(x)
    y = sin(7*x + 1)
endfunction
