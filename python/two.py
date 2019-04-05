import sys

def main():
    exercise1()

# ---------------------------------------------------------- Exercise 1
def exercise1():
    """ Prints file info """
    fileName = "D:\Software\Games\Overcooked.Gourmet.Edition.rar"

    print(fileName)

def printFileInfo(fileName):

    file = open(fileName)
    close(file)

if __name__ == "__main__":
    main()
