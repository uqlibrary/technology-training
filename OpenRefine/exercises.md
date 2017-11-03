# OpenRefine
        https://data-lessons.github.io/library-openrefine/
        Video walk throughs:
        http://openrefine.org/

## We are going to do learn how to:

    1. Import / export
    2. facets
    3. Edit cell
    4. Edit column

With 3 and 4 we can group data and transform data




Exercise 1
Create a project

    Select web addresses (URL)

Data:
    https://raw.githubusercontent.com/data-lessons/library-openrefine/gh-pages/data/doaj-article-sample.csv
    click next
    Parse text: separator comma, and first line is a header
    Then click Create project
    
Exercise 2

    Have a look at the dataset

    Check the names of the columns

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
