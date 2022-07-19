# QGIS: Vector Analysis DRAFT

## Setting up

This tutorial is designed for **QGIS 3.22**. If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Open QGIS and create a **new project** with `Project > New`.
Let's start by saving our project: `Project > Save`. We should create a new folder, let's call it "qgis_vector". This where our project and all the saved data will live. Folder structure is very important for keeping you data tidy, but also for ease of sharing your project with others. You simply need to zip the project folder if you need to share it. We can save our .qgz project file here, named "qgis_mobile_map" for example.
I also recommend creating a Data folder, for all of your downloaded data. And creating a Products folder, for all the things we create today. Your .qgz file should always be in the highest level folder, so it's only looking down into folders for data, not back out.

In QGIS 3.10 and above this will automatically set the **project home** too. To do this manually, you can go to `Project > Properties > General` and set `Project home` to the same folder. This is where we can also give the project a title.

Let's also add an OpenStreetMap basemap to locate ourselves on the globe: `Browser panel > XYZ Tiles > OpenStreetMap` (double-click, or drag and drop into the Layers panel).


## Get some data

We're going to explore a number of different online spatial data repositories.
Species, post code, protected areas, environmentally signficant areas

### ABS Data



### Species Locations

Atlas of Living Australia

Global Biodiversity Information Facility

iNaturalist

### Post Code Data

Need to talk to Matt to get the rest of these details

Interactive Maps
https://www.abs.gov.au/websitedbs/D3310114.nsf/home/Interactive+Maps

Spatial Data
https://www.abs.gov.au/websitedbs/D3310114.nsf/home/ABS+Geography+Publications

Boundaries (including postcodes)
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files

Stats
https://www.abs.gov.au/statistics

Population
https://www.abs.gov.au/statistics/people/population/regional-population/latest-release#data-download

Sex, age, pop
https://www.abs.gov.au/statistics/people/population/regional-population-age-and-sex/2020#data-download

Income
https://www.abs.gov.au/statistics/labour/earnings-and-working-conditions/personal-income-australia/2014-15-2018-19#local-government-area-median-total-income

This could be used for analyses where the user inputs a postcode, and gets a certain related value for that.

### Spatial Overlaps

How do protected areas overlap with areas of environmental significance?
Use Intersect
Calculate area in the attribute table
Create other summary stats
Species counts within areas

### Heatmaps

Heat maps of species distribution

### Nearest Neighbour

Perform nearest neighbour calculations to determine how close things are

### Vector to Raster conversion

### Calculating Population change in different regional areas
