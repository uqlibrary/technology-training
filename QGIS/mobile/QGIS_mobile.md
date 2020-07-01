# QGIS: Mobile Mapping

## Setting up

This tutorial is designed for **QGIS 3.10**. If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a **new project** with `Project > New`.
Let's straight away **save** our project: `Project > Save`. We should create a new folder, where our project and all the saved data will live, named "qgis_raster_intro" for example.

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

**DEM**

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
* You should receive an email within 5 minutes, download the files from the link in the email, and extract the folder to your project folder.

**Aerial Imagery**

There are a few places you can aquire aerial photography, today we will look at two sources, on is freely available Government Data from **QImagery**, the other is accessible from NearMap using your UQ credentials.

* Go to https://qimagery.information.qld.gov.au/
* Click the Search button, and search for "St Lucia" in the "Enter search term" search box and select the first result
* It will zoom to your selected location then click the newly appeared "Search" button
* From here you can select from a wide array of images of QLD over many years.
* Click one of the drop-downs and hover over the options to see where those images are location. Preview the image by clicking View.
* You can then download your desired images by clicking "Download" and selecting TIFF (georeferenced)
* Move the TIFF file(s) to your project folder

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
* Move the downloaded zip file to your project folder

**Lot Plans and Remnant Vegetation**


You can access a wide variety of QLD Government Data, including Spatial Data such as lot plans and vegetation maps, from QLD Spatial http://qldspatial.information.qld.gov.au/
I will show you how to download the files, but the data is often quite large in size, so I have downloaded it beforehand, and trimmed the raw data down for you to download from cloudstor.

* Go to 

## Create a buffer to clip our data

Go to `Vector > Geoprocessing Tools > Buffer`
* Choose "UQ_Boundaries" as the Input Layer.
* There are many settings we can change to edit the shape of the buffer, but let's leave most of these as the defaults for now.
* We can choose the distance that we want to create a buffer away from our vector. You'll note that the distance is currently in degrees, as the layer projection is EPSG:4283 GDA94, a geographic coordinate system. This might cause issues.
* If you click Run. Your buffer won't look very good. We need to convert our layer to a local projected coordinate system.

Go to `Vector > Data Management Tools > Reproject Layer`
* Choose "UQ_Boundaries" as the Input Layer.
* We want to choose a local projected coordinate system such as GDA94 / MGA zone 56 or GDA2020 / MGA zone 56. This will convert our measurements to metres instead of degrees, and by choosing an Australian projection, it reduces distortion.
* Click "Run"
* The new scratch layer will look the same, but it now has a different projection. Let's create that buffer again.

Go to `Vector > Geoprocessing Tools > Buffer`
* This time choose "Reprojected" as the Input Layer.
* You'll notice the distance is now in metres. For this instance, I want a larger buffer of 50m.
* If you click Run. Your buffer 




## Government Data Symbology



## Create a buffer

access government spatial data
utilise aerial photography
clip your data to a region of interest
combine different data sets
use your map offline on your phone

## Clip the DEM and Aerial Photography and other layers

## Add Hillshade

## Create Contours

## Exporting to Anveza Maps

## Exporting to QField


