import update_live_links
import os

if os.getenv("IN_GITHUB_WORKFLOW") == "true":
    update_live_links.remove_upcoming_links()
