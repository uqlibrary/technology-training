# data from https://data.brisbane.qld.gov.au/explore/dataset/park-locations

# pip install geopandas
import geopandas as gpd

parks = gpd.read_file("park-locations.geojson")

parks
# can use the variable viewer

# area of polygons
parks.area


# set index to park name
parks = parks.set_index("park_name")

# "geographic CRS" warning:
# we can re-project to a projected CRS
# https://epsg.io/7856 is GD202 / zone 56
parks = parks.to_crs("EPSG:7856")
parks.crs
parks.area.sort_values()
biggest_parks = parks.area.sort_values(ascending=False)

# plot parks
parks.plot()
parks.plot("park_size", legend=True)
# discrete values are not very useful here

# add continuous area column
parks["area"] = parks.area
parks.plot("area", legend=True)

# interactive
interactive = parks.explore()
interactive.save("interactive.html")

# import toilets
toilets = gpd.read_file("public-toilets-in-brisbane.geojson")
toilets = toilets.to_crs("EPSG:7856")

all_toilets = toilets.dissolve()

parks.contains(all_toilets).sum()


# check if they are within
toilets.within(parks)
# Check if there are toilets within 300m
toilets.contains(parks.buffer(300)).sum()
parks.contains(toilets)


def in_park(row, points):
    return parks.contains(points).any()


# park polygons
m = park.explore()

# toilets overlayed in black
toilet.explore(m=m, color="black", marker_kwds={"radius": 3})

ax = park["geometry"].plot()
toilet.plot(ax=ax, color="black")

# gdf.to_file("export.geojson", driver = "GeoJSON")
