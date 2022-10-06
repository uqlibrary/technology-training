# QGIS: Vector Analysis DRAFT

## Setting up

This tutorial is designed for **QGIS 3.22**. If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a **new project** with `Project > New`.
Let's start by saving our project: `Project > Save`. We should create a new folder, let's call it "qgis_vector". This where our project and all the saved data will live. Folder structure is very important for keeping you data tidy, but also for ease of sharing your project with others. You simply need to zip the project folder if you need to share it. We can save our .qgz project file here, named "qgis_mobile_map" for example.
I also recommend creating a Data folder, for all of your downloaded data. And creating a Products folder, for all the things we create today. Your .qgz file should always be in the highest level folder, so it's only looking down into folders for data, not back out.

In QGIS 3.10 and above this will automatically set the **project home** too. To do this manually, you can go to `Project > Properties > General` and set `Project home` to the same folder. This is where we can also give the project a title.

Let's also add an OpenStreetMap basemap to locate ourselves on the globe: `Browser panel > XYZ Tiles > OpenStreetMap` (double-click, or drag and drop into the Layers panel).


More notes

Hammer home that the dataset is encounters

Koala counts 
Area calculation

Zonal Statistics
Count points in polygon
Field calculator to get Koala PP

Checking our data to look at influence of popualation on encounters
How many people are in each suburb?
How many koalas?

What suburbs actually have koala habitat?

How many koalas in the priority areas?
How much of the priority area is actually protected?

Digitise missing bits

Heatmaps
Point clustering
Convert points to raster

Nearest neighbour analyses?



## Gather some data

We're going to explore a number of different online spatial data repositories.


Species, post code, protected areas, environmentally signficant areas, population, satellite data
?? Indigenous areas, Cat geography

LGAs of QLD
https://qldspatial.information.qld.gov.au/catalogue/custom/search.page?q=SEQ

### Data from the ABS
#### Postcodes
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files

#### Population
https://www.abs.gov.au/statistics/people/population/regional-population/latest-release#data-download

### Data from Fed Gov
#### Protected Areas
QLD Globe / QLD Spatial
http://www.environment.gov.au/fed/catalog/search/resource/details.page?uuid=%7B4448CACD-9DA8-43D1-A48F-48149FD5FCFD%7D

#### Areas of Environmental Significance
QLD Globe / QLD Spatial

https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid={E4CCDBA7-11AB-45DD-A064-BDBC02899204}
https://environment.des.qld.gov.au/wildlife/animals/living-with/koalas/mapping/koalamaps

### Species Locations
#### GBIF or ALA
Create an account?
Or download data beforehand?

Atlas of Living Australia
https://bie.ala.org.au/species/https://biodiversity.org.au/afd/taxa/e9d6fbbd-1505-4073-990a-dc66c930dad6

Global Biodiversity Information Facility

iNaturalist

#### CSV import
This is what you get grom ALA

### Satellite Imagery
NearMap Data

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



