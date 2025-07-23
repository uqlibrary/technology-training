def write(path, contents, mode = "a"):
    """Writes 'contents' to the file at 'path'. 'mode' is passed to open()"""
    with open(path, mode) as file:
        file.write(contents)

def fib_i(i):
    """Calculates the ith element of the Fibonacci sequence."""
    Fibonacci = [1,1]

    while len(Fibonacci) < i:
        # Calculate next digit in sequence
        n = Fibonacci[-1] + Fibonacci[-2]

        # Append to list
        Fibonacci.append(n)

    return Fibonacci[-1]