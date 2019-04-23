// A resposta no moodle tem uma iteracao a menos, ainda nao sei por que

a = 23.4
b = 27.8
count = 0
dif = b - a

while (dif > 0.0001) then
    dif = dif/2
    count = count + 1
    disp(dif)
end

disp(count)



