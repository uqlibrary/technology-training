from os import path
from update_live_links import list_published_files

# In general, use the following loop to update all published qmds
# Currently coded to insert the banner embed shortcodes

for qmd_path in list_published_files():
    # 1. open the file
    with open(qmd_path) as file:
        source = file.read()

    # 2. find end-of-yaml
    end_of_yaml = source.find("\n", source.find("---", source.find("---") + 1)) + 1

    # 3.1 Create banner path
    banner_path = path.splitext(path.basename(qmd_path))[0] + "_banner.qmd"

    # 3.2 insert shortcode
    shortcode = R"{{< embed " + banner_path + " >}}"

    source = source[:end_of_yaml] + "\n" + shortcode + "\n" + source[end_of_yaml:]

    # # Uncomment if prepared to make changes!!
    # # 4. save to file
    # with open(qmd_path, "w") as file:
    #     file.write(source)
