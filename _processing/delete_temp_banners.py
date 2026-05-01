import os
from glob import glob


def delete_temp_banners():
    print("Deleting temporary banner files.")

    for banner_path in glob("**/*_banner.md", recursive=True):
        os.remove(banner_path)


if __name__ == "__main__":
    delete_temp_banners()
