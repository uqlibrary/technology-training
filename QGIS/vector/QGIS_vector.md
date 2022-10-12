# QGIS: Vector Analysis DRAFT

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


## Load in our data
For most of our data, we will simply be able to double click on it in the Project Home folder within the Browser window.
  Load in:
* SA2/Suburb data
* Population Data GRID File
* Protected Areas
* Koala Priority Areas

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
* Navigate to your **vector_data** folder and save the file ther. For example, save **SA2_2021_AUST_GDA2020** as **SA2_Reprojected**
* Click `Run`

## Subset our SA2 data down to SEQ - Select features using an expression

The following code will allow you to select the SA2 features that are in SEQ.

* Right click on the reprojected SA2 layer, and select **Open Attribute Table**
* From the Attribute Table that opens, click the Select features using an expression button: ![image](https://user-images.githubusercontent.com/67612228/195261159-b949e22b-7634-4326-ab50-089b94e76dc4.png)
* In the Select by Expression window that opens, paste the code from below into the Expression field, and then click `Select Features` in the bottom right of the window.
* Close the Select by Expression window and Attribute Table 
* You should see the SEQ SA2 areas highlighted in yellow.
* To permanently save this selection, right click on the reprojected SA2 layer, and select `Export > Save Selected Features As...`
* Save your file as `SA2_SEQ`
* Make sure the CRS stays as `EPSG:7856 - GDA2020 / MGA zone 56`, then click `OK`


``` SQL
 "GCC_NAME21"  =  'Greater Brisbane' 
OR
 "SA4_NAME21" =  'Gold Coast' 
 OR
 "SA4_NAME21" =  'Sunshine Coast' 
  OR
 "SA4_NAME21" =  'Toowoomba' 
 ```

## Analysis
### Spatial Overlaps


## Inspect our Data
### Layer Properties

## Prepare Data for Analysis
### Projections
We need to ensure that all of our data is in the same projection. This is an important step, but is especially important given the analyses we will be performing today will include determining spatial overlaps.

### Digitizing Map Data
We will use the satellite imagery to create our own polygons for analysis.
Let's create some polygons around the forested area of interest.

### Edit a layer
Remove one of the polygons that we created.

Edit a feature name of a polygon

INSTRUCTIONS ON HOW TO USE THE DIGITISATION TOOLS

### Raster to Vector Conversion

## Analysis
### Spatial Overlaps

How do protected areas overlap with areas of environmental significance?
Use Intersect
Calculate area in the attribute table

Create other summary stats

Species counts within areas

Population counts within areas

How population and species interact

## Heatmaps (vector to raster)


## Map Creation
We will create a species and population distribution map with summary stats attached.



## Stretch analyses

### Heatmaps

Heat maps of species distribution

### Nearest Neighbour

Perform nearest neighbour calculations to determine how close things are

### Vector to Raster conversion

Convert a species distribution point dataset to a raster image



