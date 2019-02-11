# OpenStreetMap: contributing and using the data

## OpenStreetMap

**OpenStreetMap** (OSM) is a database of spatial data released under an **Open Database Licence** (ODbL) and supported by the **OpenStreetMap Foundation**.

> "You are free to copy, distribute, transmit and adapt our data, as long as you credit OpenStreetMap and its contributors. If you alter or build upon our data, you may distribute the result only under the same licence. The full legal code explains your rights and responsibilities."

Most of the data has been contributed by **volunteers** over the years, surveying areas by hand, tracing features from aerial imagery, or merging compatible datasets into OSM. Some people call OSM the "Wikipedia of spatial data".

Most of the data on OSM is either a point, a line or a polygon. They are described with tags. For example, to tag a polygon as a park, we can use the tag `leisure = park`, in which `leisure` is the key and `park` is the value.

## Contributing to OSM

If you don't already have an OSM account, head to https://www.openstreetmap.org and create one.

### Missing Maps

We will start editing the map by contributing to a particular OSM project: Missing Maps, an effort to map areas of the world where up-to-date maps are urgently needed. This project was founded by Médecins Sans Frontières, several Red Cross organisations and the Humanitarian OSM Team.

We will use the HOT Task Manager, a tool that makes it very easy to contribute to this effort.

1. Head to the website: https://tasks.hotosm.org/contribute?difficulty=BEGINNER
1. Select a project to work on. We will agree on one specific one to work on it together.
1. Make sure you read the instructions
1. Make sure your are logged in with your OSM account
1. Click on a task (a square) that is available ("Ready").
1. Click on "Start Mapping"
1. Keep the default "iD Editor" selected and click on "Start Editor"
1. A new tab will open with the ID editor, allowing you to map whatever the projects focuses on

Make sure you stick to the boundaries of the task, and remember what the instructions said about what to map and what imagery you should use – you can always go back to them.

### Local knowledge

Did you make a note of something near where you live that is missing from OSM data?

Let's try and add that to the database now!

1. Head to https://www.openstreetmap.org/
1. Find the location you want to edit
1. Click on "Edit"
1. Add a point / a line / an area that corresponds to what you want to add
1. Search for the feature you want to add after tracing it.

iD also make it easy to find documentation about the feature on the OSM Wiki: 

## Using the data in QGIS

### Basemap

We can straight away use an OpenStreetMap basemap in QGIS: Browser panel (on the left) > XYZ Tiles > double-click on OpenStreetMap

**QuickMapServices** also offers alternative renderings of OSM data. Install the plugin and search for "openstreetmap".

## Shapefiles

To get an actual shapefile, we can go to the OSM website and click "export".

We can then drag and drop this file into our layers.

### Useful plugins

#### QuickOSM

We can also use a QGIS plugin called "QuickOSM". After installing it, you can go to "Vector > Quick OSM" and create a query to pull in vector data.

For example, try querrying the `building` key on the current extent of the map.



## OSM links

* Browse the data and export it: https://www.openstreetbrowser.org
* Keep in touch with contributors around Brisbane: https://wiki.openstreetmap.org/wiki/Brisbane
* OSM user diaries: https://www.openstreetmap.org/diary
* Missing Maps: https://www.missingmaps.org/

## QGIS links

* Official training manual: https://docs.qgis.org/testing/en/docs/training_manual/index.html
