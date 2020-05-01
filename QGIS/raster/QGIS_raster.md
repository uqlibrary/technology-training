# QGIS intermediate: raster analysis

## Setting up

This tutorial is designed for **QGIS 3.6** and above. If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a new project with `Project > New`.
Let's straight away **save** our project: `Project > Save`. We should create a new folder, where our project and all the saved data will live.

Let's set the **project home** too: `Project > Properties > General` and set `Project home` to the same folder. This is where we can also give the project a title.

Let's also add an OpenStreetMap basemap to locate ourselves on the globe: `Browser panel > XYZ Tiles > OpenStreetMap`

## Get some data

We are using a Digital Elevation Model (DEM) sourced from the USGS website.

* Go to https://earthexplorer.usgs.gov/
* Search for "Brisbane" in the "Address/Place" search box and select the first result
* Zoom onto an area of interest around Brisbane and click "Use Map"
* Click `Data Sets > Digital Elevation > SRTM`, select "SRTM 1 Arc-Second Global" and click "Results"

"SRTM" stands for "[Shuttle Radar Topography Mission](https://www.usgs.gov/centers/eros/science/usgs-eros-archive-digital-elevation-shuttle-radar-topography-mission-srtm-1-arc?qt-science_center_objects=0#qt-science_center_objects)". It provides global elevation data collected in 2000 by the space shuttle Endeavour.

Our area covers two separate raster files. We can click on the foot icon to see the footprint of each file, and the picture icon to see what the DEM looks like.

Use the download button to download each file into your project directory. You will need a login for that, which is free but can take a bit of time. You can instead download the two raster files as an archive from [here](https://cloudstor.aarnet.edu.au/plus/s/US2uOtwTu78Gpxq).

## Build a virtual raster

If you downloaded the archive, make sure you extract it into the project directory.

From the Browser panel, we can drag and drop each `.tif` file into the Layers panel.

See the visible line between the two raster tiles? We have to merge them.

To do that, we use the `Raster > Miscellaneous > Build Virtual Raster...` tool to create one single layer from them.

* First, select both DEM layers for the "Input layers"
* Make sure you untick the option "Place each input file into a separate band", as we want to end up with one single-band layer
* We can save the output on disk instead of only creating a temporary file (for example, name it `SRTM_DEM_merged` and save it inside your project directory)
* Click "Run"

> You will need to have Saga installed for this to work.

We can now remove the two original raster files, and rename our virtual layer.

## Clip the DEM

We now use `Raster > Extraction > Clip Raster by Extent` to focus on a smaller area of interest.

Make sure the DEM is selected in the Input layer, and set the clip extent with `... > Select Extent on Canvas`. We want to select an area that is inland, and contains both some of the D'Aguilar National Park, and a section of the Brisbane river (you can untick the DEM in the Layers panel to reveal the basemap).

Remember to rename your clipped layer!

## Change the symbology

We can style our DEM with a terrain colour palette:

* double-click on the clipped DEM layer
* go to the "Symbology" tab
* change the Render type to "Singleband pseudocolor"
* by default, it uses the min/max values, which is what we want
* we can change the "Color ramp" to something more suitable with the drop-down menu and `Create new color ramp... > Catalog: cpt-city > Topography > Elevation`, for example.

## Add a hillshade

Adding a hillshade makes your visualisation of elevation more readable and visually pleasing by giving an artificial lighting look to your map.

*  Right-click on the DEM layer and "Duplicate layer"
*  Rename the duplicated layer "hillshade"
*  Open the Symbology menu for the hillshade layer
*  Change the "Render type" to "Hillshade"
*  The defaults should work well, but you can play with the settings, like the Altitude and the Azimuth
*  Make sure you apply some transparency to the pseudocolour DEM, and place the hillshade layer underneath

> If you are bothered by visible hillshade grids when zooming into the map, you can change the "Resampling" method to "Bilinear" or "Cubic" instead of "Nearest neighbour".
> Another methods is to use the hillshade tool instead of the symbology: `Raster > Analysis > Hillshade...`.

## Create a watershed layer

Using the Strahler tool, we can create a watershed raster that shows where water would flow according to the DEM.

Open the Processing Toolbox (cog icon) and try using the SAGA tool called "Strahler order" (a temporary file is fine for now).

Look at the result. It seems there is an issue with our data.
A common problem with DEMs is that they have sinks and spikes that will make further analyses more difficult.

We can use the "Fill sinks (Wang & Liu)" tool to fill the sinks in our clipped DEM. We only need to load the "Filled DEM" output, which we can also save to file.

If we re-run the Strahler order tool on the filled DEM, we will be able to see more useful data.

We can now colour the layer with "Singleband pseudocolor" to highlight the bigger streams.

To filter out the noise of the smaller streams, we can use the `Raster > Raster Calculator` tool and use the formula: `"strahler_filtered@1" >= 8`
This will only keep the major streams in the network.

## Channel network and drainage basin

Another analysis we can do is use the "Channel network and drainage basins" tool to calculate the flow direction, channels and drainage basins.

Make sure you run this tool on the filled DEM.
As an ouptut, we only want to load (and save to file):

* Flow Direction (raster)
* Channels (shapefile)
* Drainage basins (shapefile) (to differentiate the two "Drainage basins" options, you can check what format it saves the file as)

We can now play with the symbology for those elements.

## 3D maps

A 3D viewer are integrated in QGIS: `View > New 3D Map View`

A useful plugin for 3D maps is qgis2threeJS.

## Saving your project

Notice the little icon next to some of your layers? We previously created "temporary scratch layers". This is useful if you keep processing data and creating new layers that you want to discard afterwards. In our case, we do want to keep the "cities" and "rivers" layers, so we need to save them to a file. If we try to close QGIS with scratch layers loaded, it will give you a warning that they will be lost in the process.

You can click on the scratch layer icon to save the file. In the dialog, we can give the layers a `File name` (in our project's home directory) and click OK.

You can save your project with the floppy disk icon, or using <kbd>Ctrl</kbd> + <kbd>S</kbd>, and the project should be visible in a list as soon as you open QGIS again.