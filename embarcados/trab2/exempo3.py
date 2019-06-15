import random
import math


RANGE_LIM = 2000000	


print("Range: %d" % RANGE_LIM)

listA = []
for i in range(RANGE_LIM):
	listA.append(random.randint(1, 10001))

listB = []
for i in range(RANGE_LIM):
	listB.append(random.randint(1, 10001))

listC = []
for i in range(RANGE_LIM):
	listC.append(listA[i] + listB[i]*math.sqrt(2*listA[i]))

print("Done")

