# QGIS: Introduction to mapping

## Setting up

This tutorial is designed for **QGIS 3.4** (the latest long-term release). If you need to install it on your computer, got to the [QGIS website](https://qgis.org/en/site/forusers/download.html).

Today's **data** can be downloaded here: 
Download the archive and extract it to your desktop.

> Some of our data comes from Natural Earth: http://www.naturalearthdata.com/

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

You can also turn the layer visibility on and off from this panel with the tick box.

### More controls

You can use the `Identify Features` tool in the top toolbar. This allows you to learn about specific features included in the currently selected layer.

## Scale-based visibility

Zoom to a scale in which it doesn't make sense to see features that are too small to distinguish.

Double-click on layer: `Rendering > Scale Dependent Visibility`, and set the minimum scale to the current canvas scale, and the maximum scale to 1:1.

Apply, and try zooming in and out. Notice how the layer name is greyed out when the data is not visible?

## Change symbology

Double-click on layer: `Symbology > Color` and change to a better colour. Click `Apply`.
We can also go into more details about the border (colour, width, type of line...) by clicking on `Simple fill`.

We can make more complex fills by adding an extra "symbol layer", and layering different kinds of fill styles. Try this with both polygons and lines. For example, style the roads so they look like bitumen with line markings.

> If you want to create a cleaner look, `Advanced > Symbols levels... > Enable symbol levels` might help.

Now try to change a point symbology: we don't have to stick to `Simple marker`. Try for example the different icons available with `Symbol layer type > SVG marker` or `Font marker` selected.

## Classify vector data

### Add labels

Have a look at the attribute table for our cities layer. What could we use to label our points?

Double-click on layer: `Labels > Single labels`. You can also use the `Layer Labelling Options` button to open the sidebar, which allows you to "Live update" the map when you change a setting.

Choose `Label with > ...`. In the "Text" tab, we can change the look of our labels: amend the size, the colour, the font... We can also add a text buffer with the "Buffer tab" to make them more readable.

The placement tab allows us to fine-tune the placement of the labels in reference to the points. If we want the label to cover the point, we can use `Offset from point` and use the middle quadrant. We might also want to replace the symbology with a 0-size ellipse marker.

What if you want to label lines? It's a good idea to change the default `Placement` from `Parallel` to `Curved` so the labels follow the shape of the lines.

If labels appear several times on the same line, you can try using `Rendering > Merge connected lines to avoid duplicate labels`. You can also make it neater with the feature `Suppress labelling of features smaller than`, so QGIS doesn't try to render labels for tiny features.

We can also define a rule to associate to some styling: for example, use the dropdown menu next to the Italic icon, and click `Edit...`. Here, we can define an expression that checks for a condition, e.g. `"variable" = 'value'`.

### Classify the symbology

What if we want to colour according to a variable? Depending on the type of variable, we can choose "Categorised" (for categorical data) or "Graduated" (for continuous data).

Double-click on the "states" layer, `Symbology > Categorised`, pick a `Column` to categorise by (for example "type", choose a `Color ramp` and click `Classify`.

Notice how the legend was updated?

We can save styles with `right-click > Styles > Add`, which creates a new one and saves the previous version.

With a continuous numerical variable: we can change the size of the "populated places" symbols according to population. use the `Assistant` to define the scale, with the column `pop_max`.

## Add a raster layer

Try loading the `solaran.txt` file: data about average solar exposure. What is the difference with the other files? What kind of layer is it imported as? What can you do to make it easier to read?

## Plugins

A wealth of plugins is available: `Plugins > Manage and Install Plugins...`. Try for example QuickMapServices, to easily access many sources of raster data.

## Import tabular data



## Merge tabular data

What if we have two datasets we want to merge? `Properties > Join`

## Create a layout to export

Click on `Show Layout Manager` in the toolbar. `Create` a new layout called "Default". We can now see the Layout window.

We can now add elements to our layout: the map, a legend, a scale bar... In order to create a nice printout.
