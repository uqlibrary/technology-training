from os import path
from update_live_links import list_published_files

# In general, use the following loop to update all published qmds
# Currently coded to replace something

for qmd_path in list_published_files():
    # 1. open the file
    with open(qmd_path) as file:
        source = file.read()

    source = source.replace("_banner.qmd", "_banner.md")

    # Uncomment if prepared to make changes!!
    # 4. save to file
    with open(qmd_path, "w") as file:
        file.write(source)
