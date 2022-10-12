# QGIS: Vector Analysis

## Setting up

This tutorial is designed for **QGIS 3.22**. If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a **new project** with `Project > New`.
Let's start by saving our project: `Project > Save`. We should create a new folder, let's call it "qgis_vector". This where our project and all the saved data will live. Folder structure is very important for keeping you data tidy, but also for ease of sharing your project with others. You simply need to zip the project folder if you need to share it. We can save our .qgz project file here, named "qgis_vector_map" for example.
I also recommend creating a Data folder, for all of your downloaded data. And creating a Products folder, for all the things we create today. Your .qgz file should always be in the highest level folder, so it's only looking down into folders for data, not back out.

In QGIS 3.10 and above this will automatically set the **project home** too. To do this manually, you can go to `Project > Properties > General` and set `Project home` to the same folder. This is where we can also give the project a title.

Let's also add an OpenStreetMap basemap to locate ourselves on the globe: `Browser panel > XYZ Tiles > OpenStreetMap` (double-click, or drag and drop into the Layers panel).


## What is Vector Data?

Vector data is made up of points, lines, and/or polygons.

https://mapschool.io/

## What are we doing today?
To look at vector data, we're going to use the example of koala populations and protected areas, and use some analyses to see how they interact.

## Gather some data

We're going to explore a number of different online spatial data repositories.
Please [download the full dataset here](https://cloudstor.aarnet.edu.au/plus/s/2NXIXjqgSxKvD7k), and extract it into the qgis_vector folder you created earlier.

I will quickly show you where all of this data came from.

### Online Community Spatial Repositories
#### Koala Sighting Data (encounters)

We're getting our species observation data today from the [Atlas of Living Australia](https://www.ala.org.au/).
This is an Australia Biodiversity occurence database. It pulls data from a variety of different sources, including government data, individual collectors and community groups. This means that this data will contain sampling bias and will often simply represent encounters, rather than using robust sampling and collection methods.
So, while we need to use this data with caution, it's still a useful dataset!
 
  
You need to create an account and request the exact dataset you need, so to speed things up today, we've provided the data already cleaned and processed the data in the download link above.
  
#### Cleaning and processing the ALA data
What do we mean by processed? 
Well, the ALA dataset has 206 columns by default. This means that each occurence has 206 associated cells, and when multiplied by ~200,000 sightings, our data gets huge.
To save time (and storage space!) today we have already deleted 200 of those columns.

Some similar online repositories include the Global Biodiversity Information Facility (GBIF) and iNaturalist

### Federal Environment Data
#### Protected Areas

The Federal Environment Department has a variety of [spatial different datasets that you can browse through](http://www.environment.gov.au/fed/catalog/main/home.page). Today we are going to be using the Collaborative Australian Protected Areas Database (CAPAD) 2020, which is a compilation of government, Indigenous and privately protected areas for Australia.
http://www.environment.gov.au/fed/catalog/search/resource/details.page?uuid=%7B4448CACD-9DA8-43D1-A48F-48149FD5FCFD%7D
  
### QLD Government Spatial Data
  We've seen the [QSpatial data portal ](https://qldspatial.information.qld.gov.au/catalogue/custom/index.page)in previous sessions, and today we will be getting two lots of data from here.
  
#### Koala Priority Areas
  Koala Priority Areas are areas in SEQ which have been identified as key areas for conservation as part of the South East Queensland Koala Conservation Strategy 2019-2024.
  https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid={E4CCDBA7-11AB-45DD-A064-BDBC02899204}

### Australian Bureau of Statistics Data
  The ABS is a huge source of data, however, it can be a bit difficult to find that data, and use it in a spatial context.
  
#### Digital Boundary Files - SA2 - Suburb data
  The ABS has a variety of ways that it splits its data up. These digital boundaries are very useful for classifying data. They generally classify all of Australia into discrete Statistical Areas. Level 1 are the smallest, and Level 4 are the coarsest. (notably, the site below also has non-ABS Structures/boundary files such as Electoral areas and Postcodes).
  Today we are going to use the Stastical Area 2 data, which effectively represent suburbs.
  https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files

  #### Population Data
The ABS have a lot of data, today we will be using population data. Thye proivde it in excel format, as shapefiles (by SA2 and LGAs), and as population grid raster files.
  Today we will be using the ESRI Grid format.
https://www.abs.gov.au/statistics/people/population/regional-population/latest-release#data-download

## Set the Project Projection
We need to choose the projection for our current session of QGIS. Today we will be focusing on South East Queensland (SEQ), so we will choose GDA2020 / MGA zone 56.
We will go into projections in more detail soon.

* Go to `Project > Properties` select the **CRS** tab.
* In the filter section, type "GDA2020 56"
* From the **Coordinate Reference System** list, select `GDA2020 / MGA zone 56`


## Load in our data
For most of our data, we will simply be able to double click on it in the Project Home folder within the Browser window.
  Load in:
* SA2_ERP_2021 (suburb data)
* CAPAD2020 (Protected Areas)
* koala_priority_area
* Population Data GRID File (as a stretch goal)

But what about the Koala Encounters location data? We need to handle this differently, as it is currently not in a spatial format, but in a csv file.

### Importing CSV data
* Go to `Layer > Add Layer > Add Delimited Text Layer...`
* Click the three dots `...` next to the **File name** field, navigate to the project folder, and select `koala_reduced`
* This should automatically identify decimalLongitude and the X field, and decimalLatitude as the Y field.
* Click `Add`
  
## Projections
### What are projections?
To turn the geoid/spheroid shape the of Earth into a flat map, we need to squish, stretch, and distort the map to make it flat. The mathematical equations used to do this are what we're talking about when we day projections. Imagine it like a soccer ball, we have to squash it to make it flat, and it's not going to look nice and square like our maps do. So we pull and stretch it to make it flat.
There will always be some kind of distrortion, such as the Mercator Projection making Greenland look large, and Africa look smaller than it really is.

### Why are they important to us?
Well, when we make these distortions, we have to compromise somewhere, and that means our lengths, or size or direction will be different to what it really is. To avoid this kind of distortion, often local projections are used. There are fewer compromises needed when focused on a small area. By using a local projection, we don't need to worry about keeping Greenland looking the right shape if we're focused on Brisbane.
Going back to Soccer balls, if we cut out a single panel from the ball, it will be much easier to make that flat.

The trouble with using data of different projections is that they might be slightly off around the edges, giving us different total areas in a polygon, or showing a point outside a boundary, when it's really inside.
To avoid this, it's often best to convert all of your data to using the same projection.

Today we're going to use a suitable local projection: EPSG:7856 - GDA2020 / MGA zone 56 

### Reproject
For each of our layers, do the following:
* Go to `Vector > Data Management Tools > Reproject Layer...`
* Choose the layer in `Input layer`
* Set the Target CRS to `EPSG:7856 - GDA2020 / MGA zone 56`
* Click the three dots `...` next to the `Reprojected` section, and click **Save to File...**
* Navigate to your **vector_data** folder and save the file there. For example, save **SA2_2021_AUST_GDA2020** as **SA2_Reprojected**
* Click `Run`

## Subset our SA2 data down to SEQ - Select features using an expression

The following code will allow you to select the SA2 features that are in SEQ.

* Right click on the reprojected SA2 layer, and select **Open Attribute Table**
* From the Attribute Table that opens, click the Select features using an expression button: ![image](https://user-images.githubusercontent.com/67612228/195261159-b949e22b-7634-4326-ab50-089b94e76dc4.png)
* In the Select by Expression window that opens, paste the code from below into the Expression field, and then click `Select Features` in the bottom right of the window.

``` SQL
 "GCC_NAME21"  =  'Greater Brisbane' 
OR
 "SA4_NAME21" =  'Gold Coast' 
 OR
 "SA4_NAME21" =  'Sunshine Coast' 
  OR
 "SA4_NAME21" =  'Toowoomba' 
 ```
 
* Close the Select by Expression window and Attribute Table 
* You should see the SEQ SA2 areas highlighted in yellow.
* To permanently save this selection, right click on the reprojected SA2 layer, and select `Export > Save Selected Features As...`
* Save your file as `SA2_SEQ`
* Make sure the CRS stays as `EPSG:7856 - GDA2020 / MGA zone 56`, then click `OK`



## Analysis: Spatial Overlaps

Let's find out how much of our Koala Priority areas are already under federally recognised protection. To do this we will use the Intersection tool

### Intersection
* Go to `Vector > Geoprocessing Tools > Intersection`
* Under **Input Layer** select **CAPAD2020_terrestrial_QLD** 
* Under **Overlay Layer** select **koala_priority_area**
* Click `Run`

We get an error `Feature (26) from “CAPAD2020_terrestrial_QLD” has invalid geometry.`
This is caused by little issues in the polygon layer. Sometimes when polygons are drawn or exported out from other areas, they will create errors, and sometimes little slither polygons on the edges. We can investigate the source of these errors using the `Check validity` tool, but for today, we're simply going to fix them with the `Fix Geometries` tool from the Processing Toolbox.

### Fix Geometries

* Open the Processing Toolbox by clicking the cog icon from the top menu ![image](https://user-images.githubusercontent.com/67612228/195267106-f54d2655-2762-42ec-acd0-a2c744b059e9.png) (alternatively go to `View > Panels > Processing Toolbox`
* In the **Processing Toolbox** window `Search` for "Fix geometries"
* Double-click on the **Fix geometries** option
* In the **Fix Geometries** window, select `CAPAD2020_terrestrial_QLD` from the **Input layer** options, then click `Run`
* We will need to do this same process now for the 

You can now re-run the **Intersection** tool with the resulting **Fixed Geometries** layer (instead of the **CAPAD2020_terrestrial_QLD** layer)

### Field Calculator
We can use the **Field Calculator** to calculate the area of our polygon.

Select **Intersection** from the **Layers** panel, and the click the **Open Field Calculator** button ![image](https://user-images.githubusercontent.com/67612228/195319687-1538f2a0-d8c8-4084-a632-0e3181fb11dd.png)

In the **Field calculator** window, type the following code into the **Expression** tab:
``` SQL
sum($area)
```
* $area will give us the area of a single polygon - we could use this to create a new field in our Attribute Table based on area if we wanted to
* sum() will add together the area for every polygon in that layer. 
* Below the text box, you will see a field titled **Preview:**, the value following that contains the results of our expression. Copy that number.
* Click `Cancel`

Do the same **Field Calculator** steps for the original koala_priority_area.

You can now use the **Field calculator** to determine the percentage of the Koala Priority area which is currently protected.
1506573200.936991 / 5776218019.211894 = 26%

Only 26%! Let's look into this further. Perhaps our dataset is missing some new conservation areas. 

Let's turn on the OpenStreetMap to see if we can see anything missing here. Let's have a look at the dense collection of koala sightings near Springwood and the Daisy Hill Conservation Park.
We can see that there are some protected bushlands in this area that aren't in our CAPAD2020 dataset. It may be that these aren't strict enough conservation areas, or our dataset may be out of date. Regardless, this gives us a good opportunity to use an important tool in GIS: Digitisation.

## Map Digitisation

You may often need to create your own points, lines, and polygons when digitising satellite data, or simply highlighting a particular area.
Let's use the OpenStreeMap (in Browser, scroll down to XYZ Tiles, and double-click on OpenStreetMap) and digitise the Emu Street Bushland Refuge (you can quickly navigate here by changing your **Scale** to 1:10000 and **Coordinate** to  518271.26,6948896.93)
* Go to `Layer > Create Layer > New GeoPackage Layer...`
* Click the three dots `...` next to the **Database** section
* Navigate to your **vector_data** folder and save the file as **ESBR_polygon**
* From **Geometry type** select `MultiPolygon`
* Make sure the CRS is set to `EPSG:7856 - GDA2020 / MGA zone 56`
* Leave the other fields blank for now and click `OK`

We now have a brand new layer that we can add polygons to.
* Select the new **ESBR_polygon** layer and then click the **Toggle Editing** pencil ![image](https://user-images.githubusercontent.com/67612228/195329987-d435f41e-c111-40b0-8ee5-043cf135692c.png) from the top menu (or go to `Layer > Toggle Edititng`
* On your keyboard, press `Ctrl + .` to start adding a new polygon
* Zoom in to a corner of the area you want to create the polygon, and then `Left click` to start drawing your polygon ()You can use the mouse wheel to zoom in, and also press on the mouse wheel to navigate)
* Continue adding points to your polygon until your return back to the start, `Right click` to stop digitising and create your polygon.
* Leave the fid as `Autogenerate` and click `OK`
* To save what you've done, click the **Save Layer Edits** button next to the **Toggle Editing** button
* To finish editing your layer click the **Toggle Editing** button again


## Analysis: How do koalas and people overlap?
### Count Points in Polygons

Eaerlier we lookied at overlap between polygons, we can also look at points in polygon. Let's use the Count Points in Polygons tool to quickly count the number of points from a particular layer inside a polygon.
We could look at a few things here, we could look at koala sightings in protected areas or in the priority areas, but let's try to get an idea of how people and koala sightings overlap. You would expect there to be more koalas where there are fewer people, but perhaps our data is skewed by population levels.

Let's determine how many koalas are inside of each SA2 suburb.
* Go to `Vector > Analysis Tools > Count Points in Polygons...` 
* In the **Polygons** field select `SA2_SEQ`
* In the **Points ** field select `koala_reduced`
* In the **Count field name** field type in something like `NUM_KOALAS`
* Click the three dots `...` next to the **Count** section, and click **Save to File...**
* Navigate to your **vector_data** folder and save the file as **SA2_SEQ_koalas**
* Click `Run`
You will have a new layer, you can look at the **Attribute Table** for this layer to see the number of koala sightings in each suburb
* Let's double click on that layer and change the **Symbology** to `Graduated`
* Set the **Value** to `NUM_KOALAS`
* Choose a **Color ramp** of your liking
* Click `Classify`
* Then click `OK`

We can go further and use the **Field Calculator** to compare this to the current population in that area, and create a new field
* Click on the **Field Calculator** icon
* Under **Create a new field** set the **Output field name** to `KOALAS_PP` and set the **Output field type** to `Decimal number (real)` (we need to choose this option to ensure that we have decimals in our output)
* In the `Expression` tab enter `"NUM_KOALAS" / "ERP_2021"
* Click `OK
* Try changing the **value** in ***Symbology** to `KOALA_PP` instead.

We can now see how koala populations compare with human populations.



## Stretch goals

### Export a Map

Use the data and summary statistics to export a useful map from this data.

### Heatmaps

Try changing the **Symbology** of the `koala_reduced` point dataset to the **Heatmap** option or even the **Point Cluster** option.

Compare the **Heatmap** from **Symbology** with one that you can create with the `Heatmap (Kernel Density Estimation)` tool from the **Processing Toolbox**

### Use Zonal Statistics to calculate values from Rasters

You can use the `Zonal statistics` tool from the **Processing Toolbox** to count the number of raster squares, sum together all of the values, and find the average value from a raster that overlaps with a chosen polygon. 

### Vector to Raster conversion

Convert a species distribution point dataset to a raster image



