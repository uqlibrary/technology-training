import datetime
import os
import re
import requests
import pandas as pd


def test_link(link: str, path_from: str = os.getcwd()) -> tuple[str, str | Exception]:
    """
    Checks whether link is valid/live.

    For URLs, uses custom header specifying user agent.

    Note that emails and intra-file references are NOT
    tested and SILENTLY IGNORED.

    For local, relative file addresses, path_from is
    prepended to link. If link is and absolute path,
    path_from is ignored.

    Returns flag, message

    - flag is a short string indicating test result.

    - message is a longer string or exception with more
    details. For HTTP requests returning non-200 codes,
    this message provides the code. For Python errors,
    this is the exception. Otherwise an appropriate
    description of the issue is given.
    """

    message = ""

    if "http" in link:
        # URLs
        headers = {"User-Agent": "TestLiveURLbot (cameron.west@uq.edu.au)"}
        try:
            response_code = requests.head(
                link, allow_redirects=True, headers=headers, timeout=10
            ).status_code
        except Exception as e:
            flag = "BROKEN"
            message = e
        else:
            if response_code != 200:
                # warning(f"http request to {link} returns status code {response_code}")
                if response_code == 404:
                    flag = "BROKEN"
                else:
                    flag = "CHECK"

                message = f"HTTP response: {response_code}"
            else:
                flag = "OK"
    elif "@" in link or link[0] == "#" or link[:11] == "attachment:":
        # Intra-file links and emails - currently not checking
        flag = "EXEMPT"
        message = "Unsupported link type for checking."
    elif "." in link:
        # Inter-file links
        link_path = link if os.path.isabs(link) else os.path.join(path_from, link)

        if os.path.isfile(link_path):
            flag = "OK"
        else:
            # warning(f"File {link} not found")
            flag = "BROKEN"
            message = f"FileNotFoundError"
    else:
        flag = "CHECK"
        message = "Manually verify"

    return flag, message


def check_links(
    log_path: str = "_processing/check_links_log.csv", verbose: bool = False
) -> None:
    """
    Tests the links present in all .*md and .ipynb files
    specified in _quarto.yml and logs output in log_path.
    Use verbose = True for a supplementary summary in the
    console.
    """

    log = []
    unchecked_ok_links = []

    valid_links = pd.read_csv("_processing/validated_links.csv")
    ok_links = pd.read_csv("_processing/ok_links.csv")

    with open("_quarto.yml") as f:
        project_file = f.read()

    # Loop through all .md and .qmd files
    for path, dirs, files in os.walk("."):
        if len(path) > 2 and (path[2] == "_" or path[2] == "."):
            continue

        # Only consider files that are getting published (i.e., in _quarto.yml)
        content_filepaths = [
            os.path.join(path, file)
            for file in files
            if (file in project_file) and (file[-2:] == "md" or file[-6:] == ".ipynb")
        ]

        for qmd_path in content_filepaths:
            if verbose:
                print(f"CHECKING: {qmd_path}")

            with open(qmd_path, encoding="utf8") as f:
                qmd_content = f.read()

            # Find every link
            # Explanation of regex:
            # (?<=\]\()  = positive lookbehind for ](
            # [^\(\)]*   = matches 0 or more characters until ( or )
            # (\(.*?\))* = matches 0 or more of the following group: (...), where ... is any character
            # [^\(\)]*   = matches 0 or more characters until ( or )
            # (?=\))     = positive lookahead for )
            matches = re.finditer(
                r"(?<=\]\()[^\(\)]*(\(.*?\))*[^\(\)]*(?=\))", qmd_content
            )

            for match in matches:
                link = match.group(0)

                # If ok and checked in last month
                if link in ok_links["link"].to_list():
                    date = ok_links[ok_links["link"] == link]["date"].to_list()[0]
                    date = datetime.datetime.strptime(date, "%Y-%m-%d")

                    if (datetime.datetime.now() - date).days <= 30:
                        unchecked_ok_links.append((link, date.strftime("%Y-%m-%d")))

                        continue

                flag, message = test_link(link, path)

                if link in valid_links["link"].to_list():
                    date = valid_links[valid_links["link"] == link]["date"].to_list()[0]

                    flag = f"VALID on {date}"

                log.append((flag, message, link, qmd_path))

                if verbose:
                    print(f"\t{flag}\t{link}")

    # Messy. There's a better way to manage this surely.
    log_df = pd.DataFrame(log, columns=["flag", "message", "link", "source"])

    log_df[log_df["flag"] != "OK"].sort_values("flag").to_csv(log_path)

    OK_df = log_df[log_df["flag"] == "OK"].drop(columns=["flag", "message", "source"])
    OK_df["date"] = datetime.datetime.now().strftime("%Y-%m-%d")

    unchecked_df = pd.DataFrame(unchecked_ok_links, columns=["link", "date"])
    OK_df = pd.concat([unchecked_df, OK_df])

    # Only store URLs (these are the time consuming ones)
    OK_df = OK_df[OK_df["link"].str.contains("http")]
    OK_df.to_csv("_processing/ok_links.csv")

    if (
        len(
            log_df[
                (log_df["flag"] != "OK")
                & (log_df["flag"].str.contains("VALID") == False)
            ]
        )
        > 0
    ):
        print("WARN: Broken links found. Check _processing/check_links_log.csv")


if __name__ == "__main__":
    check_links(verbose=True)
