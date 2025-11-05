# if needed, install it first:
# pip install geopandas

# import module
import geopandas as gpd

# import the park polygons
parks = gpd.read_file("park-locations.geojson")

# see the contents
parks

# visualise (static)
parks.plot()
parks.plot("park_size", legend=True)

# what is the area of each polygon?
parks.area
# re-project to do more precise calculations.
parks = parks.to_crs("EPSG:7856")
parks.area  # no more warning
# check CRS
parks.crs

# biggest ones?
parks.area.sort_values(ascending=False)

# change the index to the park name
parks = parks.set_index("park_name")
parks.area.sort_values(ascending=False)

# add the areas to the geodataframe
parks["area"] = parks.area
parks.plot("area", legend=True)

# interactive plot
# (this needs folium and mapclassify)
interactive = parks.explore()
# export it to a file
interactive.save("interactive.html")

# import toilets
toilets = gpd.read_file("public-toilets-in-brisbane.geojson")
# use same CRS as parks
toilets = toilets.to_crs(parks.crs)

joined = gpd.sjoin(parks, toilets, how="left", predicate="contains")

toilets_per_park = joined.groupby("park_name")["facilityid"].count()

parks = parks.merge(toilets_per_park, on="park_name", how="left")

parks = parks.rename(columns={"facilityid": "num_toilets"})

parks.plot("num_toilets")

all_toilets = toilets.dissolve()

parks.covers(all_toilets, legend=True)

parks["has_toilet"] = parks["num_toilets"] > 0

parks.plot("has_toilet", legend=True)

parks.explore("has_toilet", legend=True)
