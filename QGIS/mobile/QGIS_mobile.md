# QGIS: Mobile Mapping

## Setting up

This tutorial is designed for **QGIS 3.10**. If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a **new project** with `Project > New`.
Let's straight away **save** our project: `Project > Save`. We should create a new folder, where our project and all the saved data will live, named "qgis_mobile_map" for example.

Let's set the **project home** too: `Project > Properties > General` and set `Project home` to the same folder. This is where we can also give the project a title.

Let's also add an OpenStreetMap basemap to locate ourselves on the globe: `Browser panel > XYZ Tiles > OpenStreetMap` (double-click, or drag and drop into the Layers panel).

## Install Avenza Maps on your phone

Avenza Maps is a mobile based offline mapping app you can use on your smartphone. 

For Android Devices: https://play.google.com/store/apps/details?id=com.Avenza&hl=en_AU

For Apple Devices: https://apps.apple.com/au/app/avenza-maps/id388424049

There are alternatives to Avenza Maps out there, such as [QField](https://qfield.org/), which is specifically created for use with QGIS on your mobile.
However, we will be using Avenza today for its simplicity. 

## Get some data

We're going to explore a number of different online spatial data repositories.

### DEM

A Digital Elevation Model (DEM) is a common example of **raster data**, i.e. grid data that contains a value in each cell (a bit like the pixels in a coloured picture).

For this tutorial, we are using a DEM sourced from **ELVIS** - Geoscience Australia's ELeVation Information System.

* Go to http://www.ga.gov.au/elvis/
* Search for "St Lucia" in the "Enter a Location" search box and select the first result
* Click the first icon next to "Select area by:" to use the bounding box tool
* Click and drag on the map to draw a rectangle around your desired area
* The right panel will show you all the different datasets available in that area
* We want the QLD Government 1 Metre DEM, click "show list"
* As you hover over the different options, they will highlight a red box on the map, select all that overlap the area you're interested in
* When you have the data you want, click Download Selected Datasets
* Enter your industry, email, tick the reCAPTCHA, and click "Start extract of datasets"
* You should receive an email within 5 minutes, download the files from the link in the email, extract the folder to your project folder, and add them to your map.

### Aerial Imagery

There are a few places you can aquire aerial photography, today we will look at two sources, on is freely available Government Data from **QImagery**, the other is accessible from NearMap using your UQ credentials.

* Go to https://qimagery.information.qld.gov.au/
* Click the Search button, and search for "St Lucia" in the "Enter search term" search box and select the first result
* It will zoom to your selected location then click the newly appeared "Search" button
* From here you can select from a wide array of images of QLD over many years.
* Click one of the drop-downs and hover over the options to see where those images are location. Preview the image by clicking View.
* You can then download your desired images by clicking "Download" and selecting TIFF (georeferenced)
* Move the TIFF file(s) to your project folder, and open them in QGIS

If you want even higher resolution maps, there restricted options available. Your particular study area may have maps available such as the Sunshine Coast MyMaps service, or CSIRO's Norfolk Island Data Portal.
As a UQ student, you also have access to very high resoltuion imagery from **NearMap**. You can even access an array of imagery going back in time.

* Go to the [UQ NearMap Portal](https://admin.nearmap.com/invitation/domain-signup?token=q9WIbXMtna1iskb2meNGhKpCaQp3WTRbMhXpQVGWkKouKUeqzkpjNznC_Ogz5iKYiw0Ev7vym2Ykaj_W_V4dBbTzR6qUX2eTDsNHpBuR4XbU9vDRxQN_Rg==)
* Enter your UQ Student (@student.uq.edu.au) or Staff (@uq.edu.au) email address, with the appropriate domain selected. Click "Invite me".
* You should receive an email soon after, click the "Accept Invitation" button, and go through the account setup process.
* Go to Login and enter your email address, click "Next" and enter your password.
* From the welcome screen select "MapBrowser".
* Type "St Lucia, QLD" in the search box, and click "Go".
* You can click the nodes up the top to look at different snapshots in time.
* To save imagery from NearMap, simply click the "SavePhotoMaps" button on the left handside (it is a camera icon)
* From the popup that appears select "Define Area" (you must choose this for the image to be georeferenced)
* From "Projection" choose GDA2020 / MGA zone 56
* You can increase and decrease the size of the bounding box by adjusting its corners, a smalle rbox means you can have a finer resolution, down to 0.075m. If we select all of St Lucia in one go, the highest resolution we can have is 0.597m.
* Tick the "Include georeference file" box
* Click "Save"
* Move the downloaded zip file to your project folder, and open them in QGIS

### Lot Plans

You can access a wide variety of QLD Government Data, including Spatial Data such as lot plans and vegetation maps, from QLD Spatial 
I will show you how to download the files, but the data is often quite large in size, so I have downloaded it beforehand, and trimmed the raw data down for you to download from cloudstor.

* To access data from QLD Spatial go to https://qldspatial.information.qld.gov.au/
* Search for "property boundaries and select the "property boundaries Queensland" option.
* You could download this file, however, as it is the property boundaries for all of QLD, so you can find the trimmed file for our workshop here: https://cloudstor.aarnet.edu.au/plus/s/Mg7M6xYbtNYw3dd
* Move the downloaded zip file to your project folder, and open the shapefile in QGIS

### Queensland Globe

* To access data from Queensland Globe go to https://qldglobe.information.qld.gov.au
* Accept the T&Cs.
* Click **Search**, Select **Locality**, and search for the location you want an select it from the list.
* Click **Layers**, click **Add Layers** here you can scroll through and filter different layer types
* We want to tick the box next to `Planning Cadastre > Land Parcels > Land Parcel` (you may need to zoom in to see certain layers)
* To export data click the Wrench Icon in the top right, and then click the Identify Marker icon
* Use the triangular Identify Polygon tool to select and area of interest. Double click when you've finished selecting your area.
* The Layers menu will now show your selection. You can download all, or sections, of your selection.
* I will choose **Land Parcel** and then **Download** as a **shp** file.


## Create a buffer to clip our data

We now want to only keep data that is relevant to the St Lucia campus. To achieve that, we need a mask to clip data.

We first need to select the lots that are relevant by using the "Select Feature by area or single click" (in the toolbar), clicking on the lots one by one (or drawing a rectangle around them) with the Shift key pressed.

We can now create a buffer:

* Go to `Vector > Geoprocessing Tools > Buffer`
* Choose "Brisbane_lot_plans" as the Input Layer, and tick the 
* There are many settings we can change to edit the shape of the buffer, but let's leave most of these as the defaults for now.
* We can choose the distance that we want to create a buffer away from our vector. You'll note that the distance is currently in degrees, as the layer projection is EPSG:4283 GDA94, a geographic coordinate system. This might cause issues.
* If you click Run. Your buffer won't look very good. We need to convert our layer to a local projected coordinate system.

Let's reproject the layer for better results:

* Go to `Vector > Data Management Tools > Reproject Layer`
* Choose "Brisbane_lot_plans" as the Input Layer.
* We want to choose a local projected coordinate system such as GDA94 / MGA zone 56 or GDA2020 / MGA zone 56. This will convert our measurements to metres instead of degrees, and by choosing an Australian projection, it reduces distortion.
* Click "Run"
* The new scratch layer will look the same, but it now has a different projection.

Let's create that buffer again.

* Select the relevant lots
* Go to `Vector > Geoprocessing Tools > Buffer`
* This time choose "Reprojected" as the Input Layer, and tick "Selected features only"
* You'll notice the distance is now in metres. For this instance, I want a larger buffer of 50 m.
* When you click "Run", your buffer should be a good distance away from the original boundary.

Now we can Dissolve those layers together:

* Go to `Vector > Geoprocessing Tools > Dissolve
* Choose "Buffered" as the Input Layer.
* Let's save this one to file, rather than a temporary file. Click "..." next to "[Create Temporary Layer]", then "Save to file", and save it as something like **UQ Boundary** to your project folder.

> **Note** the Buffer tool has a "dissolve" option, but it's important to know that there are many tools available.

## Build a virtual raster

See the visible line between the raster tiles? That is because the separate raster files have different maximum and minimum values, so use different shades for different elevations. We have to **merge** them to make sure they use the same colour scale.

To do that, we use the `Raster > Miscellaneous > Build Virtual Raster...` tool to create one single layer from them.

* First, select all  DEM layers for the "Input layers"
* Make sure you untick the option "Place each input file into a separate band", as we want to end up with one single-band layer
* We can save the output on disk instead of only creating a temporary file (for example, name it `St_Lucia_DEM_merged` and save it inside your project directory)
* Click "Run"

> You will need to have Saga installed for this to work.

We can now remove the original DEM raster files.

## Clip the DEM

We now use `Raster > Extraction > Clip Raster by Mask Layer` to **focus on our area of interest**.

* Make sure the virtual raster output DEM is selected in the Input layer
* Set the Mask Layer to "UQ_Boundary"
* Scroll down to "Clipped (mask)" and click "..." next to [Create Temporary Layer]", then "Save to file", and save it as **St_Lucia_DEM** to your project folder.

If you don't save to file directly, remember two things:

* **rename** your clipped layer so it is more descriptive than the generic "Clipped (extent)"
* you are currently using a temporary, **scratch layer**. It will be discarded if you exit QGIS. It is very useful for temporary intermediate files, but it can be safer to save copies of your intermediate data while you work, just in case! You can right-click on the layer and use `Export > Save As..`

## Clip the Aerial Imagery

We can repeat the same process as above to clip the Aerial Imagery, however due to the nature of the image from NearMaps, we need to first convert it to a GeoTIFF file format before we can clip it:

* `Right Click the image layer > Export > Save as...`
* Ensure the Format is GeoTIFF
* Click '...' next to File name and name your layer "St_Lucia_Aerial"

Now, clip the converted aerial imagery:

* Go to `Raster > Extraction > Clip Raster by Mask Layer`
* Make sure St_Lucia_Aerial is selected in the Input layer
* Set the Mask Layer to "UQ_Boundary"
* Scroll down to "Clipped (mask)" and click "..." next to [Create Temporary Layer]", then "Save to file", and save it as **St_Lucia_Aerial_clipped** to your project folder.

We can now clean up our project by removing the original and intermediate layers we won't need.

## Change the symbology

We can style our DEM with a **terrain colour palette**:

* double-click on the clipped DEM layer
* go to the "Symbology" tab
* change the Render type to "Singleband pseudocolor"
* by default, it uses the min/max values, which is what we want
* we can change the "Color ramp" to something more suitable with the drop-down menu and `Create new color ramp... > Catalog: cpt-city > Topography > Elevation`, for example.

## Add a hillshade

Adding a **hillshade** makes your visualisation of elevation more readable and visually pleasing by giving an artificial lighting look to your map.

* Go to  `Raster > Analysis > Hillshade...`.
* Ensure the Input Layer is your clipped DEM "St_Lucia_DEM"
* Scroll down to "Hillshade" and click "..." next to [Create Temporary Layer]", then "Save to file", and save it as **St_Lucia_DEM_Hillshade** to your project folder.
* Click Run

## Create Contours

Adding a **contour** makes your elevation even more evident and can also be used to quickly show elevation on other layers

* Go to  `Raster > Extraction > Contour...`.
* Ensure the Input Layer is your clipped DEM "St_Lucia_DEM"
* For **Interval between contour lines**, the default is 10 m, which won't be greatly noticeable at UQ where the highest point is 25 m. However, the finer the contour lines, the longer it will take to process. I will choose 5 m.
* Scroll down to "Contours" and click "..." next to [Create Temporary Layer]", then "Save to file", and save it as **St_Lucia_Contours_5m** to your project folder.
* Click Run

## Exporting to Avenza Maps

Click on `Show Layout Manager` in the toolbar. `Create` a new layout called "Avenza". We can now see the Layout window.

Normally we would add many elements to our layout if we were exporting it for print such as the map, a legend, a scale bar, a north arrow...

In this case however, we are simply interested in our map. Let's add the map to the canvas:

* Go to the Layout tab, scroll down to 'Resize Layour to Content', click 'Resize layout'
* Before we export, let's turn off any layers we aren't using in QGIS to save space
* Click the Refresh View button up the top
* Now we are ready to export.
* Go to 'Layout > Export as PDF...' and save your map.
* The 'PDF Export Options' window will open
* Tick the 'Create Geospatial PDF (GeoPDF)' box
* Untick the 'Include vector feature information' box
* Click 'Save'

You can repeat this process with the DEM and Hillshade to export out another kind of map.

Now you simply need to export the file(s) to your phone. You can email it, send it through the cloud, or transfer it using a cable.

When you first open Avenza Maps it will ask you to create an account, but you can import up to three maps without doing so, you can avoid creating an account by selecting the 'x' in the top right corner.
* Allow Avenza Maps to access your device location
* Select the orange '+' in the bottom right and select 'Download or import a map'
* Choose 'From Storage Locations' (if requested, give Avenza Maps the permissions to access your files)
* Do the same for the other map, if you created one.
* Once it has been imported, tap on the map.
* You can now move the map around with your finger, and pinching to zoom.
* Tapping the placemark icon in the bottom left will add a placemark in the middle of the crosshairs.
* Tapping the 3 dots in the bottom right will allow you to add GPS tracking and draw and measure distances.

## Exporting to QField
If we have time I'll talk briefly about QField as well.

