import os
import requests
from datetime import datetime, timezone
import textwrap


def update_live_links() -> None:
    # Call StudentHub api, get sessions
    r = requests.get(
        "https://api.library.uq.edu.au/v1/training_events?take=100&filterIds[]=104&ts=1745812216416",
        headers={
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0"
        },
    )

    r.raise_for_status()

    sh_body = r.json()

    with open("_quarto.yml") as f:
        project_file = f.read()

    # Go through pages on site
    for path, dirs, files in os.walk(".\\"):
        if len(path) > 2 and (path[2] == "_" or path[2] == "."):
            continue

        # Only consider files that are getting published (i.e., in _quarto.yml)

        # Currently DOES NOT WORK FOR IPYNB
        content_filepaths = [
            os.path.join(path, file)
            for file in files
            if (file in project_file)
            and (file[-2:] == "md")  # or file[-6:] == ".ipynb")
        ]

        for qmd_path in content_filepaths:
            # Get title
            with open(qmd_path, encoding="utf8") as f:
                content = f.read()

            title_start = content.find("title") + 6
            title = content[title_start : content.find("\n", title_start)]

            clean_title = clean(title)

            date = None
            upcoming_event: dict = {}

            for event in sh_body:
                new_date = datetime.strptime(event["start"], "%Y-%m-%dT%H:%M:%S%z")
                if clean_title in clean(event["name"]) and (
                    date is None or new_date < date
                ):
                    upcoming_event = event

            if len(upcoming_event) > 0:
                # upcoming_event stores everything
                link = f"https://studenthub.uq.edu.au/students/events/detail/{upcoming_event["entityId"]}"
                booking_message = "[Book in to the next offering now.]"
                formatted_date = datetime.strptime(
                    upcoming_event["start"], "%Y-%m-%dT%H:%M:%S%z"
                ).strftime("%a %b %d at %I:%M %p.")

                message = f"""
                <!-- Do not touch this - it will automatically update during render -->
                :::{{.callout-tip}}
                # Upcoming workshop(s) available!

                The next workshop is on **{formatted_date}**
                
                {booking_message}({link})

                Alternatively, [check our calendar](https://web.library.uq.edu.au/study-and-learning-support/training-and-workshops/online-and-person-workshops#keyword=;campus=;weekstart=) for future events.
                :::
                """
                message = textwrap.dedent(message)

                # Check if existing message present

                if message[:100] in content:
                    # Replace link
                    line_start = content.find(booking_message)

                    link_start = content.find(
                        "https://studenthub.uq.edu.au/students/events/detail/",
                        line_start,
                    )

                    line_end = content.find("\n", link_start)

                    new_content = "".join(
                        [content[:link_start], link, ")", content[line_end:]]
                    )
                else:
                    i_start = content.find("---", content.find("---") + 5) + 5

                    new_content = "\n".join(
                        [content[:i_start], message, content[i_start:]]
                    )
            else:
                message_start = content.find(
                    "<!-- Do not touch this - it will automatically update during render -->"
                )

                if message_start == -1:
                    new_content = content

                else:
                    message_end = content.find(":::", content.find(":::") + 3) + 4

                    new_content = "".join(
                        [content[:message_start], content[message_end:]]
                    )

            with open(qmd_path, "w", encoding="utf8") as f:
                f.write(new_content)

    return None


def clean(s: str) -> str:
    s = s.strip().lower().replace(r"\n", "")
    new_s = list(s)
    for i, char in enumerate(s):
        if not char.isalnum():
            new_s[i] = ""

    return "".join(new_s)


if __name__ == "__main__":
    update_live_links()
