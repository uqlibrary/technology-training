# QGIS: Introduction to mapping

## Setting up

This tutorial is designed for **QGIS 3.4** (the latest long-term release). If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

The **data** for this session can be downloaded here: https://cloudstor.aarnet.edu.au/plus/s/GjVmwTxN14OwmEc

Download the archive and extract it to your desktop.

> Some of our data comes from Natural Earth: http://www.naturalearthdata.com/

Open QGIS and create a new project with `Project > New`.
Let's straight away **save** our project: `Project > Save`, and save it into the extracted folder.

Let's set the **project home** too: `Project > Properties > General` and set `Project home` to the same folder. This is where we can also give the project a title.

## Interface

The main elements of the interface are:

* the `Browser` panel, to navigate our file system and data sources
* the `Layers` panel, to organise the different layers that compose our map
* the `Canvas`, where we see the map.

## Load layers

### Basemap

We can straight away load an OpenStreetMap basemap to have a background: in the `Browser` panel, `XYZ Tiles > OpenStreetMap`.

### Controls

The default mouse mode is `Pan Map`, which allows to drag the map around. We can use the mouse the zoom in and out, and press the <kbd>Ctrl</kbd> key to use more precision.

### Vector data

To add our own data: `Layer > Add Layer > Add Vector Layer...`, choose the "ne_50m_admin_1_states_provinces" file, and click "Add". It is now in your `Layers` panel.

You can also use the `Project Home` directory in the browser to add another layer: try loading the "populated places" shapefile (format .shp), and keep adding the "lakes" and "rivers" layers.

All layers are visible in the "Layers" panel, with the most recently loaded by default at the top. Layers are rendered as they are listed, which means the top ones will cover the bottom ones. Make sure you optimise the order for your map!

You can also turn the **layer visibility** on and off from this panel with the tick box.

### Learn about the data

You can open the **attribute table** to see tabular data contained in each layer.

You can also use the `Identify Features` tool in the top toolbar. This allows you to learn about specific features included in the currently selected layer.

## Change symbology

Double-click on layer: `Symbology > Color` and change to a better colour. Click `Apply`.
We can also go into more details about the border (colour, width, type of line...) by clicking on `Simple fill`.

We can make more complex fills by adding an extra "symbol layer", and layering different kinds of fill styles. Try this with both polygons and lines. For example, style the roads so they look like bitumen with line markings.

> If you want to create a cleaner look, `Advanced > Symbols levels... > Enable symbol levels` might help.

Now try to change a point symbology: we don't have to stick to `Simple marker`. Try for example the different icons available with `Symbol layer type > SVG marker` or `Font marker` selected.

## Classify vector data

### Add labels

Have a look at the attribute table for our "populated places" layer. What could we use to label our points?

Double-click on a layer: `Labels > Single labels`. You can also use the `Layer Labelling Options` button to open the sidebar, which allows you to "Live update" the map when you change a setting.

Choose `Label with > Name` to label with the city names. In the "Text" tab, we can change the look of our labels: amend the size, the colour, the font... We can also add a text buffer with the "Buffer tab" to make them more readable.

The placement tab allows us to fine-tune the placement of the labels in reference to the points. If we want the label to cover the point, we can use `Offset from point` and use the middle quadrant. We might also want to replace the symbology with a 0-size ellipse marker.

What if you want to label lines? It's a good idea to change the default `Placement` from `Parallel` to `Curved` so the labels follow the shape of the lines. You can try it on the rivers.

If labels appear several times on the same line, you can try using `Rendering > Merge connected lines to avoid duplicate labels`. You can also make it neater with the feature `Suppress labelling of features smaller than`, so QGIS doesn't try to render labels for tiny features.

We can also define a rule to associate to some styling: for example, use the dropdown menu next to the Italic icon, and click `Edit...`. Here, we can define an expression that checks for a condition, e.g. `"variable" = 'value'`. This Expression Builder allows you to create as complex a condition as you want, but you can also use the `Assistant` instead, to create a simple rule.

### Classify the symbology

What if we want to colour according to a variable? Depending on the type of variable, we can choose "Categorised" (for categorical data) or "Graduated" (for continuous data).

Double-click on the "states" layer, `Symbology > Categorised`, pick a `Column` to categorise by (for example "type"), choose a `Color ramp` and click `Classify`.

Notice how the legend was updated in the layers panel?

We can save styles with `right-click > Styles > Add`, which creates a new one and saves the previous version.

With a continuous numerical variable: we can change the size of the "populated places" symbols according to population. use the `Assistant` to define the scale, with the column `pop_max`. If the smallest size is too small, we can amend it.

## Scale-dependent visibility

At some zoom levels, the map gets too crowded.

Zoom to a scale in which it doesn't make sense to see features that are too small to distinguish (for example the cities and their labels).

Double-click on layer: `Rendering > Scale Dependent Visibility`, and set the minimum scale to the current canvas scale, and the maximum scale to 1:1.

Apply, and try zooming in and out. Notice how the layer name is greyed out when the data is not visible?

## Tabular data

QGIS can deal with plain tabular data. For example, try importing the file HDI.ods: it doesn't contain any coordinates, but we can still store it as a layer and use it in our project.

How can we add the Human Development Index (HDI) data to our existing "admin" shapefile?

### Merge tabular data

We can merge several datasets by performing a "join". `Properties > Join`, click on the `+` symbol, set the `Join layer` to "HDI Sheet 1", and the `Join field` and `Target field` to the matching columns that contain the ISO_3166_2 identifiers for our Australian states and territories.

You can now see the joined data highlighted in green in the `Source fields`, and check the actual values in the attribute table.

Try colouring the regions according to this merged HDI data. Does the resulting graduated scale work for our data? You might have to change the `Mode` from "Equal interval" (the default) to something else.

## Add a raster layer

The solaran file is average solar exposure data from the Australian Bureau of Meteorology. It is a text file that contains data organised in a grid: it is **raster data**.

Try loading the `solaran.txt` file: data about average solar exposure. What is the difference with the other files? What kind of layer is it imported as? What can you do to make it easier to read?

When importing data, QGIS might find everything it needs in the file(s) and add the layer as expect with only a drag-and-drop. Other times, we might have to be more specific by using the proper data type in the `Layer > Data Source Manager` and using the right settings.

In our case, we can import the solaran file with `Data Source Manager > Raster`, provide the path to the file in `Source`, and click `Add`. The file does not contain CRS information, which means we have to specify it in the following dialogue: WGS 84 (EPSG:4326).

### Style a raster layer

This layer is a single-band raster layer, which gets coloured automatically in greyscale. We can change that in the symbology, set the `Render type` as "Singleband pseudocolor", use the `Color ramp` called "Spectral", and use the `Color ramp` drop-down menu to "Invert Color Ramp" in order to make the colouring more intuitive (i.e. red for high values and blue for low values).

## Plugins

A wealth of plugins is available: `Plugins > Manage and Install Plugins...`. Try for example to install QuickMapServices, to easily access many sources of raster data.

The plugin should automatically open a side panel in which you can search for terms. For example, search for "satellite" and add the ESRI satellite imagery to your project.

## Create a layout to export

Click on `Show Layout Manager` in the toolbar. `Create` a new layout called "Default". We can now see the Layout window.

We can now add elements to our layout: the map, a legend, a scale bar... In order to create a nice printout.

The layout manager allows us to save several different layouts, one for each output we want to generate. Even if we change our map data, we can reuse the same layouts and export an updated map.
