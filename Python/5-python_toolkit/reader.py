def read_book_words(path):  
    with open(path, encoding = "utf-8") as file:
        contents = file.read()
    
    return contents.split()