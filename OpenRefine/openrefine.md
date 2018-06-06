# Cleaning data with OpenRefine

## Legal

This lesson is based on a Library Carpentry lesson, available here: https://librarycarpentry.github.io/lc-open-refine/
It is also released under a [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/). The following is a human-readable summary of
(and not a substitute for) the [full legal text of the CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/legalcode).

You are free:

* to **Share** – copy and redistribute the material in any medium or format
* to **Adapt** – remix, transform, and build upon the material

for any purpose, even commercially.

Under the following terms:

* **Attribution** – You must give appropriate credit (mentioning that your work is derived from work that is Copyright © Stéphane Guillou and, where practical, linking to https://gitlab.com/stragu/CDS), provide a [link to the license](https://creativecommons.org/licenses/by/4.0/), and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

## Installation

To install the software, please follow the instruction on the OpenRefine website: http://openrefine.org/download.html
This lesson was designed using OpenRefine 2.8 but should be compatible with other supported versions.
OpenRefine requires to have a Java Runtime Environment (JRE) installed, so you might need to install one to be able to use it: http://java.com/

## OpenRefine?

OpenRefine is self-described as "a power tool for dealing with messy data". It can help you deal with inconsistencies in data stored in a tabular format (spreadsheets, CSV files, etc.).

It can help you:

* Get an overview of a data set
* Resolve inconsistencies in a data set, for example standardizing date formatting
* Help you split data up into more granular parts, for example splitting up cells with multiple authors into separate cells
* Match local data up to other data sets, for example in matching local subjects against the Library of Congress Subject Headings
* Enhance a data set with data from other sources

Some common scenarios might be:

* Where you want to know how many times a particular value (name, publisher, subject) appears in a column in your data
* Where you want to know how values are distributed across your whole data set
* Where you have a list of dates which are formatted in different ways, and want to change all the dates in the list to a single common date format
* Where you have a list of names or terms that differ from each other but refer to the same people, places or concepts
* Where you have several bits of data combined together in a single column, and you want to separate them out into individual bits of data with one column for each bit of the data.

## What you will learn today

1. Importing and exporting data
2. What "facets" are
3. Editing cells
4. Editing columns
5. Grouping and transforming data

## Material

### Creating a project

OpenRefine can deal with formats like TSV, CSV, ODS, XLS and XLSX, JSON, RDF, XML and more.

**Exercise 1** – Create a project and import data

1. Select `Web Addresses (URL)`
2. Input the URL to our data: https://raw.githubusercontent.com/LibraryCarpentry/lc-open-refine/gh-pages/data/doaj-article-sample.csv
3. Click "next"
4. Click in the `Character encoding` box and select `UTF-8`
5. Click on `Create Project`

### Layout of OpenRefine

> How is data organised? How do I navigate it?
> How do I deal with cells that contain multiple kinds of data?

OpenRefine displays data in a tabular format: rows usually are records, and columns are a type of information.
You can decide how many rows you want to show at once.

Drop-down menus next to the column headers allow you to do operations on the whole column.

OpenRefine has two modes for viewing data: `Rows` and `Records`. In `Records` mode, OpenRefine can link together multiple rows as belonging to the same record.
To demonstrate what the `Records` mode does, we are going to split author names into separate cells.

Author names are currently separated with the pipe symbol `|`. We can use the `Split multi-valued cells` function to put them in their own cells.

**Exercise 2** – Split multi-valued cells

1. Open the drop-down menu for the `Authors` column
1. Select `Edit cells` > `Split multi-valued cells`. Note that the rows are still numbered sequentially.
1. Use the pipe character `|` as a separator.
1. Switch to the `records` mode. Note how the numbering has changed: several rows are related to the same record.

How do we join data from several cells together, for example after cleaning the data up?

**Exercise 3** – Join multi-valued cells

1. Open the drop-down menu for the `Authors` column
1. Select `Edit cells` > `Join multi-valued cells`. Note that the rows are still numbered sequentially.
1. Use the pipe character `|` as a delimiter and click `OK`.

Split rows are now gone. `Rows` and `records` views are now back to the same numbers.
Make sure you choose the right delimiter for the kind of data you deal with!

**Exercise 4** – Practice splitting and joining

How would you split and then join again the data in the `Subjects` column?

### Facetting and filtering

> What are facets and filters in OpenRefine? How can they help me navigate data?
> How can I correct common data issues?

#### Facets

A **facet** groups all the values that appear in a column, and allows you to filter the data by these values and edit values across many records at the same time.

The simplest type of Facet is called a ‘Text facet’. This simply groups all the text values in a column and lists each value with the number of records it appears in. The facet information always appears in the left hand panel in the OpenRefine interface.

Let's create a Text Facet for a column:

1. Click on the drop down menu at the top of the `Publisher` column and choose `Facet -> Text Facet`
1. Filter the data by clicking on a value
1. Add more values with `include`
1. You can `invert` your selection
1. Click `reset` to deselect all values, or remove the facet with the cross.

**Exercise 5** – Explore licenses

Which licenses are used for articles in this dataset? Which one is the most common? How many articles don't have a license?

1. In the `License` column drop-down menu, choose `Facet -> Text facet`
1. `CC BY` has the highest count
1. 6 articles don't have a `License` value, marked `(blank)`

There are more facets available, like numeric and timeline facets that produce graphs, or even custom facets for more advanced operations, like facets that return a logical value.

Exercise 6 – Facet by blank

Find all the publications without a DOI (digital object identifier) with the `Facet by blank`. How many are there?

1. `Facet > Customized facet > Facet by blank`

This is more efficient than a text facet, as it will only give two categories.

#### Filters

You can also apply a **text filter** to your data. In the column drop-down menu, you can use the `Text filter` item and specify any string you want to filter for.

> When you filter your data with facets or text filters, remember that any operation that you carry out will only apply to the filtered data.

#### Amending data

Using a text facet, you can edit values for a whole subset in one action with the `edit` option. This is very useful for fixing small typos or variations in spelling.


**Exercise 7** – Correct values

Use a text facet on the `Language` column to replace `English` values with the language code `EN`.

1. `Facet > Text facet`
1. Hover over the term `English` and click `edit`
1. Replace it with `EN` and click `Apply`

### Clustering

> What can I use to identify and replace varying forms of the same data?

The `Cluster` function uses an algorithm to group together similar, but inconsistent values in a given column and lets you merge these inconsistent values into a single value you choose.

This is very effective where you have data with minor variations in data values, e.g. names of people, organisations, places, classification terms.

By default, OpenRefine uses the most common value to merge the data, but we can choose which value we prefer.

**Exercise 8** – clean up the author names

1. Split out the author names into individual cells using `Edit cells -> Split multi-valued cells`, using the pipe (`|`) character as the separator
1. Choose `Edit cells -> Cluster` and edit from the `Authors` column.
1. Using the defaults (`key collision` Method and `fingerprint` Keying Function), work through the clusters of values, merging them to a single value where appropriate
1. Try changing the clustering method being used - which ones work well? Do they identify extra clusters?

The best clustering algorithm will depend on the kind of data your are processing.

### Reorganising the data

You can **re-order the columns** by clicking the drop-down menu at the top of the first column (labelled ‘All’), and choosing `Edit columns -> Re-order / remove columns …`

You can then drag and drop column names to re-order the columns, or remove columns completely if they are not required.

You can also sort the rows by clicking on the drop-down menu for the column you want to sort on, and choosing `Sort`.The sorting is not permanent, and a new `Sort` drop-down menu appears at the top, which allows you to modify the current sort, remove it, or make the sort permanent.

### Transformations

Facets, filters and clusters already allow us to explore and clean up our data.

To do more advanced operationgs, like splitting data into several columns, standardising a format without losing the original values, or extracting a data type from a string, we need **transformations**.

Transformations are ways of manipulating data in columns. Transformations are normally written in a special language called **GREL** (General Refine Expression Language).

Some common transformations are accessible directly in the menus, for example to change the case of the values, or to remove bounding whitespace characters.

**Exercises 9** – Correct publisher data

1. Create a text facet on the `Publisher` column
2. Note that in the values there are two that look identical – why does this value appear twice?
3. On the `Publisher` column, use the dropdown menu to select `Edit cells -> Common transforms -> Trim leading and trailing whitespace`
4. Look at the publisher facet now – has it changed? (if it hasn’t changed, try clicking the Refresh option to make sure it updates)

#### Writing transformations

The transformation screen is available through `Edit cells -> Transform...`, in which you can write your GREL command and preview its effect.

GREL supports two types of syntax:

* value.function(options)
* function(value, options)

Either is valid, and which is used is completely down to personal preference. In these notes the first syntax is used.

The most simple "transformation" is `value`, which will keep the data as it is. Press `OK` to execute it, and go back to the transformation screen.

You can now see your history of transformations, and save your favourite ones by clicking on the star next to them. The `Help` tab is also a helpful reference.

**Exercise 10** – Put titles into Title Case

Use Facets and the GREL expression `value.toTitlecase()` to put the titles in Title Case:

1. Facet by publisher
1. Select “Akshantala Enterprises” and “Society of Pharmaceutical Technocrats” (To select multiple values in the facet, use the include link that appears to the right of the facet.)
1. See that the Titles for these are all in uppercase
1. Click the dropdown menu on the Title column
1. Choose `Edit cells -> Transform...`
1. In the Expression box type `value.toTitlecase()`
1. In the review note that you can see what the affect of running this will be
1. Click OK

#### Undo and redo transformations

In the left-hand panel, you can open the `Undo / Redo` tab to access all the steps taken so far, and undo steps by clicking the last step you want to preserve.

The `Extract...` button allows you to save a set of steps as a JSON script, to re-apply them later on this or any other dataset. To executed an extracted set of steps, click the `Apply` button.

#### Transforming strings, numbers, dates and boolean

> How do I transform different data types?

**Data types** and **regular expressions** will allow you to write more complex GREL transformations.

All data in OpenRefine has a "type". The most common is "string", which is a piece of text. Data types supported are:

* String
* Number
* Date
* Boolean
* Array

**Date and numbers**: we currently have a `Date` column where the data is represented as a string. If we wanted to sort according to this data, it would not end up chronological. We therefore need to convert the values to a date or number for OpenRefine to interpret them properly.

**Exercise 11** – Reformat the date

1. Make sure you remove all Facets and Filters
1. On the Date column, use the dropdown menu to select `Edit cells -> Common transforms -> To date`
1. Note how the values are now displayed in green and follow a standard convention for their display format (ISO8601) - this indicates they are now stored as date data types in OpenRefine. We can now carry out functions that are specific to Dates
1. On the Date column dropdown select `Edit column -> Add column based on this column`. Using this function you can create a new column, while preserving the old column
1. In the ‘New column name’ type “Formatted Date”
1. In the ‘Expression’ box type the GREL expression `value.toString("dd MMMM yyyy")`

**Booleans**: a boolean is a binary value that can either be "true" or "false". They are often used in GREL expressions, for example:

```
value.contains("test")
```

... generates a boolean value which depends on whether the cell value contains the string "test" anywhere.

That allows use to build more complex transformations, for example by carrying out a transformation _only if a test is successful_:

```
if(value.contains("test"),"Test data",value)
```

... replaces a cell value with the words "Test data" only if the value in the cell contains the string "test" anywhere.

**Exercise 12a** – Find reversed author names

In this exercise we are going to use the Boolean data type. If you look at the Authors column, you can see that most of the author names are written in the natural order. However, a few have been reversed to put the family name first.

We can do a crude test for reversed author names by looking for those that contain a comma:

1. Make sure you have already split the author names into individual cells using `Edit cells -> Split multi-valued cells` (you should have done this in a previous exercise)
1. On the Authors column, use the dropdown menu and select `Facet -> Custom text facet...`
1. The Custom text facet function allows you to write GREL functions to create a facet
1. In the Expression box type `value.contains(",")`
  1. Click OK
  1. Since the ‘contains’ function outputs a Boolean value, you should see a facet that contains ‘false’ and ‘true’. These represent the outcome of the expression, i.e. true = values containing a comma; false = values not containing a comma
  1. We will change the name order in the next exercise

#### Handling arrays

> How do I use arrays in a GREL expression?

An ***array** is a list of values. Arrays can be sorted, de-duplicated and manipulated in other ways in GREL expressions. They usually are the _result_ of a transformation, and cells can't contain them.

For example, if a cell contains the following string:

```
“Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday”
```

... it can be transformed into an array with the `split` function:

```
value.split(",")
```

... which would result in the following array:

```
[“Monday”,”Tuesday”,”Wednesday”,”Thursday”,”Friday”,”Saturday”,”Sunday”]
```

Combining the `split` function with a `sort` function like so:

```
value.split(",").sort()
```

... would resut in an array of days of the week sorted alphabetically:

```
[“Friday”,”Monday”,”Saturday”,”Sunday”,”Thursday”,”Tuesday”,”Wednesday”]
```

You can output a value from an array by specifying its position in the list. To extract the first value of the array created by the `split` funtion:

```
value.split(",")[0]
```

If you want to go back to one single string, in order to store the resut in cells, you can use the `join` function:

```
value.split(",").sort().join(",")
```

**Exercise 12b** – Reverse author names

Now that we have narrowed down to the lines with a comma in a name, we can use the `match` function. The match function allows you to use regular expressions, and output the capture groups as an array, which you can then manipulate.

1. On the Authors column use the dropdown menu and select `Edit cells -> Transform`
1. In the Expression box type `value.match(/(.*),(.*)/)`. The `/`, means you are using a regular expression inside a GREL expression. The parentheses indicate you are going to match a group of characters. The `.\*` expression will match any character 0, 1 or more times. So here we are matching any number of characters, a comma, and another set of any number of characters.
1. See how this creates an array with two members in each row in the Preview column

To get the author name in the natural order you can reverse the array and join it back together with a space to create the string you need:

1. In the Expression box, add to the existing expression until it reads `value.match(/(.*),(.*)/).reverse().join(" ")`
1. In the Preview view you should be able see this has reversed the array, and joined it back into a string, without any comma
1. Click OK to apply your transformation, and notice how the "true" group of your facet has 0 members

#### Exporting

> How do I export transformed data?

OpenRefine can export a transformed dataset into a variety of formats. You can access the menu with the top-right "Export" button.

The Custom Tabular Exporter offers extra options, like selecting a subset of columns, reordering them, removing headers, selecting a format and uploading as a Google Spreadsheet.

#### Advanced functions

> How do I fetch data from an API?
> How do I reconcile my data by comparing it to authoritative datasets?
> How do I install extensions?


...
    
## Links

* Video walk throughs: http://openrefine.org/
* Getting started with OpenRefine by Thomas Padilla: http://thomaspadilla.org/dataprep/
* Cleaning Data with OpenRefine by Seth van Hooland, Ruben Verborgh and Max De Wilde: http://programminghistorian.org/lessons/cleaning-data-with-openrefine
* Blog posts on using OpenRefine from Owen Stephens: http://www.meanboyfriend.com/overdue_ideas/tag/openrefine/?orderby=date&order=ASC
* Identifying potential headings for Authority work using III Sierra, MS Excel and OpenRefine: http://epublications.marquette.edu/lib_fac/81/
* Free your metadata website: http://freeyourmetadata.org/
* Data Munging Tools in Preparation for RDF: Catmandu and LODRefine by Christina Harlow: http://journal.code4lib.org/articles/11013
* OpenRefine News (monthly round up of new blog posts, tutorials and other information): http://openrefine.org/blog.html
* GREL documentation: https://github.com/OpenRefine/OpenRefine/wiki/General-Refine-Expression-Language

*[JSON]: JavaScript Object Notation
*[API]: Application Programming Interface
