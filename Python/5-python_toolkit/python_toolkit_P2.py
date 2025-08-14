import os

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
    
    title = text_path[:-4]

    with open(f"texts/{text_path}", encoding = "utf-8") as file:
        contents = file.read()

    words = contents.split()
    unique_words = set(words)

    word_count = len(words)
    unique_word_count = len(unique_words)
    ratio = unique_word_count / word_count

    print()
    print(f"There are {word_count} words in {title}.")
    print(f"There are {unique_word_count} different words in {title}.")
    print(f"The unique word ratio is {unique_word_count / word_count}")

    # Remove front/end matter and save clean files
    start_message = "*** END OF THE PROJECT GUTENBERG EBOOK"
    end_message = "*** END OF THE PROJECT GUTENBERG EBOOK"

    start = contents.find(start_message) + len(start_message)
    end = contents.find(end_message)

    clean_text = contents[start:end]

    with open(f"{title}_clean.txt", "w", encoding = "utf-8") as file:
        file.write(clean_text)