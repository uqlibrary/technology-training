# OpenStreetMap: contributing and using the data

## OpenStreetMap

**OpenStreetMap** (OSM) is a database of spatial data released under an **Open Database Licence** (ODbL) and supported by the **OpenStreetMap Foundation**.

> "You are free to copy, distribute, transmit and adapt our data, as long as you credit OpenStreetMap and its contributors. If you alter or build upon our data, you may distribute the result only under the same licence. The full legal code explains your rights and responsibilities."

Most of the data has been contributed by **volunteers** over the years, surveying areas by hand, tracing features from aerial imagery, or merging compatible datasets into OSM. Some people call OSM the "Wikipedia of spatial data".

Most of the data on OSM is either a point, a line or a polygon. They are described with tags. For example, to tag a polygon as a park, we can use the tag `leisure = park`, in which `leisure` is the key and `park` is the value.

## Contributing to OSM

If you don't already have an OSM account, head to https://www.openstreetmap.org and create one.

Looking at the map, can you spot something that is missing, or that needs updating? Once you are logged into your account, you can click the "Edit" button at the top of the page and start modifying the data.

### Local knowledge

Did you make a note of something near where you live or work that is missing from OSM data? Or does something need updating?

Let's try and contribute data to the project now!

1. Head to https://www.openstreetmap.org/
1. Find the location you want to edit
1. Click on "Edit", which opens the default OSM editor: iD. It offers you a walkthrough if you want to familiarise yourself with the interface.
1. To add a new feature:
  1. Add a point / a line / an area that corresponds to what you want to add. When tracing a line or an area, click a second time on the last point to confirm you are finished tracing.
  1. In the left-hand sidebar, search for the kind of feature you want to add after tracing it. Once selected, you will see the recommended tags you can fill in.
1. To edit an existing feature:
  1. Click on an existing feature to edit its tags in the left-hand sidebar.

iD also makes it easy to find documentation about the feature on the OSM Wiki: there is an "i" button next to most tagging boxes, so we can quickly read a short description of the key-tag pair.

You can keep editing more features if there is more to edit. Once you have finished editing the map, you can upload your changeset:

1. Click the "Save" button at the top right
1. In the left-hand sidebar:
  1. Add a changeset comment to let other editors know what you changed
  1. Add a "Sources" field to record where the information comes from. For example, if you added information because you are familiar with the area, you can add the value "Survey" as a source.
  1. Click "Upload"

You have now added data to OpenStreetMap!

### Missing Maps

Another way to add useful data to the database is by contributing to a particular OSM project: Missing Maps, an effort to map areas of the world where up-to-date maps are urgently needed. This project was founded by Médecins Sans Frontières, several Red Cross organisations and the Humanitarian OSM Team.

We will use the HOT Task Manager, a tool that makes it very easy to contribute to this effort.

1. Head to the website: https://tasks.hotosm.org/contribute?difficulty=BEGINNER
1. Select a project to work on. We will agree on one specific one to work on it together.
1. Make sure you read the instructions
1. Make sure your are logged in with your OSM account
1. Click on a task (a square) that is available ("Ready").
1. Click on "Start Mapping"
1. Keep the default "iD Editor" selected and click on "Start Editor"
1. A new tab will open with the iD editor, allowing you to map whatever the projects focuses on

Make sure you stick to the boundaries of the task, and remember what the instructions said about what to map and what imagery you should use – you can always go back to them on the right hand side.

Once you have added a few features, you can:

1. Submit your changeset (top right button)
1. The changeset comment and the source are automatically populated with relevant hashtags and values
1. Make sure you close the task with the right hand-side panel if you don't want to continue working on it:
  * If the task is complete, mark it as such
  * If the task is not complete, mark it as such
  * You can leave a message to other contributors if needed

After a task is marked as complete, someone will "validate" it. So do not worry if you are not entirely confident about your edits: another contributor will check for you.

## Using the data in QGIS

We want to now analyse the spread of libraries in Brisbane/Meanjin, using OpenStreetMap data. How do different suburbs differ in access to libraries?

Let's open QGIS, create a new project and save it in a newly created directory.

### Basemap

