
def main():
    exercise4()
    return

# ---------------------------------------------------------- Exercise 1
def exercise1():
    temp = 90.0
    print("%.2f C = %.2f F" %(temp, celsiusToFahrenheit(temp)))
    print("%.2f F = %.2f C" %(temp, fahrenheitToCelsius(temp)))

def celsiusToFahrenheit(temp):
    return 9.0*temp/5.0 + 32

def fahrenheitToCelsius(temp):
    return (temp - 32)*5/9

# ---------------------------------------------------------- Exercise 2
def exercise2():
    stop = 100
    for num in range(stop):
        if isPrime(num):
            # Prime number
            print("%d\tPRIME" %(num))

def isPrime(num):

    for div in range(2, num):
        if num%div == 0 and div != num:
            return False

    return True

# ---------------------------------------------------------- Exercise 3
def exercise3():
    list = [1, 2, 3, 4, [5, 6, 7, 8], 9, 10, [11, 12, 100]]
    print("Original list:")
    print(list)
    print("Straightened list:")
    print(straightenList(list))

def straightenList(oldList):

    newList = list()

    for node in oldList:
        if isinstance(node, list):
            # Node is a list
            for element in node:
                newList.append(element)
        else:
            # Node is an element
            newList.append(node)

    return newList

# ---------------------------------------------------------- Exercise 4
def exercise4():
    dict = {"key1": 2, "key2":3, "key3":9}
    dictionaryStats(dict)
    return

def dictionaryStats(dict):

    sum = 0

    # Calculate sum
    for value in dict.values():
        sum = sum + value

    # Calculate mean
    mean = sum/len(dict)

    # Calculate variance
    acc = 0
    for value in dict.values():
        acc = acc + (value - mean)**2

    variance = acc/(len(dict) - 1 )

    print("Sum: %.2f, Mean: %.2f, Variance: %.2f" %(sum, mean, variance))















if __name__ == "__main__":
    main()
