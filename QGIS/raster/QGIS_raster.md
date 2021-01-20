# QGIS intermediate: raster analysis

## Setting up

This tutorial is designed for **QGIS 3.10**. If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a **new project** with `Project > New`.
Let's straight away **save** our project: `Project > Save`. We should create a new folder, where our project and all the saved data will live, named "qgis_raster_intro" for example.

Let's set the **project home** too: `Project > Properties > General` and set `Project home` to the same folder. This is where we can also give the project a title.

Let's also add an OpenStreetMap basemap to locate ourselves on the globe: `Browser panel > XYZ Tiles > OpenStreetMap` (double-click, or drag and drop into the Layers panel).

## Get some elevation data

A Digital Elevation Model (DEM) is a common example of **raster data**, i.e. grid data that contains a value in each cell (a bit like the pixels in a coloured picture).

For this tutorial, we are using a DEM sourced from the USGS website.

* Go to https://earthexplorer.usgs.gov/
* Search for "Brisbane" in the "Address/Place" search box and select the first result
* Zoom onto an area of interest around Brisbane and click "Use Map"
* Click `Data Sets > Digital Elevation > SRTM`, select "SRTM 1 Arc-Second Global" and click "Results"

"SRTM" stands for "[Shuttle Radar Topography Mission](https://www.usgs.gov/centers/eros/science/usgs-eros-archive-digital-elevation-shuttle-radar-topography-mission-srtm-1-arc?qt-science_center_objects=0#qt-science_center_objects)". It provides global elevation data collected in 2000 by the space shuttle Endeavour.

Our area covers two separate raster files. We can click on the foot icon to see the footprint of each file, and the picture icon to see what the DEM looks like.

