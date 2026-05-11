import os
from glob import glob
import requests
from datetime import datetime, timezone, timedelta
import textwrap

import delete_temp_banners


def update_live_links() -> None:
    """Loops through active .qmds looking for matches with upcoming StudentHub events. On match hit, injects an upcoming event message with links."""
    # Call StudentHub api, get sessions
    r = requests.get(
        "https://api.library.uq.edu.au/v1/training_events?take=100&filterIds[]=104&ts=1745812216416",
        headers={
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0"
        },
    )

    r.raise_for_status()
    sh_body = r.json()

    # Loop through active files and update
    for published_path in list_published_files():

        with open(published_path, encoding="utf8") as f:
            content: str = f.read()

        # Get title
        title_start = content.find("title") + 6
        title = content[title_start : content.find("\n", title_start)]

        titles = []
        if published_path[-6:] == ".ipynb":
            titles = [clean(title)]

        elif "Word" in title or "Excel" in title or "NVivo" in title:
            h1_end = 0
            while True:
                h1_start = content.find("## ", h1_end)
                if h1_start == -1:
                    break
                h1_end = content.find("\n", h1_start)

                session_title = (
                    title.replace('"', "").replace("Microsoft", "")
                    + ": "
                    + content[h1_start:h1_end].replace("## ", "")
                )

                titles.append(clean(session_title))

        else:
            titles = [clean(title)]
            # Instead use heading 1s

        for clean_title in titles:

            # Get earliest upcoming event
            start = None
            upcoming_event: dict = {}

            for event in sh_body:
                new_start = datetime.strptime(event["start"], "%Y-%m-%dT%H:%M:%S%z")

                if clean_title in clean(event["name"]) and (
                    start is None or new_start < start
                ):
                    upcoming_event = event
                    start = new_start

            banner_path = os.path.splitext(published_path)[0] + "_banner.qmd"

            if start is None:
                message = ""
            else:
                print(f"Creating banner in {banner_path}")

                # Form message
                link = f"https://studenthub.uq.edu.au/students/events/detail/{upcoming_event['entityId']}"
                booking_message = "[Book in to the next offering now.]"

                today = datetime.now(timezone(timedelta(hours=10)))

                if start.date() == today.date():
                    formatted_date = start.strftime("today at %I:%M %p.")
                elif start.date() == today.date() + timedelta(days=1):
                    formatted_date = start.strftime("tomorrow at %I:%M %p.")
                else:
                    formatted_date = start.strftime("%a %b %d at %I:%M %p.")

                message = textwrap.dedent(f"""
                ::: 
                {{.callout-tip}}

                # Upcoming workshop(s) available!

                The next workshop is on **[{formatted_date}]({link})**

                Alternatively, [check our calendar](https://web.library.uq.edu.au/study-and-learning-support/training-and-workshops/online-and-person-workshops#keyword=;campus=;weekstart=) for future events.
                
                :::
                """)
                message = message[1:]

                if published_path[-6:] == ".ipynb":
                    message = message[:-1]
                    message = message.replace("\n", '\\n",\n    "')
                    message = message.replace('""', R'"\n"')
                    message = '    "' + message + '\\n",\n'

            # Create / overwrite banner
            with open(banner_path, "w") as f:
                f.write(message)

    return None


def clean(s: str) -> str:
    """Returns a lowercase copy of s stripped of all whitespace and punctuation."""
    s = s.strip().lower().replace(r"\n", "")
    new_s = list(s)
    for i, char in enumerate(s):
        if not char.isalnum():
            new_s[i] = ""

    return "".join(new_s)


def list_published_files() -> list[str]:
    """Walks through current dir and returns a list of qmds that are also in _quarto.yml"""
    with open("_quarto.yml") as f:
        project_file = f.read()

    content_filepaths = []
    # Go through pages on site
    for path, dirs, files in os.walk("./"):
        if len(path) > 2 and (path[2] == "_" or path[2] == "."):
            continue

        # Only consider files that are getting published (i.e., in _quarto.yml)
        content_filepaths += [
            os.path.join(path, file)
            for file in files
            if (file in project_file) and (file[-2:] == "md" or file[-6:] == ".ipynb")
        ]

    return content_filepaths


if __name__ == "__main__":
    print("*******DEBUGGING update_live_links()*********")
    update_live_links()
    print()
    input(
        "Upcoming links are temporarily in .qmd files.\n\nPress enter to remove them and finish."
    )
    delete_temp_banners.delete_temp_banners()
