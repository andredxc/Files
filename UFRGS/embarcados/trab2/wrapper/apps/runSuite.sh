#!/bin/bash

NUM_REPS=5

echo -e "------------------------------ C"

# cp tam2_1.txt in1.txt
# for (( i = 1; i <= $NUM_REPS; i++ )) 
# do
# 	echo "Running C benchmark 1 ($i out of $NUM_REPS)"
# 	../wrapped "./c"	
# done

# cp tam2_2.txt in1.txt
# for (( i = 1; i <= $NUM_REPS; i++ )) 
# do
# 	echo "Running C benchmark 2 ($i out of $NUM_REPS)"
# 	../wrapped "./c"	
# done

# cp tam2_3.txt in1.txt
# for (( i = 1; i <= $NUM_REPS; i++ )) 
# do
# 	echo "Running C benchmark 3 ($i out of $NUM_REPS)"
# 	../wrapped "./c"	
# done

echo -e "------------------------------ Java"

# cp tam2_1.txt in1.txt
# for (( i = 1; i <= $NUM_REPS; i++ )) 
# do
# 	echo "Running Java benchmark 1 ($i out of $NUM_REPS)"
# 	../wrapped "java -Xmx5000m codigo"	
# done

# cp tam2_2.txt in1.txt
# for (( i = 1; i <= $NUM_REPS; i++ )) 
# do
# 	echo "Running Java benchmark 2 ($i out of $NUM_REPS)"
# 	../wrapped "java -Xmx5000m codigo"	
# done

# cp tam2_3.txt in1.txt
# for (( i = 1; i <= $NUM_REPS; i++ )) 
# do
# 	echo "Running Java benchmark 3 ($i out of $NUM_REPS)"
# 	../wrapped "java -Xmx5000m codigo"	
# done

echo -e "------------------------------ Python"

cp tam2_1.txt in1.txt
for (( i = 1; i <= $NUM_REPS; i++ )) 
do
	echo "Running Python benchmark 1 ($i out of $NUM_REPS)"
	../wrapped "python string.py"	
done

cp tam2_2.txt in1.txt
for (( i = 1; i <= $NUM_REPS; i++ )) 
do
	echo "Running Python benchmark 2 ($i out of $NUM_REPS)"
	../wrapped "python string.py"	
done

cp tam2_3.txt in1.txt
for (( i = 1; i <= $NUM_REPS; i++ )) 
do
	echo "Running Python benchmark 3 ($i out of $NUM_REPS)"
	../wrapped "python string.py"	
done

exit