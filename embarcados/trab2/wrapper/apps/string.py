def longest_common_substring(s1, s2):
   m = [[0] * (1 + len(s2)) for i in range(1 + len(s1))]
   longest, x_longest = 0, 0
   for x in range(1, 1 + len(s1)):
       for y in range(1, 1 + len(s2)):
           if s1[x - 1] == s2[y - 1]:
               m[x][y] = m[x - 1][y - 1] + 1
               if m[x][y] > longest:
                   longest = m[x][y]
                   x_longest = x
           else:
               m[x][y] = 0
   return s1[x_longest - longest: x_longest]
   
# F1 = open(r"C:\Users\Lucas\Desktop\f1.txt", "r")
# F2 = open("C:\\Users\\Lucas\\Desktop\\f2.txt", 'r')

F1 = open("./in1.txt", "r")
F2 = open("./in2.txt", "r")

s1 = F1.read()
s2 = F2.read()

# print (longest_common_substring(s1, s2))
x = longest_common_substring(s1, s1)
print("Done")
