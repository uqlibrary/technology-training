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

* **Attribution** – You must give appropriate credit (mentioning that your work is derived from work that is Copyright © Stéphane Guillou and, where practical, linking to https://github.com/stragu/CDS), provide a [link to the license](https://creativecommons.org/licenses/by/4.0/), and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

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

> How is data organised?
> How do I navigate?
> How do I with cells that contain multiple kinds of data?

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




Exercise 3

    Which licences are used for articles in this file?

    Facet > Text facet

Exercise 4

    Find all the publications without a DOI (digital object identifier) 

    Facet > Customized facet Text facets > facet by blank

    How many?

Exercise 5

    How to correct values using a facet?

    Facet > Text facet

    clik - edit

Exercises 6

    Replacing Text

    Using GREL - General Refine Expression Language

    Edit cells > Transform

    value.replace("|", ";")

Exercise 7

    How do we split author names into separated cells?

    Edit cells > Split multi-valued cells

    type ";" click OK

Exercise 8

    How to clean up author data?

    Edit cells > cluster and edit

Exercise 9

    correct publisher data

    facet > text facet

    why do we have two that look so similar?

     Edit cells > Common transforms > Trim leading and trailing whitespace

Exercise 10 

    Change Titles into Title Case

    publisher

    facet > text facet

    include

    title

    edit cells > transform

    value.toTitlecase()


    Check the Undo/ Redo

    demo


Exercise 11

    splitting and joining columns

    Citation

    Edit column > split into several columns

    "," OK


    to rejoin

    Edit cells > transform

    cells['Citation 1'].value + ', ' + cells['Citation 2'].value + ', ' + cells['Citation 3'].value + ', ' + cells['Citation 4'].value

    To remove

    Edit column > remove this column


    To rename

    Edit column > rename this column



Exercise 12 Retrieving data!!!!!!

    We will be using CrossRef

    use the ISSN

    select the first row with ISSN

    click star 

    All > Facet by Start

    ISSN

    Edit column > Add column by fetching URLS


    New Column Name: JournalDetails

    "https://api.crossref.org/journals/"+value

    OK


    Edit column > add column based on this column

    Journal Title

    value.parseJson().message.title
    
## Links

* Video walk throughs: http://openrefine.org/
* Getting started with OpenRefine by Thomas Padilla: http://thomaspadilla.org/dataprep/
* Cleaning Data with OpenRefine by Seth van Hooland, Ruben Verborgh and Max De Wilde: http://programminghistorian.org/lessons/cleaning-data-with-openrefine
* Blog posts on using OpenRefine from Owen Stephens: http://www.meanboyfriend.com/overdue_ideas/tag/openrefine/?orderby=date&order=ASC
* Identifying potential headings for Authority work using III Sierra, MS Excel and OpenRefine: http://epublications.marquette.edu/lib_fac/81/
* Free your metadata website: http://freeyourmetadata.org/
* Data Munging Tools in Preparation for RDF: Catmandu and LODRefine by Christina Harlow: http://journal.code4lib.org/articles/11013
* OpenRefine News (monthly round up of new blog posts, tutorials and other information): http://openrefine.org/blog.html
