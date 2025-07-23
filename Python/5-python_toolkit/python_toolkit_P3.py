import os
import reader

print("Running the Python Toolkit Program")
print(f"The current working directory is {os.getcwd()}")

# Check that the folder exists in our working directory
if os.path.exists("texts"):
    print("The folder /texts/ exists.")
else:
    raise FileNotFoundError("Cannot find the folder /texts/.")

files_in_texts = os.listdir("texts")

# Check that there are five files within texts
if len(files_in_texts) != 5:
    raise FileNotFoundError("Incorrect number of files in /texts/.")

#### Part 2 ####
files_in_texts = os.listdir("texts")

for text_path in files_in_texts:
    words = reader.read_book_words(f"texts/{text_path}") 

    unique_words = set(words)

    word_count = len(words)
    unique_word_count = len(unique_words)
    ratio = unique_word_count / word_count

    print()
    print(f"There are {word_count} words in {text_path[:-4]}.")
    print(f"There are {unique_word_count} different words in {text_path[:-4]}.")
    print(f"The unique word ratio is {unique_word_count / word_count}")

    files_in_texts = os.listdir("texts")