Use the download button to download each file into your project directory. You will need a login for that, which is free but can take a bit of time. You can instead **download the two raster files** as an archive from [here](https://cloudstor.aarnet.edu.au/plus/s/US2uOtwTu78Gpxq).

## Build a virtual raster

If you downloaded the archive, make sure you place it into the project directory so you can find it in "Project Home" and easily **load the raster files**: from the Browser panel, we can go into the data archive and drag and drop each `.tif` file into the Layers panel.

See the visible line between the two raster tiles? That is because the two separate raster files have different maximum and minimum values, so use different shades for different elevations. We have to **merge** them to make sure they use the same colour scale.

To do that, we use the `Raster > Miscellaneous > Merge...` tool to create one single layer from them.

* First, select both DEM layers for the "Input layers"
* Make sure the option "Place each input file into a separate band" is off, as we want to end up with one single-band layer
* We can save the output on disk instead of only creating a temporary file (for example, name it `SRTM_DEM_merged` and save it inside your project directory)
* Click "Run"

> You will need to have GDAL installed for this to work.

We can now remove the two original raster files.

## Clip the DEM

We now use `Raster > Extraction > Clip Raster by Extent` to **focus on a smaller area of interest**.

Make sure the DEM is selected in the Input layer, and set the clip extent with `... > Select Extent on Canvas`. We want to select an area that is inland, and contains both some of the D'Aguilar National Park, and a section of the Brisbane river (you can untick the DEM in the Layers panel to reveal the basemap).

If you don't save to file directly, remember two things:

* **rename** your clipped layer so it is more descriptive than the generic "Clipped (extent)"
* you are currently using a temporary, **scratch layer**. It will be discarded if you exit QGIS. It is very useful for temporary intermediate files, but it can be safer to save copies of your intermediate data while you work, just in case! You can right-click on the layer and use `Export > Save As..`

## Change the symbology

We can style our DEM with a **terrain colour palette**:

* double-click on the clipped DEM layer
* go to the "Symbology" tab
* change the Render type to "Singleband pseudocolor"
* by default, it uses the min/max values, which is what we want
* we can change the "Color ramp" to something more suitable with the drop-down menu and `Create new color ramp... > Catalog: cpt-city > Topography > Elevation`, for example.

## Add a hillshade

Adding a **hillshade** makes your visualisation of elevation more readable and visually pleasing by giving an artificial lighting look to your map.

*  Right-click on the DEM layer and "Duplicate layer"
*  Rename the duplicated layer "hillshade"
*  Open the Symbology menu for the hillshade layer
*  Change the "Render type" to "Hillshade"
*  The defaults should work well, but you can play with the settings, like the Altitude and the Azimuth
*  Make sure you apply some transparency to the pseudocolour DEM, and place the hillshade layer underneath (in `Properties > Symbology > Transparency`)

> Another methods is to use the hillshade tool instead of the symbology: `Raster > Analysis > Hillshade...`.

## Create a watershed layer

Using the Strahler tool, we can create a **watershed** raster that shows where water would flow according to the DEM.

Open the Processing Toolbox (cog icon) and try using the SAGA tool called "**Strahler order**" using the clipped DEM as an input(a temporary file is fine for now).

Look at the result. It seems there is an issue with our data. A common problem with DEMs is that they have sinks and spikes that will make further analyses more difficult.

We can use the "Fill sinks (Wang & Liu)" tool to **fill the sinks** in our clipped DEM.

* When we do that, we might have to play with the "Minimum slope" value, to make sure that all streams feed into a bigger stream. Try 5 degrees, for example.
* As an output, we only need to tick the "Filled DEM" (first one in the list), which we can also save to file. You can however keep the "Watershed Basins" output to check that your minimum slope is high enough.

If we **re-run the Strahler order tool** on the filled DEM, we will be able to see more useful data.

We can now colour the layer with "Singleband pseudocolor" to highlight the bigger streams.

> To filter out the noise of the smaller streams and **highlight the major streams** in the network, we can use the `Raster > Raster Calculator` tool and use a formula like: `"name_of_layer@1" >= 6` (the value will depend on how many levels exist in the Strahler layer). We need to save to file to be able to do that (name it "strahler_filtered", for example). This will assign the value 1 to the cells matching the condition, and 0 to what is under the limit.

## Channel network and drainage basin

Another analysis we can do is use the "Channel network and drainage basins" tool to calculate the **flow direction, channels and drainage basins**.

* Make sure you run this tool on the filled DEM.
* We might have to change the threshold to a higher one if the output includes too many small basins and channels.

As an output, we only want to load (and save to file):

* Flow Direction (raster)
* Channels (shapefile)
* Drainage basins (shapefile) (to differentiate the two "Drainage basins" options, you can check what format it saves the file as)

This is an example of **creating vector data from raster data**!

We can now play with the symbology for those elements. For example, try using different colours for each basin, by classifying by ID.

## 3D maps

A 3D viewer are integrated in QGIS: `View > New 3D Map View`

In the 3D map window, make sure to first:

* Click on the settings icon and set the "Type" to "DEM (Raster layer)", and set the "Elevation" to your clipped DEM.
* Exaggerate the relief with the "Vertical scale" setting (try 3).

To see the 3D effect, you will have to use your <kbd>Ctrl</kbd> on your keyboard to change the angle of view.

> A useful plugin for 3D maps is qgis2threeJS, which might be handy to add a 3D map to a website.

## Saving your project

Notice the little icon next to some of your layers? We previously created "temporary scratch layers". This is useful if you keep processing data and creating new layers that you want to discard afterwards. In our case, we do want to keep the "cities" and "rivers" layers, so we need to save them to a file. If we try to close QGIS with scratch layers loaded, it will give you a warning that they will be lost in the process.

You can click on the scratch layer icon to save the file. In the dialog, we can give the layers a `File name` (in our project's home directory) and click OK.

You can save your project with the floppy disk icon, or using <kbd>Ctrl</kbd> + <kbd>S</kbd>, and the project should be visible in a list as soon as you open QGIS again.
