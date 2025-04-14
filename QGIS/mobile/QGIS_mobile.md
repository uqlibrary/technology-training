# QGIS: Mobile Mapping
UQ Library
2025-04-14

## Setting up

This tutorial is designed for **QGIS 3.22**. If you need to install it
on your computer, got to the [QGIS
website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a **new project** with `Project > New`. Let’s
straight away **save** our project: `Project > Save`. We should create a
new folder, let’s call it “qgis_mobile”. This where our project and all
the saved data will live. Folder structure is very important for keeping
you data tidy, but also for ease of sharing your project with others.
You simply need to zip the project folder if you need to share it. We
can save our .qgz project file here, named “qgis_mobile_map” for
example. I also recommend creating a Data folder, for all of your
downloaded data. And creating a Products folder, for all the things we
create today. Your .qgz file should always be in the highest level
folder, so it’s only looking down into folders for data, not back out.

In QGIS 3.10 and above this will automatically set the **project home**
too. To do this manually, you can go to `Project > Properties > General`
and set `Project home` to the same folder. This is where we can also
give the project a title.

Let’s also add an OpenStreetMap basemap to locate ourselves on the
globe: `Browser panel > XYZ Tiles > OpenStreetMap` (double-click, or
drag and drop into the Layers panel).

## Install Avenza Maps on your phone

Avenza Maps is a mobile based offline mapping app you can use on your
smartphone.

For Android Devices:
https://play.google.com/store/apps/details?id=com.Avenza&hl=en_AU

For Apple Devices: https://apps.apple.com/au/app/avenza-maps/id388424049

There are alternatives to Avenza Maps out there, such as
[QField](https://qfield.org/) or [Input
(MerginMaps)](https://merginmaps.com/features) which are specifically
created for use with QGIS on your mobile. However, we will be using
Avenza today for its simplicity.

## Get some data

We’re going to explore a number of different online spatial data
repositories.

### DEM

A Digital Elevation Model (DEM) is a common example of **raster data**,
i.e. grid data that contains a value in each cell (a bit like the pixels
in a coloured picture).

For this tutorial, we are using a DEM sourced from **ELVIS** -
Geoscience Australia’s ELeVation Information System.

- Go to http://www.ga.gov.au/elvis/
- Search for “St Lucia” in the `Location Search` search box and select
  the first result
- Click `Order Data`
- Choose “Draw” and “Box” and then click the `Draw` button
- Click on the map to start drawing a rectangle around your desired area
- Then click `Search`
- The right panel will show you all the different datasets available in
  that area
- We want the QLD Government 1 Metre DEM, click the down arrow on the
  right
- As you hover over the different options, they will highlight a red box
  on the map, select all that overlap the area you’re interested in
  (note that there may be data from different years here)
- When you have the data you want, scroll to the bottom of the Order
  Data window
- Select your industry, enter your email, tick the reCAPTCHA, and click
  the `Order Datasets` button
- You should receive an email within 5 minutes, download the files from
  the link in the email, extract the folder to your project folder, and
  add them to your map.

### Aerial Imagery

There are a few places you can aquire aerial photography, today we will
look at two sources, one is freely available Government Data from
**QImagery**, the other is accessible from using your UQ credentials.

- Go to https://qimagery.information.qld.gov.au/
- Read and tick the “I acknowledge I have read and agree to the Terms &
  Conditions” box, and click `Get Started`
- Click the Search button, select ‘locality, town or city’ and search
  for “St Lucia” in the “Enter search term” search box and select the
  first result
- It will zoom to your selected location then click the newly appeared
  `Search` button
- From here you can select from a wide array of images of QLD over many
  years.
- Click one of the drop-downs and hover over the options to see where
  those images are located. Preview the image by clicking View.
- You can then download your desired images by clicking “Download” and
  selecting TIFF (georeferenced)
- Move the TIFF file(s) to your project folder, and open them in QGIS

If you want even higher resolution maps, there are restricted options
available. Your particular study area may have maps available such as
the [Sunshine Coast
MyMaps](https://scrc.maps.arcgis.com/apps/webappviewer/index.html?id=48501cb9e7294555be5b08e35e949616)
service, CSIRO’s [Norfolk Island Data
Portal](https://data.csiro.au/collection/csiro:43016) or other [CSIRO
spatial
products](https://data.csiro.au/collections/search/SQDEM/STsearch-by-keyword/).
It’s worth exploring to discover what various local council and
government resources are available. As a UQ student, you also have
access to very high resoltuion imagery from **NearMap**. You can even
access an array of imagery going back in time.

- Go to the [UQ NearMap
  Portal](https://admin.nearmap.com/invitation/domain-signup?token=q9WIbXMtna1iskb2meNGhKpCaQp3WTRbMhXpQVGWkKouKUeqzkpjNznC_Ogz5iKYiw0Ev7vym2Ykaj_W_V4dBbTzR6qUX2eTDsNHpBuR4XbU9vDRxQN_Rg==)
- Enter your UQ Student (@student.uq.edu.au) or Staff (@uq.edu.au) email
  address, with the appropriate domain selected. Click “Invite me”.
- You should receive an email soon after, click the “Accept Invitation”
  button, and go through the account setup process.
- Go to Login and enter your email address, click “Next” and enter your
  password.
- From the top right select `MapBrowser`.
- Type “St Lucia, QLD” in the search box, press enter
- You can click the date down the bottom to look at different snapshots
  in time, and even compare maps side-by-side.
- To save imagery from NearMap, simply click the “Exports” button on the
  left handside (it is an image icon)
- From the menu that appears change the “Export type” to “Georeferenced
  image”
- From “Projection” choose GDA2020 / MGA zone 56
- You can increase and decrease the size of the bounding box by
  adjusting its corners, a smaller box means you can have a finer
  resolution, down to 0.075m. If we select all of UQ St Lucia in one go,
  the highest resolution we can have is 0.299m.
- Once you’re happy with your selection click `Download Files`
- Move the downloaded zip file to your project folder, and open them in
  QGIS

### Lot Plans

You can access a wide variety of QLD Government Data, including Spatial
Data such as lot plans and vegetation maps, from QLD Spatial. I will
show you how to download the files, but the data is often quite large in
size, so I have downloaded it beforehand, and trimmed the raw data down
for you to download from our Github site.

- To access data from QLD Spatial go to
  https://qldspatial.information.qld.gov.au/
- Search for “property boundaries” and select the “property boundaries
  Queensland” option.
- You could download this file, however, as it is the property
  boundaries for all of QLD, so you can find the trimmed file for our
  workshop
  [here](https://github.com/uqlibrary/technology-training/blob/8e0aebe078198cd8bb65630c9ac4c4c8558a4392/QGIS/mobile/QGIS_Mobile_Data.zip),
  just press the three dots and download.
- Move the downloaded zip file to your project folder, and open the
  shapefile in QGIS

### Queensland Globe

Another way to access QSpatial Data is using the Queensland Globe
portal.

- To access data from Queensland Globe go to
  https://qldglobe.information.qld.gov.au
- Accept the T&Cs.
- Click **Search**, Select **Locality (Suburb) within a Local Government
  Area**, and search for the location you want and select it from the
  list.
- Click **Layers**, click **Add Layers +** here you can scroll through
  and filter different layer types
- We want to tick the box next to
  `Planning Cadastre > Land Parcels > Land Parcel` (you may need to zoom
  in to see certain layers)
- To export data click the Wrench Icon in the top right, and then click
  the Identify icon (i)
- Use the triangular Identify Polygon tool to select and area of
  interest. Double click when you’ve finished selecting your area.
- The Layers menu will now show your selection. You can download all, or
  sections, of your selection.
- I will choose **Land Parcel** and then **Download** as a **shp** file.
- Note: You may need to disable other layers for this to work correctly.
  I needed to turn off the **Transportation** layer to prevent roads
  from being included in my selection.

## Import our data

If you have saved your data into your **Data** folder within your
project folder **qgis_mobile**, it should appear in Project Home. You
can import it into your project’s layers by double-clicking on the data
there.

## Create a buffer to clip our data

We now want to only keep data that is relevant to the St Lucia campus.
To achieve that, we need a mask to clip data.

We first need to select the lots that are relevant by using the “Select
Feature by area or single click” (in the toolbar), clicking on the lots
one by one (or drawing a rectangle around them) with the Shift key
pressed.

We can now create a buffer:

- Go to `Vector > Geoprocessing Tools > Buffer`
- Choose “Brisbane_lot_plans” as the Input Layer, and tick the
  **Selected features only** box
- There are many settings we can change to edit the shape of the buffer,
  but let’s leave most of these as the defaults for now.
- We can choose the distance that we want to create a buffer away from
  our vector. You’ll note that the distance is currently in degrees, as
  the layer projection is EPSG:4283 GDA94, a geographic coordinate
  system. This might cause issues.
- If you click Run. Your buffer won’t look very good. We need to convert
  our layer to a local projected coordinate system.

Let’s reproject the layer for better results:

- Go to `Vector > Data Management Tools > Reproject Layer`
- Choose “Brisbane_lot_plans” as the Input Layer, and tick the
  **Selected features only** box
- We want to choose a local projected coordinate system such as GDA94 /
  MGA zone 56 or GDA2020 / MGA zone 56. This will convert our
  measurements to metres instead of degrees, and by choosing an
  Australian projection, it reduces distortion.
- Click “Run”
- The new scratch layer will look the same, but it now has a different
  projection.

Let’s create that buffer again.

- Select the relevant lots
- Go to `Vector > Geoprocessing Tools > Buffer`
- This time choose “Reprojected” as the Input Layer
- You’ll notice the distance is now in metres. For this instance, I want
  a larger buffer of 50 m.
- When you click “Run”, your buffer should be a good distance away from
  the original boundary.

Now we can Dissolve those polygons together:

- Go to \`Vector \> Geoprocessing Tools \> Dissolve
- Choose “Buffered” as the Input Layer.
- Let’s save this one to file, rather than a temporary file. Click “…”
  next to “\[Create Temporary Layer\]”, then “Save to file”, and save it
  as something like **UQ Boundary** to your project folder.

> **Note** the Buffer tool has a “dissolve” option, but it’s important
> to know that there are many tools available.

## Combine our DEMs

See the visible line between the raster tiles? That is because the
separate raster files have different maximum and minimum values, so use
different shades for different elevations. We have to **merge** them to
make sure they use the same colour scale.

To do that, we use the `Raster > Miscellaneous > Merge...` tool to
create one single layer from them.

- First, select all DEM layers for the “Input layers”
- Make sure the option “Place each input file into a separate band” is
  **unchecked**, as we want to end up with one single-band layer
- We can save the output on disk instead of only creating a temporary
  file (for example, name it `St_Lucia_DEM_merged` and save it inside
  your project directory)
- Click “Run”

> You will need to have Saga installed for this to work.

We can now remove the original DEM raster files.

## Clip the DEM

We now use `Raster > Extraction > Clip Raster by Mask Layer` to **focus
on our area of interest**.

- Make sure the virtual raster output DEM is selected in the Input layer

- Set the Mask Layer to “UQ_Boundary”

- Scroll down to “Clipped (mask)” and click “…” next to \[Create
  Temporary Layer\]“, then”Save to file”, and save it as
  **St_Lucia_DEM** to your project folder.

- Another way to clip would be to use Extent

- Make sure the virtual raster output DEM is selected in the Input layer

- Navigate to `Raster > Extraction > Clip Raster by Extent`

- Next to “Clipping extent” click
  `... > Calculate from Layer > UQ_Boundary`

- Scroll down to “Clipped (extent)” and click “…” next to \[Create
  Temporary Layer\]“, then”Save to file”, and save it as
  **St_Lucia_DEM** to your project folder.

If you don’t save to file directly, remember two things:

- **rename** your clipped layer so it is more descriptive than the
  generic “Clipped (extent)”
- you are currently using a temporary, **scratch layer**. It will be
  discarded if you exit QGIS. It is very useful for temporary
  intermediate files, but it can be safer to save copies of your
  intermediate data while you work, just in case! You can right-click on
  the layer and use `Export > Save As..`

## Save your project

It’s not essential at this stage, it’s just a good reminder to save your
work regularly so you don’t lose things when things go wrong.

## Clip the Aerial Imagery

We can repeat the same process as above to clip the Aerial Imagery.

Now, clip the converted aerial imagery:

- Go to `Raster > Extraction > Clip Raster by Extent`
- Make sure St_Lucia_Aerial is selected in the Input layer
- Set the Mask Layer to “UQ_Boundary”
- You may need to define the Source and Target CRS to ensure that it all
  runs smoothly
- Scroll down to “Clipped (mask)” and click “…” next to \[Create
  Temporary Layer\]“, then”Save to file”, and save it as
  **St_Lucia_Aerial_clipped** to your project folder.

We can now clean up our project by removing the original and
intermediate layers we won’t need.

## Change the symbology

We can style our DEM with a **terrain colour palette**:

- double-click on the clipped DEM layer
- go to the “Symbology” tab
- change the Render type to “Singleband pseudocolor”
- by default, it uses the min/max values, which is what we want
- we can change the “Color ramp” to something more suitable with the
  drop-down menu and
  `Create new color ramp... > Catalog: cpt-city > Topography > Elevation`,
  for example.

## Add a hillshade

Adding a **hillshade** makes your visualisation of elevation more
readable and visually pleasing by giving an artificial lighting look to
your map.

- Go to `Raster > Analysis > Hillshade...`.
- Ensure the Input Layer is your clipped DEM “St_Lucia_DEM”
- Scroll down to “Hillshade” and click “…” next to \[Create Temporary
  Layer\]“, then”Save to file”, and save it as
  **St_Lucia_DEM_Hillshade** to your project folder.
- Click Run

## Create Contours

Adding a **contour** makes your elevation even more evident and can also
be used to quickly show elevation on other layers

- Go to `Raster > Extraction > Contour...`.
- Ensure the Input Layer is your clipped DEM “St_Lucia_DEM”
- For **Interval between contour lines**, the default is 10 m, which
  won’t be greatly noticeable at UQ where the highest point is 25 m.
  However, the finer the contour lines, the longer it will take to
  process. I will choose 5 m.
- Scroll down to “Contours” and click “…” next to \[Create Temporary
  Layer\]“, then”Save to file”, and save it as **St_Lucia_Contours_5m**
  to your project folder.
- Click Run

## Exporting to Avenza Maps

Click on `Show Layout Manager` in the toolbar or use
`Project > Layout Manager`. `Create` a new layout called “Avenza”. We
can now see the Layout window.

Normally we would add many elements to our layout if we were exporting
it for print such as the map, a legend, a scale bar, a north arrow…

In this case however, we are simply interested in our map. Let’s add the
map to the canvas:

- Go to the Layout tab, scroll down to ‘Resize Layout to Content’, click
  ‘Resize layout’
- Before we export, let’s turn off any layers we aren’t using in QGIS to
  save space
- Click the Refresh View button up the top
- Now we are ready to export.
- Go to ‘Layout \> Export as PDF…’ and save your map.
- The ‘PDF Export Options’ window will open
- Tick the ‘Create Geospatial PDF (GeoPDF)’ box
- Click ‘Save’

You can repeat this process with the DEM and Hillshade to export out
another kind of map.

Now you simply need to export the pdf file(s) to your phone. You can
email it, send it through the cloud, or transfer it using a cable.

When you first open Avenza Maps it will ask you to create an account,
but you can import up to three maps without doing so, you can avoid
creating an account by selecting the ‘x’ in the top right corner. \*
Allow Avenza Maps to access your device location \* Select the orange
‘+’ in the bottom right and select ‘Download or import a map’ \* Choose
‘From Storage Locations’ (if requested, give Avenza Maps the permissions
to access your files) \* Do the same for the other map, if you created
one. \* Once it has been imported, tap on the map. \* You can now move
the map around with your finger, and pinching to zoom. \* Tapping the
placemark icon in the bottom left will add a placemark in the middle of
the crosshairs. \* Tapping the 3 dots in the bottom right will allow you
to add GPS tracking and draw and measure distances.

## QField

QField is another Android based GIS app.
