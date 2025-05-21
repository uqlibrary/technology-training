def write(path, contents, mode = "a"):
    with open(path, mode) as file:
        file.write(contents)

def read(path):
    with open(path) as file:
        return file.read()


a = 1
print(a)

