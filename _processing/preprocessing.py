import check_links
import update_live_links
import os

if os.getenv("IN_GITHUB_WORKFLOW") == "true":
    # Insert banners for upcoming events
    print("\nUpdating live links")
    update_live_links.update_live_links()
else:
    # Check for broken links and update logs
    print("\nChecking for broken links")
    check_links.check_links(verbose=True)

print("Preprocessing complete.")
