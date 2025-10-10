import os
import requests
from datetime import datetime, timezone
import textwrap
import yaml

MESSAGE_HEADER = f"<!-- Upcoming workshops -->"


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

    # Loop through active QMDs and update
    for qmd_path in list_active_qmds():

        with open(qmd_path, encoding="utf8") as f:
            content: str = f.read()

        # Get title
        title_start = content.find("title") + 6
        title = content[title_start : content.find("\n", title_start)]
        clean_title = clean(title)

        # Get earliest upcoming event
        date = None
        upcoming_event: dict = {}

        for event in sh_body:
            new_date = datetime.strptime(event["start"], "%Y-%m-%dT%H:%M:%S%z")
            if clean_title in clean(event["name"]) and (
                date is None or new_date < date
            ):
                upcoming_event = event

        if len(upcoming_event) == 0:
            continue

        # Form message
        link = f"https://studenthub.uq.edu.au/students/events/detail/{upcoming_event["entityId"]}"
        booking_message = "[Book in to the next offering now.]"
        formatted_date = datetime.strptime(
            upcoming_event["start"], "%Y-%m-%dT%H:%M:%S%z"
        ).strftime("%a %b %d at %I:%M %p.")

        message = textwrap.dedent(
            f"""
        {MESSAGE_HEADER}
        :::{{.callout-tip}}
        # Upcoming workshop(s) available!

        The next workshop is on **{formatted_date}**
        
        {booking_message}({link})

        Alternatively, [check our calendar](https://web.library.uq.edu.au/study-and-learning-support/training-and-workshops/online-and-person-workshops#keyword=;campus=;weekstart=) for future events.
        :::
        """
        )

        # Insert message after YAML
        yaml_end = content.find("---", content.find("---") + 4) + 5
        new_content = "".join([content[:yaml_end], message, content[yaml_end:]])

        with open(qmd_path, "w", encoding="utf8") as f:
            f.write(new_content)

    return None


def remove_upcoming_links() -> None:
    """Loops through active .qmds and removes the upcoming links message. Directly reverses changes made by update_live_links()."""
    for qmd_path in list_active_qmds():

        with open(qmd_path, encoding="utf8") as f:
            content: str = f.read()

        if MESSAGE_HEADER not in content:
            continue

        message_start = content.find(MESSAGE_HEADER)
        message_end = content.find(":::", content.find(":::", message_start) + 4) + 5

        old_message = content[message_start:message_end]

        new_content = content.replace(old_message, "")

        with open(qmd_path, "w", encoding="utf8") as f:
            f.write(new_content)

    return None


def clean(s: str) -> str:
    """Returns a lowercase copy of s stripped of all whitespace and punctuation."""
    s = s.strip().lower().replace(r"\n", "")
    new_s = list(s)
    for i, char in enumerate(s):
        if not char.isalnum():
            new_s[i] = ""

    return "".join(new_s)


def list_active_qmds() -> list[str]:
    """Walks through current dir and returns a list of qmds that are also in _quarto.yml"""
    with open("_quarto.yml") as f:
        project_file = f.read()

    content_filepaths = []
    # Go through pages on site
    for path, dirs, files in os.walk(".\\"):
        if len(path) > 2 and (path[2] == "_" or path[2] == "."):
            continue

        # Only consider files that are getting published (i.e., in _quarto.yml)
        content_filepaths += [
            os.path.join(path, file)
            for file in files
            if (file in project_file)
            and (file[-2:] == "md")  # or file[-6:] == ".ipynb")
        ]

    return content_filepaths


if __name__ == "__main__":
    print("*******DEBUGGING update_live_links()*********")
    update_live_links()
    print()
    input(
        "Upcoming links are temporarily in .qmd files.\n\nPress enter to remove them and finish."
    )
    remove_upcoming_links()
