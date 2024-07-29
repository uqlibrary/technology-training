import pathlib
from bs4 import BeautifulSoup
import pandas as pd

def convert_tables(raw_md: str):
    """Convert HTML tables into markdown"""

    soup = BeautifulSoup(raw_md, "html.parser")
    md_tables = []

    # Read tables in with pandas, export to markdown
    for table in soup.find_all("table"):
        data = pd.read_html(str(table), index_col=0)[0]

        md_tables.append(data.to_markdown())


    # Cycle through HTML tables and replace with MD, using 
    new_tag = soup.new_tag("temp")
    length = len(soup.find_all("div"))

    for i in range(0, length):

        new_tag.string = md_tables[i]       

        soup.find("div").replace_with(new_tag)

        soup = soup.__copy__()


    clean_md = soup.text

    clean_md.replace("<temp>", "")    
    clean_md.replace("</temp>", "")    

    return clean_md        


in_path = r"C:\Users\uqcwest5\OneDrive - The University of Queensland\Tech Training\technology-training\Python\revamp\md\data_transformation.md"
out_path = r"C:\Users\uqcwest5\OneDrive - The University of Queensland\Tech Training\technology-training\Python\revamp\data_transformation.md"

with open(in_path) as f:
    clean_md = convert_tables(f.read())
    f.close()

with open(out_path, "w") as f:
    f.write(clean_md)
    f.close()