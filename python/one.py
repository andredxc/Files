
def main():
    exercise5()
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

# ---------------------------------------------------------- Exercise 5
def exercise5():
    str = "The cat climbed up the roof"
    print("Original string: %s" %(str))
    print("New string: %s " %(invertSentence(str)))
    return

def invertSentence(originalStc):
    """Inverts every word in 'originalStc'"""
    i = 0
    newStc = str()
    while i < len(originalStc)-1:
        # print("Ind: %d, stc: %s" %(i, newStc))
        ind = i
        (i, word) = findNextWord(originalStc, ind, len(originalStc)-1)
        newStc += invertWord(word) + " "

    return newStc

def findNextWord(stc, i, j):
    """Find word in a sentence between indexes 'i' and 'j'"""
    for k in range(i, j+1):
        if (k == i and stc[k].isalpha()) or (stc[k].isalpha() and stc[k-1] == ' '):
            # Found new word
            for m in range(k, len(stc)):
                # Find the last letter of the word
                if stc[m] == ' ':
                    # Found last letter before a space
                    return (m, stc[k:m])
                elif m == len(stc)-1:
                    # Found last letter in the string
                    return (m, stc[k:m+1])
    # Error finding any word
    raise SystemError

def invertWord(word):
    """Inverts the letters in a single word"""
    return word[::-1]













if __name__ == "__main__":
    main()
