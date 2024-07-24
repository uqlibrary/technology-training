
## Past meetings

A history of what was discussed during our meetups. In reverse chronological order.

For meetings before September 2023 see our [Old archive](https://demo.hedgedoc.org/E3RoLxIlSyydQUVvFZGbfg).

## 2024-05-29: UQRUG 50

### R Overview of the Month

#### Using Data to Viz to help you visualise your data

At UQRUG this month, we have an overview of the <a href="https://www.data-to-viz.com/">Data to Viz website</a> by Luke Gaiter.

He will show how this website can be used to explore different visualisation options available to us in R, as well as work through a couple of examples.


### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Luke Gaiter | Library | Here to present and help|
|Valentina Urrutia Guada|Library|Here to help if I can XD|
| Skye Anderson | UQ School of Environment | Learn
|David Green|UQ Research Computing Centre|Q&A|
|Daly Geagea | UQ Faculty of Medicine| Learn|
|Jocelyn Hume|UQCCR|Still learning|
|David Miles|Library|Learning & Here to help|
|Brandon Fraser|QAAFI|Learn
|Cameron West | UQ Library / SMP | Help and learn|



### Questions


#### Q1 - Your Name - Your Question Summary
add more details about your question here

**Answers**

*  first answer
*  another answer

---

#### Q2 - - Your Name - Your Question Summary
add more details about your question here

**Answers**

*  first answer
*  another answer

---
## 2024-04-24: UQRUG 49

### R Overview of the Month

At UQRUG this month, we have a special guest, [David Green](https://rcc.uq.edu.au/rcc-team) from the RCC providing an overview on how to run your R scripts on a [High Performance Computer](https://rcc.uq.edu.au/high-performance-computing) (HPC), so that you can run your complex analyses faster! This will include using their new graphical user interface that allows you to run RStudio too! 

https://github.com/UQ-RCC/hpc-docs
https://rcc.uq.edu.au/bunya
https://uqrug.netlify.app/posts/2023-09-27-september-parallelisation/
https://youtu.be/ewdxiLvYMxg?si=OppPUW534iGcVblk
rcc-support@uq.edu.au


### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | UQ Library | Here to help! |
|Julia Wood |UQ HABS|Here to learn and meet R users|
|Pia Wohland|HABS/SENV|To listen in and learn|
|Zoe MacLean|UQ POLSIS |Here for the RCC presentation|
|David Green|UQ Research Computing Centre|Questions and Answers|
|David Miles|UQ Library|Here to assist Nick as necessary|
|Ryan Leung|SOE|Here to learn
|Kusumitha S|AGFS|Here to see what this group is about
|Kar Ng|DA Bank of Queensland| Learning
|Felicity Charles| SENV Gatton| Here to learn|
|Theophilus Mensah|QAAFI|To learn
|Jocelyn Hume|UQCCR|Still learning R|
|Zhigen Lin|UQ|Learning R|


### Questions


#### Q1 - Your Name - Your Question Summary
add more details about your question here

**Answers**

*  first answer
*  another answer

---

#### Q2 - - Your Name - Your Question Summary
add more details about your question here

**Answers**

*  first answer
*  another answer

---


#### Q3 - - Your Name - Why use RStudio on HPC?
When would you use RStudio on the HPC? What advantages does it give you?

**Answers**

*  I'd recommend using it for porting your code to HPC (paths etc/)
*  Testing interactively

---

## 2024-03-27: UQRUG 48

### R Overview of the Month

This month at UQRUG, before we jump into our help session for everyone to ask questions, this month Nick will look at how we can use some preliminary exploratory data visualisations to identify data issues using the [visdat](https://docs.ropensci.org/visdat/) package.

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | UQ Library | Here to help! |
|Bel|QAEHS|Here to learn|
|Zoe MacLean|HASS Research Assistant|Hang out while coding|
|Luke Gaiter|Library|Here to learn/help/hangout|
|Christopher Sexton|Poche|Learn and improve R coding|
|Pia Wohland|SENV/HABS|Learn and help if Ican|
|Kar Ng|Senior Analyst Bank of Queensland | Hangout|
|Grant Taylor|HAB|Learn and Improve in R|
|David Green|UQ RCC|To help and to learn :-) |
|David Chau|QAAFI|see how to use visdat|
|Julia Wood|HABS PhD Candidate|Learn and help if I can :)|

### Questions


#### Q1 - Julia Wood - Help with GLMM
Need to run some different statistical methods, and need resources on"

* Generalised Linear Mixed Effects Models
* Underdispersion in a binomial generalised mixed effect model

**Answers**

*  [Mixed Models with R](https://m-clark.github.io/mixed-models-with-R/introduction.html)
*  [LADAL Mixed-effects regression](https://ladal.edu.au/regression.html#2_Mixed-Effects_Regression)

---

#### Q2 - Nick - More resources for data checking
Nanair provides a deeper dive into the kinds of missing data that visdat can provide

**Answers**

*  https://github.com/njtierney/naniar

---


#### Q3 - Jayne - Plotting two lots of data on one graph and splitting by time

- regarding plotting of two lots of data on the one graph 
- plus splitting the graphs into smaller time lots

**Answers**

Plotting two y axes
*  reminds me of some data I had analyse ... correlating events with denser sets of points

* This site has details for plotting a ggplot2 graph with two y axes: https://r-graph-gallery.com/line-chart-dual-Y-axis-ggplot2.html

Splitting data by time
*  Create a new variable that gives a value to each “block” of time and create the facet wrap on that
*  Perhaps using the Lubridate function hour() to extract the hour into a new column

---


## 2024-02-28: UQRUG 47

### R Overview of the Month

This month at UQRUG, before we jump into our help session for everyone to ask questions, this month Nick will be looking at some basics of scraping data from Google results and Wikipedia (or any other webpage) using the rvest package.

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | UQ Library | Here to help! |
|Pradeepa Korale-Gedara|QAAFI|Here to learn|
|jeffery|agri sci |learn something about R to deal with my research project|
|Andy Cui|ITEE/EECS/ISB|Here to plot data|
|Jove|UQ Herston|Here to learn|
|Wei Weng|Computer science|Here to learn|
|Ryan|Economics|Here to learn|
|Jessica Hintzsche||i|
|Erda Rame Hau|UQ Vet School| Here to learn ggpicrust|


### Questions


#### Q1 - Andy - Problems with loading packages
Previously, I never needed to install packages everytime I start RStudio. Now, it seems that I get these errors whenever I run a line of code such as:
> library(tidyverse)
Error in library(tidyverse) : there is no package called ‘tidyverse’
> library(dplyr)
Error: package or namespace load failed for ‘dplyr’ in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]):
 namespace ‘lifecycle’ 1.0.0 is already loaded, but >= 1.0.1 is required
 
 Here's an error that will appear when I try to install tidyverse: 
 Execution halted
ERROR: lazy loading failed for package 'ggplot2'
 removing 'C:/Users/s4434877/Documents/R/win-library/4.0/ggplot2'


**Answers**
*  Looks like it's related to the Library location found via .libPaths()
*  Recommended installing a newer version of R, as the current version

---

#### Q2 - Pradeepa - Time series data
I am trying to build a network using time series data. I use tsnet_vg funcion.One of the issues I encounted is the software consider date variable also as a node. Example ![](https://s3.hedgedoc.org/demo/uploads/42bd0611-3d26-4e5e-87a4-214b12fce6cf.png)


**Answers**
*  Run the plot again.
*  Then try changing some of the theming variables/arguments to make the text change
*  You can export the matrix you've created using write.csv()
*  
---

#### Q6 - How to read data in to R
How can I read a csv into R for example?


**Answers**
*  you can use the base read.csv() function, or the tidyverse read_csv()
* The UQ Library Training team regularly runs training sessions that cover this: https://web.library.uq.edu.au/library-services/training


---

#### Q4 - Erda- would like to ask if I can get help using ggpicrust package. thank you
Error in ggpicrust2(data = abundance_data, metadata = metadata_Nepal_kath,  : 
Notice: There are no statistically significant biomarkers in the dataset. This is not an error, but it might indicate that the data do not contain any biomarkers passing the set significance threshold (p<=0.05). You may refer to the tutorial's FAQ for further help and suggestions


**Answers**
* Look through the FAQ and Issues on the github, and if those don't help, raise an issue yourself. https://github.com/cafferychen777/ggpicrust2

---

#### Q5 - AC - I am trying to scrape the athletes with their country and DOB on this page: https://www.worldaquatics.com/swimming/athletes?gender=&discipline=SW&nationality=&name=. How do I know which elements to get? (As in what to put in my code)
More information


**Answers**
*  Use the inspect tool to find the class associated with the table you want to extract. Then use the html_table() function to make it look nice.

---

#### Q6 - Elegant way to paste windows paths in R by reversing the slashes

``` r
snippet pp
    "`r gsub('"', "", gsub("\\\\", "/", readClipboard()))`"
```

Copied from Josh Gilfillan here:
https://stackoverflow.com/a/39989341

---

## 2024-01-31: UQRUG 46

### R Overview of the Month

This month at UQRUG, Nick will be going over how to create a csv data-driven CV/Resume using the [vitae](https://pkg.mitchelloharawild.com/vitae/), [rmarkdown](https://rmarkdown.rstudio.com/), and [tinytex](https://yihui.org/tinytex/r/) packages.

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | UQ Library | Here to help! |
|Jocelyn Hume|UQCCR|Enjoying using R|
|Pia Wohland|SENV|Learning more about R|
|Rio Button|SENV|Wanting to get comfy with R|
||||
|Jessica Hintzsche|QAAFI|You can't get rid of me|
|Christina Maxwell|School of Psychology|Here to learn|
|Kiara Minto|Poche|Learn more R skills - social media scraping and webpage design especially|
|Cameron West|UQ Library / SMP| Here to learn and help!|
|Zoe MacLean | HASS research assistant |Just haven't been by in a while! |
|Pradeepa Korale-Gedara|Postdoctoral Research Fellow|to learn and help| 
|Danelle Kenny|CHSR|Still learning R|
|Jovenal Gama Pinto|Brisbane|Learn R |
|David Green|UQ RCC|Here to learn and help- win win|
|Christopher Sexton | Poche|Build on R skills and learn new packages. |
Chantelle Derez|SEES|Increasing R skills
||||
Monika Walia |PhD student at ISSR, UQ | keen to learn more about R :)
Ana Batallas | PhD student, QBI | want to learn coding
|Sy Mao|PhD student, QAAFI|need help with creating figures with R|
|Ayu Paramecwari|PhD Student, PFSC (Psychology)|Need to start learning R as my PhD team will use R for quantitative stats :)|
### Questions


#### Q1 - Pia - ggplotly bumpchart
Just in case someone has come accross this problem and found a solution.
I created a bump chart which looks fine, but if I uses ggplotly the left align text becomes central. Anybody know how is there a way to left align the text again within ggploty?


**Answers**
*  There might be a way using plotly layouts, but we will have to do some digging for this.
    *  https://plotly.com/r/reference/layout/
*  Alternatively, you may be better off creating the chart in plotly from the start... though this requires learning plotly.

---

#### Q2 - Jocelyn - There are certain packages that I use all the time, is there a way to load these packages by default in R Studio?
Any extra details

**Answers**

* David - Create a text file that has a list of all the packages you want to run at the start of each script you use.
* ``source(file_containing_library()_commands)``
* Cameron - I like David's answer because it's not as hard-coded, but you can do it by adjusting your Rprofile.site file.
    1. Navigate to your R home directory (where R, not RStudio, is stored). You can find this by running `R.home()`
    2. Inside this directory, navigate to `/R-4.x.x/etc/RProfile.site`, open this file (you can use RStudio)
    3. Insert the lines `library(package)` for each package you want to import as per normal.

    Alternatively, you can use `R_DEFAULT_PACKAGES = 'package1, package2, package3, ...'` inside this Rprofile.site file to specify all the default packages you want, but it will override the normal defaults, meaning they *won't* be imported unless you specify them too.
    
    Personally, I think David's solution is better.

----


#### Q3 - DavidG - Comment about how pandoc does its thing

This diagram and paragraph explains what happens while knitr is rendering
https://swcarpentry.github.io/r-novice-gapminder/15-knitr-markdown.html#how-things-get-compiled

**Answers**

----


#### Q4 - Renna - I need to analyse data statistically across different factors/categories in the specific columns. I am still new to using R, so I can proceed that one by one. How can I do it by using for loop? Sorry for the trivial question :D
Any extra details

**Answers**

Set up a loop with parameters similar to what is below
```r
for (i in c("t1", "t2", "t3")) {

}
```
You would need to assign the output of this to a dataframe 

----

#### Q5 - Sy - Question: How to get rid of gridlines of uneven thickness in a heatmap? 
ggplot2 heatmap has large gridlines on the left and thin ones on the right.



**Answers**

There seems to be something weird happening when the image is exported.
Something to explore later.

----
#### Q6 - Danelle - Question: I'm combining dataframes using tidy and the tibble is populating normally, but writing to excel loses the column headings. I've tried header=TRUE and that didn't help. Any idea how to retain column headings from tibble to excel?
Any extra details

**Answers**


## 2023-12-13: UQRUG 45

### R Overview of the Month

This month at UQRUG, for the End of Year we will  be having the **Cool But Useless** competition, where community members will share their creative code that shows off some fun things you can do with R.

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | Library | Here to help! |
| Lauren Fuge | undergrad biomed & statistics! | here to beat cameron |
| Cameron West | Library / Physics | Here to win |
|Tamara|HDR STUDENT|QAAFI-CAS|Here to ask a tricky question
| David Miles | Library | Learning |
|Christina Maxwell|Psychology|Interested to learn|
|Anne-Claire Bouton | Econ/data science | To improve my R skills |
|Souhayel Hedfi| CHSR Herston - health econ. | To see the useless yet cool participations|
|Rio Button|School of the Environment|to learn / get a secound opinion/ watch


### Votes for Coolest and Most Useless RUG

| Nick | Cameron | Lauren| David |
|--------|-------|--------|--------|
||XIIxi##|iIXIIx|I|


### Questions


#### Q1 - How to tell R in my model that I have repeated measurements: a bit of background
I have this model - my supervisor uses sas and and sas you can tell the model the experimental unit

summary(lmer(log_Grazing_Percentage ~ Period + Count_RSSI_GE_Minus50 + Period:Count_RSSI_GE_Minus50 +
       (1 + Count_RSSI_GE_Minus50 | Animal_id:Period),
     data = fp))
Fixed effects:
                               Estimate Std. Error         df t value Pr(>|t|)    
(Intercept)                    1.274369   0.057739  36.627445  22.071   <2e-16 ***
Period                        -0.012289   0.035668  33.633624  -0.345   0.7326    
Count_RSSI_GE_Minus50          0.006682   0.003264 473.393660   2.047   0.0412 *  
Period:Count_RSSI_GE_Minus50  -0.003470   0.001700 459.550503  -2.041   0.0418 * 

The problem I am having is that I want the df to be 26, not these others because they are all repeated measurements for the same 14 animals in 2 different periods. 
Is there a function that I can use so that R is a repeated measurement? Or say to R the Period and Animals they are the experimental unit?

**Answers**
*  Name:  Answer

---


## 2023-11-22: UQRUG 44

### R Overview of the Month

This month at UQRUG, for the special ResBazQld edition, Nick will be providing an overview of some **Cool but Useless** ways we can use R. 
From creating emoji art, to using memes in ggplot2, to playing sounds when our code is complete.

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | Library | Here to help! |
|Bel|QAEHS|To learn cool things.|
| Cameron West | UQ Library & SMP | To learn!|
|Jocelyn Hume|UQCCR|Still Learning|
|Felicity Charles| UQ Gatton| To learn|
|Souhayel Hedfi|UQ Herston|To learn fun stuff too!|
|Thomas Boissiere-O'Neill|CHRC|Learn fun stuff|
|Pradeepa Korale-Gedara|QAAFI|learn and help if I can
|Brittany Elliott|Griffith Uni|To learn|
|Valentina Urrutia Guada|UQ Library|Here to learn and help|
|Noah Rose|UQ|Learn|
|Adriano Fossati|QUT|Curiosity|
|Tanya Dodgen|QUT|Curiosity|
eden hurn|UniSQ|Work and Research
Kate Osborne|UniSQ| Learn
|Michaela | Griffith | Learn
|Mikesh|UQ|love the RUG|
Catherine Kim | QUT | UQRUG is the best!
||||

### Questions

#### Q1 - How to measure the stability of a network - Pradeepa
I am developing a time-series network in R. Network is developed based on the correlation coefficient. 
R Package called ts2net

**Answers**
*  Cat: Might have a link to share that could help with this

This is a time series workshop that UQ Library put together: https://qaehs-lib-rtimeseries2022.netlify.app/

Pradeepa,if your question is about neural networks: https://cran.r-project.org/web/packages/stablelearner/stablelearner.pdf

*  Name: Another Answer

---

#### Q2 - Pros and cons of using R markdown versus word to write journal articles? - Noah
Any extra details

**Answers**
Can use Zotero plugged into R to do in-text citations. Unsure if you can use EndNote or Mendeley for the same purposes.

[R-Ladies Brisbane YouTube video](https://youtu.be/AsIzd1f-JUA?si=tSL-vIcFwTTjKZV6)

Pro:
* Have your code and text in the same document.
* Markdown could be better for formulas with latex.
* Can do citations in Rmd with Zotero - need a plugin (betterbibtex?) for Zotero to make unique IDs for each citation.
* Can export the one document to .docx, .pdf, .html (for slides or as a website)

Con:
* May have to export to word anyway depending on what the journal accepts.
* Non-programmers would struggle (if collaborating).
* Can be fiddly.

Semi-related, unofficial UQ thesis template for Rmarkdown:
https://github.com/gsiemon/UQThesis
Antique Article 2014: 
https://archive.blogs.harvard.edu/pamphlet/2014/08/29/switching-to-markdown-for-scholarly-article-production/

---

#### Q3 - Are there packages that allow you to put your own images in R? - edenn subset the data I Answers**
*  Jocelyn: I just stumbled upon rsvg and ggsvg to add svg images into a ggplot. Also magick package.
*  Nick: ggimage works just like ggdogs

---
#### Q4 - How to reduce loading time for large plotly graph? - Jocelyn
I have created some plotly graphs that have a lot of data points and takes a long time to load. Is there a function that I can use so that R is a repeated measurement? Or say to R the Period and Animals they are the experimental unit?

**Answers**
*  Name:  Answer

---

#### Q5 - Correlations in R? - Eden
Any extra details

**Aneed into plotly

---
## 2023-10-25: UQRUG 43

### R Overview of the Month

This month at UQRUG, Raimundo Sanchez will be providing an overview of supervised machine learning using the tidymodels framework in R.

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | Library | Here to help! |
|Wilma Hart |UQ St Lucia|learn about machine learning in R|
|Kar Ng | UQ | Machine Learning Learning |
|Anne-Claire |UQ |Implementing ML in R|
|Jessica Hintzsche|QAAFI|Interested in the Machine learning field||||
|Pradeepa Korale-Gedara|QAAFI|Interested in Machine Learning|
|Marguerite King|UQ SHRS| interested in machine learning 
|Victoria Pozdniakova |UQ| interested in machine learning
|Than Myint Swe|AGFS|Interested in machine learning and remote sensing|
|Catherine Kim|UQ/QUT|Used tidymodels before|
### Questions
No questions this month!

----

For meetings before September 2023 see our [Old archive](https://demo.hedgedoc.org/E3RoLxIlSyydQUVvFZGbfg).