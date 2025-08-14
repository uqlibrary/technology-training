def read_book(path):  
    with open(path, encoding = "utf-8") as file:
        contents = file.read()
    
    return contents