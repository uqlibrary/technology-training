import check_links
import update_live_links

print("\nChecking for broken links")
check_links.check_links()

print("\nUpdating live links")
update_live_links.update_live_links()

print("Preprocessing complete.")