We can straight away use an OpenStreetMap basemap in QGIS: Browser panel (on the left) > XYZ Tiles > double-click on OpenStreetMap

**QuickMapServices** also offers alternative renderings of OSM data - as well as satellite imagery. Install the plugin and search for "openstreetmap".

This is great for locating ourselves on the planet, but we can't really make use of the underlying data because it is a rendered version of it, a static image made of pixels.

## Vector data

To get vector data into QGIS (and the features' associated tags), we can go to the OSM website and click "export".

We can then drag and drop this file into our layers. The issues with this are:

- We get all the features at once
- The attribute table of the features is very messy

There is a better way to get exactly what we're looking for.


### QuickOSM

The QGIS community offers various plugins related to OSM data. For downloading OSM data, we can use a QGIS plugin called "QuickOSM". After installing it, you can go to "Vector > Quick OSM" and create a query to pull in vector data.


### Finding libraries in Brisbane

Let's try looking for libraries in Brisbane. 

Let's search for:

* The key `amenity`
* The value `library`
* In `Meanjin` or `Brisbane`
* Click "Run query"

You sometimes have to refine you query, in particular if it doesn't automatically match the location you are interested in (for example by being more precise, e.g. `Brisbane, Queensland, Australia`).

### Process the data

You should now have extra layers in your QGIS project: one for libraries that were mapped as polygons (probably the building shape), and another one for libraries mapped as points.

To focus on the area where the data is, you can right-click on a layer and click "Zoom to Layer".

> Changing the transparency of the basemap layer can help make the vector data more obvious.´Double-click on the "OpenStreetMap" layer, go to the "Transparency" tab, and set the opacity to about 60%.

#### Reproject the data

We are going to trace buffers 2 km around our libraries. To be able to use this kind of unit, we will have to reproject our data so the measurements are accurate.

One way to do this is:

1. First, set the project's Coordinate Reference System to one relevant to the area of study:
  1. Go to Project > Properties... > CRS
  1. Find and apply the Projected Coordinate System named "GDA2020 / MGA zone 56" (code EPSG:7856)
1. Then, go to Vector > Data Management Tools > Reproject Layer...
1. Select one of library layers (in "Input layer") and set the Target CRS to the Project CRS we just set up.
1. Click "Run"
1. Repeat the three last steps for the other vector layer

#### Draw buffers around the libraries

We can now draw buffers using a specific radius:

1. Go to Vector > Geoprocessing Tools > Buffer...
1. Use one of the reprojected layers as the input
1. Set a distance of 2 km
1. Click run
1. Repeat for the other reprojected layer

To finish with a cleaner look, we can **merge** the two layers (now that they are both the same kind of geometry), and **dissolve** the buffers into a single multipolygon:

1. Go to Vector > Geoprocessing Tools > Merge Vector Layers...
1. In Input layers, click the three dot and select the two buffered layers
1. Click "Run"
1. Go to Vector > Geoprocessing Tools > Dissolve...
1. Select the merged layer as the Input layer
1. Click "Run"

The resulting layer is our final library buffer that we can style to change colours and make more transparent to see the basemap through it.

#### Make layers permanent

Noticed how most of our layers have an icon next to their name? This indicates that they are temporary scratch layers, meaning they are only in memory and not saved as a file. If you close QGIS, even if you save your project, theses layers will not persist.

To make the important layers permanent, for example for the final buffer and the original OSM library data layers:

1. Right-click on a layer, click "Make permanent"
1. Pick a location and filename by clicking the three dots
1. Click "OK"

### Export a map

To export a map, you will have to use the Layout Manager (5th icon in the main toolbar).

When creating documents and visualisations based on OSM data, you will have to respect the licence requirements, and mention where the data comes from.

The following statement should suffice in most cases:

> *© OpenStreetMap contributors: https://www.openstreetmap.org/copyright*

## OSM links

* Browse the data and export it: https://www.openstreetbrowser.org
* Keep in touch with contributors around Brisbane: https://wiki.openstreetmap.org/wiki/Brisbane
* OSM user diaries: https://www.openstreetmap.org/diary
* Missing Maps: https://www.missingmaps.org/

## QGIS links

* Official training manual: https://docs.qgis.org/testing/en/docs/training_manual/index.html
