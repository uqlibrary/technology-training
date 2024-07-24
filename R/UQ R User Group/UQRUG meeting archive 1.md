
## Past meetings

A history of what was discussed during our meetups. In reverse chronological order.

For meetings after September 2023 see our [New archive](https://demo.hedgedoc.org/LfE8EVFES66s4vZcRJy1HQ).

## 2023-09-27: UQRUG 42

### R Overview of the Month

This month at UQRUG, [Raúl](https://scholar.google.com/citations?hl=en&user=jHBYsW0AAAAJ&view_op=list_works&sortby=pubdate) will be providing an overview of using, and the advantages of, Parallelization in R.

Find more details here: <https://uqrug.netlify.app/posts/2023-09-27-september-parallelisation/>

### Attendees

Add your name, where you're from, and why you're here:

| Name                    | Where are you from?          | What brings you here?                                 |
|------------------------|------------------------|------------------------|
| Nicholas Wiggins        | Library                      | Here to help!                                         |
| Raul Riesco             | ACE                          | Here to learn and help :)                             |
| David Green             | UQ Research Computing Centre | R on HPC help                                         |
| Raimundo Sanchez        | Research Fellow SHRS         | R                                                     |
| Giulio Centorame        | IMB                          | Parallel computation hurts my brain                   |
| Jessica Hintzsche       | QAAFI                        | Here to figure out how to make my code more efficient |
| Felicity Charles        | UQ Gatton                    | Here to learn                                         |
| Grant Taylor            | UQ St Lucia                  | Learn more about R                                    |
| Ryan                    | SOE                          | Learn R                                               |
| Jocelyn                 | UQCCR                        | Still learning                                        |
| Valentina Urrutia Guada | Library                      | Here to learn & help                                  |
| Luke Gaiter             | Library                      | Learning                                              |

### Questions

#### Q1 - How do you avoid running out of memory with parallel jobs? - Giulio Centorame

I constantly have issues with running out of memory with parallel operations. E.g. using the package [`furrr`](https://furrr.futureverse.org/)

``` r
# Setup multisession
library(furrr)
library(magrittr)
plan(multisession, workers = 2)

# Vector of paths with huge tables I want to import
paths <- c("big_table1.tsv", "big_table2.tsv", "big_table3.tsv")

# Load everything
# If the tables are too big, R runs out of memory
paths %>%
    future_map(read.table)
```

This can cause issue especially when using HPCs, since the jobs will often fail if the process tries to allocate more memory than requested. How do I limit the amount of memory each child process/all the processes can use?

**Answers**

-   David: The UQ HPCs can allocate up to 2TB of RAM. If you need more RAM, request it. If you are still running out of RAM, then it might be worth splitting the job into multiple separate jobs. e.g. if you're trying to process the three big tables, then run each big table in a separate job
-   Name: Ryan I don't think you have control over the memory of each child process. You might want to use data.table from previous presentations here. It uses openmp for parallization and could be more efficient. I also believe the HPC has openmp all set, so in R, it should be plug and play already. ---

----

#### Q2 - Using detectCores() will detect all cores on a HPC is there a workaround? - David

**Answers**

-   Ryan: Maybe...

``` r
cores = Sys.getenv("SLURM_CPU_PER_TASK")
makecluster(cores)
```

This does a more refine version of the above, but requires an extra package, so not as good for HPC use

``` r
cores <- length(parallelly::availableWorkers())
```

----

#### Q3 - for loops - Grant Taylor

I have the same code for six participants. Made six lots of code, but of course this is very inefficient. Here is a small part...

``` r
#######################   SUB 004   ############################################
#library(tidyverse)

load("0_data/parsedData_cogPsyRep_sub_004.RData")   #  contains a list called "data" which is converted into a dataframe for the Sub (see next line)

df4=data.frame(data)

nTrialsAll=length(df4$Cond1)
nTrialsAll

MRT=median(df4$Time1)
MRT
probCorr=mean(df4$Correct==TRUE)
probCorr

numDR4=sum(df4$DoubleResp==TRUE)
numDR4
probDR4=(sum(df4$DoubleResp==TRUE)/nrow(df4))
probDR4


ACCdf4=tapply(df4$Correct==TRUE, list(df4$Cond1, df4$Cond2),mean)
ACCdf4


RTdf4=tapply(df4$Time1, list(df4$Cond1, df4$Cond2),median)
RTdf4
```

Sounds good. Anything that is more efficient.\
Yes, this example is for sub 4 but I have S=c(1,2,3,4,6,9) \# the Sub numbers I tried something like this...

``` r
for (s in S)
{load(paste("0_data/parsedData_cogPsyRep_sub_00",s,".RData",sep=""))
}  ## loads the data for a specific Sub
```

This particular one probably doesn't need it (paralellisation) Thanks! I'll give that a go :)

**Answers**

-   Raul:

``` r
list_files <- list.files(path = "./0_data", pattern = "parsedData_cogPsyRep_sub")
for (file in list_files){
  a<-data.frame(file)
  return(length(a$Cond1))
  return(median(a$Time1))
}
```

-   Nick: If you have any further issues or questions, don't hesitate to reach out to training\@library.uq.edu.au

------


## 2023-08-30: UQRUG 41

### R Overview of the Month

This month at UQRUG, Valentina will be going over running some basic statistical analyses using R.

Find more details here:
https://uqrug.netlify.app/posts/2023-08-30-august-stats/

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | Library | Here to help! |
|Valentina Urrutia Guada|Library|Here to help :)|
|Raul Riesco|ACE|Learning/helping 
|Kar Ng |UQ |paste0(rep("learning", 3), "!")
| Cameron West | Library | Here to learn! |
| Kim Henville | EAIT | General lurk|
|Marguerite King |SHRS PhD student | Here to learn! |
|Yufan Wang|HABS PhD student| here to learn how to use R for bayesian analysis
Abigail O'Hara | HASS PhD student | General knowledge |
| Ee Liz Puah | HABS | Learning |
|Maca | ISSR | Learn| 
|Bernadette|library| AHHH|
Lucas|Science fac|Learn and solve a question
Jay | computer science | using RStudio for statistical analysis
|Jocelyn | UQCCR | Loving the support from this group!|
|Ryan | SOE | Learning |
| Chris Mancini | EAIT Civil Transport Engineering | Also love the support from this group :-) |
| Luke Gaiter | Library |Trying to fix the in room computer & Learning|
### Questions

#### Q1 - What are some good network analysis packages? - Pradeepa/Nick
We're after some good network analysis packages in R to create a dynamic network of the Australian food system.
Already aware of Bootnet, igraph, visNetwork and threejs, but haven't explored them a lot yet. Looking for more options and opinions on packages.
**Answers**
*  Raul: I think the most used is igraph, I also experimented with networkD3, it has smoother outputs but it has less options. Anyway, all of them are quite difficult to use, for me it was a lot of trial and error to get the simplest of networks >_<. In general I'll recomend igraph as it covers most of basic needs. 
*  

---

#### Q2 - What are some good R packages for bayesian analysis? (Prior distributions) - Yufan
I would like to know if there are any online resources that  teach you how to fomulate prior distributions using R.

**Answers**
*  https://search.r-project.org/CRAN/refmans/surveil/html/priors.html
*  rstanarm - https://mc-stan.org/rstanarm/reference/priors.html
*  https://search.r-project.org/CRAN/refmans/BayesCombo/html/plot.PPH.html 
* https://cran.r-project.org/web/views/Bayesian.html
---

#### Q3 - How to transform a .cvs file into an .nc file - Lucas
I have a .cvs file with contains temperature values per month. Also it has attached lon and lat values. I need those values on QGIS, but i need them separate by month into a raster file. 

**Answers**
*  Nick - I'll follow up with you on this later. We may be able to explore using the [stars](https://r-spatial.github.io/stars/) R package to achieve this

---

#### Q4 - Normality of Residuals or Data points? - Kar

To test for one of the assumption - data normality before deciding the suitable omnibus and post-doc test, which "normality" are we looking at? Residual normality or Data value normality

**Answers**
*  Raul: In general, Residual normality is used to test if your data adjust to a linear model. When a test (like ANOVA) has a normality assumption is ussualy refer to normality of data (value). But it will depend on the test. 
*  Kar: Thank you very much Raul. 

---

#### Q5 - How do you calculate intra class corelations? - Bernadette

**Answers**
Using the irr package which has a icc function. Then you simply feed that the dataframe and the parameters/model you're using to calculate the corrlelations.

-----
#### Q6 - For multiple linear regression, how can we plot it and what's the graph look like? - Jay

**Answers**
*  Raul:Maybe this will help? https://rpubs.com/bensonsyd/385183
"however, in many multiple linear regression situations, the variables we are using cannot be simultaneously represented two-dimensionally so exploring the data visually is far more difficult". All good. It looks like we can't really graph multiple linear regression easily. 
Thanks a lot.

Maybe explore these visualisations? https://statsandr.com/blog/multiple-linear-regression-made-simple/#visualizations-1

* If there are interactions between multiple variables then you can't visualise that easily.
* You would have to visualise the plot at different levels of the interaction, as the slope and corrleation would be different at every level of the interaction
* If you have 2 independent variables, you need three dimensions to visualise each variable, and their interaction. OR have a 2D plot at each level of the interaction - like slices through each of those
* The only time this is fine is if there is no interaction between the variables, and you can collapse that extra dimension.



---

#### Q7 - Does anyone know of good R packages for reverse geocoding? - Chris
For example nearest street address to a GPS coordinate

**Answers**
* https://rdrr.io/cran/tmaptools/man/rev_geocode_OSM.html
* https://brisbane-geocommunity.netlify.app/

#### Q8 - Does anyone know how to conduct LD analysis using genepop in R? - Ola

**Answers**
*  Raul: Not familiar with genepop package, but according to the manual, they have a LD (linkage desequilibrium) test. The function is 
``` r
test_LD(
inputFile,
outputFile = "",
settingsFile = "",
dememorization = 10000,
batches = 100,
iterations = 5000,
verbose = interactive()
)
```


## 2023-07-26: UQRUG 40

### R Overview of the Month

Nick  will be providing an overview on creating **HTML based presentations in R with [Quarto](https://quarto.org/docs/presentations/) and [reveal.js](https://revealjs.com/)**

Find more details and the slides here:
https://uqrug.netlify.app/posts/2023-07-26-july-q-pres/

### Attendees
Add your name, where you're from, and why you're here:

| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Nicholas Wiggins | Library | Here to help! |
| Mikesh Patel | QCMHR | Learning R |
| Raul Riesco | ACE | Learning/helping |
| Ryan | SOE | Learning |
| Luke Gaiter | Library | Here to help! |
| Rene Erhardt | PACE |learning||
| Trinh Huynh |USC|learning|
| Danelle Kenny|CHSR|checking in and trying new things|
| Pia Wohland| SENV|Checking in|
| Jaimee Wheelhouse ||Very new to R|
| Graeme Mattison | TPCH | Learning R!|
| Fran Powell| SVS| Need some help |
| Jocelyn Hume | UQCCR | Still learning|
| David Green|UQ RCC|learning/helping ... R on HPC and Shiny|
|Anne-Claire Bouton | SOE | Learning |
| Windy | SENV | Still learning
| Valentina Urrutia Guada | Library | Here to help!
| Gerry Katai ||    new to R learning 


### Questions

#### Q1 - Learning more about knitr - Trinh Huynh
I haven't worked with R markdown and I would like to learn from beginning- Trinh Huynh
**Answers**
* Take a look at this episode of the R for Reproducible Science workshop https://swcarpentry.github.io/r-novice-gapminder/15-knitr-markdown.html
 Thanks
* The library offers introductory training modules, as well as advanced. You can look for the upcomming sessions in this website: https://web.library.uq.edu.au/library-services/training
* After doing that training, you're more than welcome to bring questions that you have to UQRUG

---

#### Q2 - knit Shiny/plotly objects to local html - Mikesh
Solutions for saving Rmarkdown files with shiny objects locally (no server)? Want to allow someone without R installed on their computer, access the interactive html file. maybe todays session?...
**Answers**
* Nick - I haven't tried combining shiny and quarto, as Shiny will always need that Shiny server running, so I try to stick to HTML related dependencies.
* If you want to have a quarto website or presentation, you can easily publish them to a variety of free sites such as GitHub Pages, Netlify, or Quarto Pub:
    * https://quarto.org/docs/publishing/
*  @Mikesh When you are thinking about this data access question again, please reach out to me via rcc-support@uq.edu.au

---

#### Q3 - How to get cmdstanr working - Fran
When I run cmdstan R, I get a make error.
```
cmdstanr:::get_cmdstan_flags('STANCFLAGS')
Error in `(function (command = NULL, args = character(), error_on_status = TRUE, …`:
! System command 'make' failed
---
Exit status: 2
Stderr:
make: *** /c/Users/uqfpowe1/OneDrive: Is a directory.  Stop.
---
```

**Answers**
*  We spent a while working on this one. Eventually David, Valentina, Nick, and Fran managed to get it working.
*  The issue appears to be that cmdstanr is for some reason pointing at the OneDrive, rather than the local C: drive
*  We tried changing the standard working directory, but this did not work
*  We also pulled everything off of OneDrive that was associated with R and cmdstanr, but it still wasn't working
*  David got us to open the makefile command file inside the cmdstanr installation folder and we found that it was hard coded to run from the $HOME directory.
*  This is apparently different to the working directory. We found that we could check what this was with the following code"
    *  Sys.getenv("HOME")
* We were able to change this with the following code:
    * Sys.setenv(HOME="C:/Users/MyName/Documents")
* We then had the code working.
---

## 2023-06-28: UQRUG 39

### R Overview of the Month

[Nick Garner](https://github.com/N-Garner) will be providing an overview of **the basics of data manipulation with [data.table](https://r-datatable.com/)** and its advantages compared to using the  [**tidyverse**](https://tidyverse.org/)

### Attendees
Add your name, where you're from, and why you're here:
| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Tasneem | SVS | Learning R |
| Nicholas Wiggins | Library | Here to help! |
| Maddison Brown | Biol Postgrad | Keeping myself accountable to learn R!|
|Raul Riesco|ACE|Learning/helping |
|Jay | Computer Science | Learning|
|Ryan | SOE | Learning|
|Semira Hailu | UQCCR | learning R |
|Nick Garner | SBMS | data.table! |
|Rene Erhardt | Pharmacy | LMER|
|Kar Ng | Data Analyst | UQ Student Affairs|
|Jinnat Ferdous| SVS | Have a question and also for learning|
|Brett McKinnon | IMB | Learning|
|Hanh Dao |CHSR|introduction to R|
|henry marshall|tpch clinician|learning - many thanks!|
|Ismail Garba| AGFS | R on Bunya HPC|
|David Green|UQ RCC|Here to learn _and_ help|
|Mikesh Patel|QCMHR|Learning|


### Questions

#### Q1 - What is the difference between data.table and tibble() from tidyverse? AND Can data.table be used for for-loops and creating functions? - Kar

**Answers**
*  dataframe vs tibble vs datatable - A dataframe is like a simple table that has rows and columns, a tibble() can handle more metadata than a basic dataframe, a data.table is structured to handle the data in a faster way
*  Yes, and the processing speed is faster if data.table is used.

---

#### Q2 - Maddi: Just a general question...I am conducting a spatial analysis. Do you recommend any particular way to read tables, e.g. read_table, from_csv, read_excel? I can export data sets as excel or csv. Just want to chose what is easiest. Thanks!

**Answers**
* Raul: For convenience, I always use csv format(write.csv, read.csv), it is a simplified format that do not give much problems and most of downstream analysis will accept it
    * Thank you Raul. 
* Can be useful using readxl when you are using Excel a lot and need to pull in multiple sheets in from a single xlsx file.
* Sometimes dates/times format can get a little weird when converting xlsx to csv
* However, for most cases, it's often easiest using csv
* https://brisbane-geocommunity.netlify.app/

---

#### Q3 - I've got a couple of general questions about LMER - Rene
How to report results? I've got sequencing results and ran LMERs to evaluate if a variable can explain the outcome. The results differ greatly. I interpret it that the LMER don't explain the results. 

**Answers**
* No one was able to help with this one - will follow up with training@library.uq.edu.au

---

#### Q4 - How do you keep your code tidy and easy to understand? I sometimes go back to old code and it takes a long time to figure out what I've done. Also how do you keep up your skills? - Jocelyn
**Answers**
* Raul: I always take a little time adding comments within my code using # symbol (it does not run with the code). It actually helps a lot when you return to your code later on. If I want to publish the code I erase this comments or I organize them in sections. About how I improve... I think the only way is try to do new things in R, you have a lots of tools to help you, and you improve with every new thing. Also courses from time to time, to refresh things...

* Kar: There are best practieses - many people and I suggest to use tidyverse style, having spaces between equals, comma,s brackets, and annotate all your codes using hash and add comments. In all my projects, I always have comments in my codes.

* Nick: In addition to using comments in R using # you can use Github (or keeping it offline) where you can commit changes often with comments on what changes each time you edit the code. That can help you understand what you've done over time and backup your code in case you delete and save over old code. https://happygitwithr.com/index.html 

* rmarkdown is quite good too

* DavidG: we finish the Intro to R workshops with this general advice  https://swcarpentry.github.io/r-novice-gapminder/16-wrap-up.html

---

#### Q5 - How do you know where to put %>% or == or () or {} or []? -- Jinnat

**Answers**
* %>% OR |>  - pipes chain functions together. (Kar: Sometime I call it "then")
* == - bool / boolean operator checks to see if one value is equal to the other 
* !=  : Is "Not Equal"
* () - generally refers to a function
* {} - acts as a container for a block of code to be run together
* [] - is for indexing a variable (Kar: mytable[row, column]), also for data.table functions

---

#### Q6 - How do we save the workspace with a data.table in it? .RData I think is single threaded read when we come back to load it again -- Ryan

**Answers**
* As a general rule I don't generally save my .RData files, I just re-run the code to bring things back into the workspace the next time round. This can make loading R faster, .RData files can balloon out and be quite large, and avoid complications.
* Is there an advantage to saving things as an .RData file?
* If you do export a data.table to a .RData file, it appears that it doesn't retain the data.table format

* https://stackoverflow.com/questions/31250999/r-readrds-load-fail-to-give-identical-data-tables-as-the-original


---

#### Q7 - I am trying to produce a matrix and then will store the descriptive statistics of a dataset in the matrix. But somehow the code is not working. But I can't figure out what's wrong with the code also. -- Jinnat

**Answers**
* Compare two datasets using setdiff() could be a good way to compare the differences
* Get it working with an example dataset, and see what the main differences are there
* It may be the case that there is a column that is in the wrong format, or loaded in wrong

---

#### Q8 - I have a data frame of values that I would like to turn into an equivalent data frame (same rows and same columns) with the individual cells representing the percentage of values in the column. Not sure how to do this - Brett

**Answers**
* This can be done using a mutate() and across()
```{r eval=FALSE, include=TRUE}
# Calculate the percentages
percentages <- proportions_all %>%
  mutate(across(-Var1, ~ . / sum(.)) * 100)
```

---

#### Q9 - I have bunch of R scripts (Multicriteria optimization using genetic algorithms) that requires a lot of computing time. Tried using the Bunya but struggling to get the singularity container working. Need help getting this working. - Ismail

**Answers**
* Does it need a container?  
* DG: You could possibly build personal R packages for the version of R available on Bunya.
* DG: Software containers can be used if the container has exactly what you need within the container.
* DG: Please catch us at https://rcc.uq.edu.au/meetups (HackyHour  _and/or_ Virtual HPC sessions)

---

#### Q10 - When I knit a RMarkdown script, and if it fails half way through because of a bit of bugs, is there a way that I can continue to journey of the Markdown knitting after fixing the bug, instead of re-running the entire Rmarkdown script again? To save some times! - Kar

**Answers**
* Separate your computation from your visualisation from your reporting
* Run your computation in an external script, then run your visualisation externally, then use RMarkdown to bring it all together
* Run the ML scripts external to the RMarkdown document, and then pull the results in to the RMarkdown document
* trycatch() - can pick up on an error, spit out an error message, and the continue running your code without it hanging and stopping https://www.r-bloggers.com/2020/10/basic-error-handing-in-r-with-trycatch/
* Maybe a fancy version of RMarkdown (quarto) could have something that helps? https://quarto.org/docs/computations/r.html 



## 2023-05-31: UQRUG 38

### R Overview of the Month
Nick will be going over how to send emails through R using the [knitr](https://yihui.org/knitr/) and [RDCOMClient](https://github.com/omegahat/RDCOMClient) packages. [This is a handy guide](https://mailtrap.io/blog/r-send-email/#Sending-emails-from-Outlook-RDCOMClient).


### Attendees
Add your name, where you're from, and why you're here:
| Name | Where are you from? | What brings you here? |
|--------|--------|--------|
| Tasneem | SVS | Learning R |
| Nicholas Wiggins | Library | Here to Help and learn!
|Bel|QAEHS|Ideas/to learn
|Raul Riesco|ACE|Learning/helping 
|Jocelyn|UQCCR|Still learning
|Laura Smith|BIOL|Learning how to do more cool things in R :)
|Nick Garner|SBMS|Listening and learning new R things
|Mikesh Patel|QCMHR|Learning R capabilities
|Valentina|Library| Help and learn 
|Raimundo |SHRS| Learning
|Danelle  |CHSR|Familiarity and skill building|
|Tri|SBMS|Learning 
|Agnieszka Mudge|QAAFI|a.mudge@uq.edu.au
henry marshall |TPCH |learning
|Abigail O'Hara |SLC |Learning|


### Questions

#### Reloading packages - Danelle
Describe the problem
Is there an easy way to reload packages across different versions of R
Everytime you load a package in R, CRAN says that the package isn't available for your version of R

**Answers**
* Nick G : Not sure about reloading (if it's already installed) but you can update R and transfer all packages with installr: https://www.r-statistics.com/2013/03/updating-r-from-r-on-windows-using-the-installr-package/ *note: you need to use the R GUI not R Studio and only on windows.* Also, pacman may help otherwise. It checks the packages you want to load and installs them if not installed yet, then loads them all: http://trinker.github.io/pacman/vignettes/Introduction_to_pacman.html  
* Thanks Nick, I keep getting this message (and I've installed the current version)so wondering if you can ask R Studio to behave as if it's an earlier version?:
Warning in install.packages :
  package ‘RDCOMClient’ is not available for this version of R
* Not sure how to fix that issue when it's genuine but I find it often happens to me when the package needs special installation. Like for RDCOMClient it says you need to use this: install.packages("RDCOMClient", repos = "http://www.omegahat.net/R", type = "win.binary") or using devtools  

---

#### Multiple / combining tables - Laura
I have six dataframes that I am trying to combine into a single table using kableExtra package. I don't think it's possible... The dataframes each have 3 fields: variable/n/%. They can't easily be bound into a single df because each variable is different (e.g. gender, state, age). Ideally it would be six consecutive tables grouped maybe using packrows.
(Raul)just to clarify: You are trying to merge them using the variable as reference or just attach them one after the other?
(Laura) Just attach them one after the other.
**Answers**
* Raul: It's a little bit tacky, but it got what you wanted. I have made an example with 3 tables, but it can be used for 6. 
>library(kableExtra)
exmaple DF
df1 <- data.frame(Gender = c("Male", "Female"),
                  Percentage = c("50%", "50%"))
df2 <- data.frame(State = c("NY", "New York", "California"),
                  Percentage = c("30%", "15%", "15%"))
df3 <- data.frame(Age = c("3-18", "18-24", "25-34"),
                  Percentage = c("20%", "10%", "10%"))

function to pick the colnames
>vector_of_first_names <- function(...) {
  dataframes <- list(...)
  first_colnames <- character()
  for (i in seq_along(dataframes)) {
    first_colnames <- c(first_colnames, colnames(dataframes[[i]])[1])
  }
  return(first_colnames)
}

function to change the first colname to "Variable"
>change_first_colname <- function(...) {
  dataframes <- list(...)
  for (i in seq_along(dataframes)) {
    colnames(dataframes[[i]])[1] <- "Variable"
  }
return(dataframes)
}

Apply the function to the df

>vector_variables<-vector_of_first_names(df1, df2, df3)
list_of_dataframes<-change_first_colname(df1, df2, df3)

Create table with grouped rows (you have to specify the title you want for each df and the rows where the chunk start and end in the combined df, maybe you can automate that playing with the dimensions of the dataframe)
>table <- combined_df %>%
  kable(format = "html") %>%
  kable_styling() %>%
  pack_rows(vector_variables[1], 1,2)%>%
  pack_rows(vector_variables[2], 3,5)%>%
  pack_rows(vector_variables[3], 6, 8)
  
Display the table 
>table


---

#### Question 3. What is HedgeDoc Environment? - Mikesh (and can any team use it? - Danelle)

Is the left hand side and R environment, and can we publish the right hand side as a webpage?

**Answers**
https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax

---
##### Q4 - using overleaf and Latex and R for theses - Laura
I'm considering learning LaTex using Overleaf to write my thesis now that I am trying to integrate a results section. Word is not great for integrating outputs from R. I am just looking for input on people that have done this and how best to integrate things from Word and Endnote and R to Overleaf.

**Answers**
* Nick G: I've just done this! Made my whole thesis using Overleaf. Was a learning curve to learn LaTex but eventually was worth it I think, feel free to send me an email if you need help later on. I used Mendley for my refs since it links to overleaf easily - You can transfer these by exporting from endnote. I did put R graphs in, but often moved them into illustrator first, made them look pretty, and then into the thesis. I didn't put R markdown doccuments in though if thats what you're looking to do, but likely theres LaTex packages to insert html pages in. I know you can stitch pdfs into it, but it can screw with chapter labeling.  
---

#### Spatial Analysis in R - Tri


---

#### Formatting data of population genetics to be used in Structure

Sexually reproducing population of a pathogen on a crop, but there may be asexual reproduction.
Wanting to use population structure analysis to look at the SNIPs to determine what may be happening here - is there a population structure, or not, within that one geographical location?
PCA doesn't show 


**Answers**

* Creating a plot to show the difference between genomes?
* Structure software

Download Structure here:
https://web.stanford.edu/group/pritchardlab/structure.html

Guide on using Structure
https://www.ccg.unam.mx/~vinuesa/tlem09/docs/structure_doc.pdf


## 2023-04-26: UQRUG 37

### R Overview of the Month
Luke will be going over his exploration of using generative AI for coding.
The main takeaway is that ChatGPT is a tool to assist you, it won't do all the work for you.


### Attendees
Add your name, where you're from, and why you're here:
| Name | Where are you from? | What brings you here? |
| -------- | -------- | -------- |
| Nicholas Wiggins | Library | Here to Help!
| Luke Gaiter | Library | Here to help
| Valentina Urrutia Guada| Library | Here to help
| Raul Riesco |Australian Centre for Ecogenomics| Here to help too!
| Xueyan Ma | Graduate Student | Learning
| Bel | QAEHS | Just for general ideas
| Willy | Just Learning | SAFS PhD Student
| Jay | grad student | just learning
| Lauren Fuge :) | undergrad student | just learning!
| Lizzie | ITaLI | just leanring R and how it can be applied in my analytical work |
| Debbie |postdoc | to learn from Luke
| Victor S | SBMS
| Ben  Fitzpatrick | UQ Civil Engineering (PostDoc) | To Learn & Help (if possible) |
| Nicholas Garner | SBMS | Here to learn
| Henry | TPCH|
| Semira Hailu | PhD Student | New to R
| Jocelyn | UQCCR | still learning
| KAR NG | Data Analyst @ Student Affair | Learning 
| Pierre Bodroux | P&F | Learning
| Renna | PhD student | Learning (new to R)
| Anthony Bloomer | Graduate student | Here to learn more
| Marie Thomas | ACE | Just getting some ideas
| Isaac Kyei Barffour | PhD student | New To R


### Questions

#### Code not automatically going to the next line and so Data in R doesn't appear to load properly  - Isaac
I have a perculiar problem. When I load data into R, I do not get a vissible notification in R that the data has been loaded. However, any analysis I promt R to perform on the data gets executed correctly.

**Answers**
* We tried searching in the global and project options. 
* Stack overflow, and asking Bing AI and ChatGPT. 
* We reinstalled R and RStudio.

https://support.posit.co/hc/en-us/articles/200713843#stopping-on-a-line

---

#### What are some good tips for learning Regular Expressions/Regex?
**Answers**
A good R focused approach to learning Regex could be to learn to use the [stringr package](https://stringr.tidyverse.org/), which uses Regex in R. The Get Started page on the Stringr website is useful, as are the cheatsheets!

Another super useful resource is regex101, which allows you to test your regex on a string before you run it on all of your data.
https://regex101.com/

---

#### Is there a data.table equivalent for the complete() function? - Nicholas
I've been analysing large datasets which are much easier to manipulate using data.table compared to functions in tidyverse, but I can't find a data.table equivalent (or large data equivalent) for complete(). 

An example of using complete to fill in missing Hours in the "ExampleColumn" :
complete(Hour = 0:23, nesting(Groups), fill = list(ExampleColumn = 0))

**Answers**
* tidytable may be of use: https://markfairbanks.github.io/tidytable/
* As may dtplyr https://dtplyr.tidyverse.org/
* You may simply need to write your own specific data.table code to run it
* OR bring this up as an issue on the data.table GitHub

Good resource for learning data.table
https://atrebas.github.io/post/2019-03-03-datatable-dplyr/#introduction

---

#### Data pre-processing in RStudio - Jay
So, let's say, im working on time-series data (14 days worth of data points @ 1 minute interval). The data is in xlcsv file. 
1. How do I screen off the ir-regular data points using R? Ir-regular data points mean any data points that are less than the min. or greater than the max. of fivenum. I don't want to delete irregular data points, but need to write it another column in csv.
2. after screening out the bad data points, how do i boxplot the good data points at each time step, and have them in a 24-hour span. 

**Answers**
* My go-to for "filtering" out data without removing it out of the table in R is to using case_when() in a mutate function. For example mutate(NewColumn = case_when(OldColumn >= 5 & OldColumn <= 100 ~ Good, T~ Bad)) 
```{r}
mutate(IQR15 = IQR(OldColumn)*1.5, 
    IQRTop = quantile(OldColumn,  probs = 0.75)[[1]] + IQR15,
    IQRBottom = quantile(OldColumn,  probs = 0.25)[[1]] - IQR15, 
    NewColumn = case_when(OldColumn >= IQRBottom & OldColumn <= IQRTop ~ Good, T~ Bad)) 
```
* You could then plot in ggplot2 without filtering the data (if you really don't want to) by using ggplot(data = df[which(df$NewColumn == "Good"),])
* Then plot that using ggplot2 and geom_boxplot: https://ggplot2.tidyverse.org/reference/geom_boxplot.html

---

### 2023-03-29: UQRUG 36
#### Attendees
* Nicholas Wiggins | Library | Here to Help!
* Rene Erhardt | School of Pharmacy |
* Yufan Wang\School of Nursing\ Qs on Bayesian statistics\How to plot a probability density function on R\
* Luke Gaiter | Library | Here to listen/help
* Giulio Centorame | PhD student @ IMB | Qs on functional programming in R
* Kar Ng | Data Analyst at Student Affair | Learning
* Jianan REN | PhD student in Environmental Science | beginner in R
* Jayne McGhie | PhD student in SAFS | beginner in R - not questions yet......
* Katharine Hegerty | PhD student FoM | beginner in R so need to learn pretty much anything but also needing help with registry data project in R
* Valentina
* Lauren:) here to learn !
* Anna Gibbs | Clinical research assistant CCHR | here to learn about GLM in r, offsets, and Rmarkdown
* Lijalem Tesfaw|PhD student @UQ, SPH Biostatistics and Epidemiology division |here to learn how to create R Dashboard, shiny web page, Rmarkdawn and R-spatial analysis
* Grant Taylor|PhD student|here to listen this month, but need help debugging script next time maybe
* 

#### Questions

#### Yufan Wang - Qs on Bayesian statistics
There's a shiny app called the [Shelf](https://shelf.sites.sheffield.ac.uk/software) package. 
How do you interpret the code snippets from the user guide for shelf?
Does anyone have experience plotting a probability density function on R?
BRMS Package might be useful to run the models.
ggplot has [geom_density](http://sthda.com/english/wiki/ggplot2-density-plot-quick-start-guide-r-software-and-data-visualization) and geom_boxplot

#### Giulio Centorame - Qs on functional programming in R
Giulio has some functions that have nested loops on big data.
The advice is to explore the R package parallel.
RCC may have some suggestions. You could try attending Hacky Hour, and seeing if David Green.
Nick will explore with GeoSpatial Community regarding using parallel.
You can try making your code just a little more efficient and this will flow on to save a lot of time in loops.

#### Anna - glm() function question
What is the 
A plus is adding it as a single interaction
An Asterisk is adding the relationship between two factors as a factor
A comma is a another argument in the function, and offset is an argument for the glm() function

#### Anna - R Markdown 
Yes you do need to do data wrangling in markdown before you run analyses on the data.
You don't need to treat each block of code as an individual entity. You only need to run your wrangling once per document.

#### Jayne - Eyes on my code
Dog temperature code.


### 2023-02-22: UQRUG 35
#### Attendees
* Nicholas Wiggins | Library | Here to Help!
* Pierre Bodroux | P&F | Learning
* Kar Ng | Student Affairs | Learning
* Brandon Fraser | QAAFI | Learning
* Valentina Urrutia Guada | Library | Here to Help too!
* Raul Riesco| ACE visiting postdoc | Learning and also willing to help ^_^
* Wilson Lin | Student Affairs | Casually attending
* Jocelyn | UQCCR | Still learning
* Grechel
* Hannah


#### Questions
##### Can you use text mining and machine learning in R to mark student essays?
Is it ethical? But is it possible?

There is an issue with marking free language data. You may want to be looking for certain keywords.

You would likely run into issues with nuance and insight.

If the questions can be answered by a machine, then it can be marked by a machine. If it requires insight, then no.

To do this in R would likely require a lot of backend work to effectively create an AI similar to chatGPT which is capable of dealing with free text input, and providing feedback from there.

##### What are you using R for?
* I am using R for Reporting and data analysis.
* I use R for data analysis and graphs
* I use R to analyse data. Big data. Running loops in parallel has proved difficult. Using parallel and foreach
* Environmental analysis - using seqinr and BALCONY
* I use R for bioinformatics for dna sequencing analysis.

### 2023-01-25: UQRUG 34

Please add your name to our attendee list. Edit this document by clicking the pencil :pencil2: in the top right corner, and then add:
your name | your area of UQ | and why you're here.

If you have question you need help with, put your name in **Bold** by putting two asterisks before and after your name, like so ``**name**``
    
#### Attendees
* Nicholas Wiggins | Library | Here to Help!
* Pierre Bodroux | P&F | Learning
* Zoe MacLean | School Comm Arts | Just hanging out today
* Jessica Hintzsche |QAAFI| I know nothing :) 
* Karen Fang | Business School | learning and see how R can deal with dashboard :)
* Dwan Vilcins | CHRC | Want to learn about flex
* Jocelyn | UQCCR | still learning
* Ayesha.Here for learning about R. I am from EAIT doing masters of data science
* Jayne McGhie | |
* Myra Khan
* Paulo Baleeiro Souza
#### **Topics discussed and code**

#### Presentation on Flexdashboard (and crosstalk)

Nick provided an overview of the dashboard creating package: Flexdashboard.
He showed how you can easily create a dashboard from their templates, and include and R code and outputs in the dashboard.
He also provided a fairly complex example.
Here's an [intro guide for Flexdashboard](https://pkgs.rstudio.com/flexdashboard/articles/flexdashboard.html).

#### Jayne's question on ggplot2
Jayne was having difficulty using the map() function to create

#### Presentation on Flexdashboard (and crosstalk)
    
### 2022-12-07: UQRUG 33
    
#### Attendees

* **Nick** | Library | here to help
* Kim Henville | EAIT | Lurking
* Pierre Bodroux | P&F | Learning about gganimate
* **Luke** | Library | Here shortly to help if can
* Kar Ng | Student Affair | Recap gganimate and plotly
* Chuan | PhD UQ biol | R questions on barplot 
* Bel | QAEHS | To learn intro level skills
* Ainnatul Adawiyah Ahmad Termizi | SAFS | I need help to do statistics for my PhD
* Imsu | PhD | New to RStudio 
* Barbara Azevedo de Oliveira | School of Biological Sciences | improve my knowledge
* Debbie | Postdoc in Sees | find different applications of R
* Chris Mancini | Civil Transport Engineering | Learn about gganimate
* Olive Dang | SAFS | ggplot2 question

#### **Topics discussed and code**

**Presentation on gganimate and plotly animations**
Nick Wiggins did a presentation on animations in gganimate and plotly. He showed some examples of how these can be used to make your graphs somewhat more interesting, and in the case of plotly, interactive.
[gganimate](https://gganimate.com/)
[plotly](https://plotly.com/r/animations/)

**Chuan questions about using barplot**
Chuan was using a barplot to show data which referred to the responses of multiple species across a number of tests.
When using the same code for a slightly different sample group, the colours on the chart changed. We spent some time trying to find the cause of this, such as slight differences in the code, but we didn't come to a solution.
We will next try converting the data to fit into a ggplot.

**Olive Dang ggplot2 legend order**
Olive needed help changing the order of some variables in a ggplot legend. We accomplished this by turning that column of the dataframe into a facotr with levels. E.g. :
```
df$col <- factor(df$col, levels=c('a', 'b', 'c'))
```
**Olive Dang ggplot2 and ggarrange making all the graphs the same size**
Olive had a second question about ggplot when exporting them onto the same page. There was an issue where they weren't lining up very well (the top graph was smaller). We spent some time trying to resolve this issue, however, it turns out that there is an argument in **ggarrange** which allows you to quickly make them the same size. The `align` argument allows you to align graphs along the vertical axis, horizontal axis, or both.

**Ainnatul Adawiyah Ahmad Termizi on using R over Excel**
Ainnatul wanted to recreate some graphs and statistical analyses that had been made in Excel in R. We recommended checking out some of the [introduction to R classes](https://github.com/uqlibrary/technology-training/blob/master/R/rstudio_intro/rstudio_intro.md) that we run, as well as the [ANOVA class](https://github.com/uqlibrary/technology-training/blob/master/R/ANOVA-lm/anova-lm.md) that we have a guide for.

### 2022-10-26: UQRUG 32

             
#### Attendees

* **Nick**: Library | here to help
* **Luke**: Library | here to help
* **Valentina**: Library | here to help
* **Pierre**: P&F | Listen and learn
* **Sophie**: 
* **Robyn**: 
* **Semira**:
* **David**: UQ-RCC | hopefully helpful ;-)
* **Christina**: Psychology | Learn text analysis for R
* **Danelle**:
* **Jaye**:
* **Rene**: Pharmacy | listen and learn
* **Rovan**:
* **Roman**: 
* **Semira**: 
* **Sogra**:
* **Kar**:



#### Topics discussed and code

##### Presentation on quanteda
Nick Wiggins did a presentation on the quanteda package  to give an overview and introduction to the package and how he has recently used it to assist a researcher.
https://quanteda.io/

##### Kar ggplot facet_wrap label issue
Kar has the below sample data set:
```
MyID	eventA review	eventB review	eventC review
id_68	very good	neutral	
id_30	very good	very good	
id_15	good	very good	
id_1	neutral	very good	
![](https://s3.hedgedoc.org/demo/uploads/6f9d7f0d-202b-4549-b7b1-186dbe9bb093.png)

```
He is trying to create a facet_wrap in ggplot that includes labels that are missing from the data, but needed to scale "bad" & "very bad", while having the y labels showing on every facet. Without manually creating each y scale.
```{r}
# Data transformation
trial %>% 
  pivot_longer(c(2:3), names_to = "events", values_to = "review") %>% 
  count(events, review) %>% 
  rbind(tibble(events = c("eventA review", "eventA review"),
               review = c("bad", "very bad"),
               n = c(NA, NA))) %>%
  mutate(events = as.factor(events),
         review = as.factor(review)) %>% 
# plot
  ggplot(aes(y = review, x = n, fill = events)) +
  geom_col(width = 0.5) +
  facet_wrap(~events) +
  theme(legend.position = "none")
```
##### Sogra stat comparison issue

Sogra has a large dataset of protein observations and needs to compare between different groups.

Using the package **MSstats** Sogra needs to re-export that data.

##### Semira

Semira is trying to change the colours of the diamonds in a forest plot created using the **meta** package.
We've tried change the col.diamonds to set the colours, however this changed all of the boxes in the forest plot.
    
### 2022-09-28: UQRUG 31

#### Attendees

* **Luke**: Library | here to help
* **Valentina**: Library | Listen, learn and help
* **Tianjian**: Economics | Listen and learn
* **Nick**: Library | here to help

#### Topics discussed and code

Covered some of the basics around creating, and the differences between, arrays and dataframes.

Worked on reviving the R-based mailing list for RUG.
    
### 2022-08-24: UQRUG 30

#### Attendees

* **Luke**: Library | here to help
* **Chris Mancini**: Civil Engineering | Read multiple CSVs and Shiny question
* **Tayla Lawrie**: NA | Listen and learn
* **Wilson**: Student Affairs | Listen and learn
* **Valentina**: Library | Listen, learn and help
* **Nick**: Library | here to help


#### Topics discussed and code

How to read multiple csv files in as separate variables efficiently for a Shiny app.
Looked at creating a list of files, and then using the read_csv function in rdrr package to read them in.

Tried a lapply(files,read_csv) but this just creates a list of the files.
Found a package known as easycsv which has a function called loadcsv_multi()

```
loadcsv_multi(directory)
```

### 2022-07-27: UQRUG 29

#### Attendees

* **Luke**: Library | here to help and say hello
* **Rene**: Pharmacy | Listen and learn
* **David**: Honours in Science | Histogram ggplot2 issue
* **Wilson**: Student Affairs | Listen and learn
* **Lily**: Honours in Economics | Learning R for course


#### Topics discussed and code

Creating a normal distribution line for a histogram.
Using ggplot geom_histogram() and the stat_function() creates the plot, but the line and histogram are scaled differently on the y axis. 

Needed to scale the stat_function() by the binwidth times observations using a defined function.

```
bw = .5

ggplot(SS, aes(DIA)) +
  geom_histogram( binwidth =  bw)+ 
  stat_function(fun =function(x)
dnorm(x,mean = mean(SS$DIA),sd = sd(SS$DIA))*bw*64) +
  theme(panel.background = element_rect(fill = "white", colour = "grey50"),
  panel.grid.major.y  = element_line(colour = "grey"),
  axis.text = element_text(size=12,family = ("TT Times New Roman"), 
  colour =  'black')) +
  xlab("Inhibitory zone diameter (mm)")+ylab("number of isolates")
```

### 2022-06-29: UQRUG 28

#### Attendees

* **Stéphane**: Library | here to help and say goodbye
* **Chris**: Civil Engineering - Transport | just tagging along
* **Luke**: Library | here to help and say hello
* **Olalekan** Biological Sciences | here to say hello...

#### Topics discussed and code

##### Iterating instead of using repetitive code

The trick here is to:

1. Encapsulate the repetitive code into a function, exposing the things that are likely to change as arguments
2. Create a vector of values (or several)
3. Use a for loop, or an `apply()` function, or a `map()` function (from purrr) to map the function to each element

```r
# iterating

?mean
# custom function
custom_mean <- function (numbers, trim_ratio) {
  # process the data
  my_mean <- mean(x = numbers, trim = trim_ratio, na.rm = TRUE)
  # save the it as file
  saveRDS(my_mean, file = paste0(numbers[1], trim_ratio, ".rds"))
}

# use the function
custom_mean(c(1,5,NA), 0.2)

# iterate
list_to_iterate_on <- list(c(1,5,NA),
     c(1,4,6,8),
     c(1,2,7,9,NA))

trim_ratios <- c(0.2, 0.7, 0.1)

library(purrr)
# alternative to apply functions or for loops
map2(list_to_iterate_on, trim_ratios, custom_mean)

# pmap(): construct a dataframe of all combinations,
# with each column containing the argument values to use

# construct the dataframe of all combinations
animal <- c("magpie", "pelican", "ibis")
treatment <- c("dry food", "sludge", "grain")
# only three rows
experiment <- data.frame(animal, treatment)
# all combinations
library(tidyr)
all_combinations <- expand(experiment, animal, treatment)

```

##### List files

```r
# listing files
list.files() # all files in working directory
only_rds <- list.files(pattern = "rds")
only_rds <- list.files("analysis", "rds")
only_rds
# full path (from working directory)
only_rds <- list.files("analysis", "rds", full.names = TRUE)
only_rds
```

##### Remove file extension from path

```r
# remove file extension from path
library(stringr)
str_replace("filename.txt", ".txt", "")
```

##### Extract information from filenames

Using the tidyverse and pdftools for preparing PDF text before analysis with quanteda. pdftools was used for its specific ability to return the page numbers of the pdfs.

```r
library(pdftools)
library(tidyverse)

# create a list of the PDF file paths
myfiles <- list.files(path = "./pdfs", pattern = "*.pdf", all.files = FALSE,
                      full.names = TRUE, recursive = TRUE,
                      ignore.case = FALSE, include.dirs = TRUE, no.. = FALSE)

# Function to import each pdf file, and place the text in a dataframe
import_pdf <- function(k){
    # turn the pdf into a text list each page will become a row
  pdf.text <- pdftools::pdf_text(k)
    # flatten the list
  pdf.text<-unlist(pdf.text)
  pdfdf <- data_frame(pdf.text)
    # turn the list into a dataframe, extracting the year from the path and using the separate function to extract the state from the path
  data_frame(pdf.text) %>%
    mutate(year = str_extract(k, "[:digit:]{4}") %>% as.integer(), pagenumber = row.names(pdfdf), filename = k) %>% 
    separate(filename, c(NA,NA,"state",NA), sep = "/")
  
}
    # run the function on all pdf files
all_pdfs<- map_dfr(myfiles, import_pdf)
```

See the [quanteda tutorials](https://tutorials.quanteda.io/)

### 2022-06-01: UQRUG 27

#### Attendees

* **Stéphane**: Library, here to help!
* **Emma**: looking for some help editing a graphic with ggplot2
* **Rene**: just tagging along
* **Laura**: working on GLMs
* **Leonie**: both tagging along and hoping for some help with the adehabitat package
* **Chris**: just tagging along
* **David**: using R on HPC 
* **Astrid**: R Markdown issues
* **Olalekan**: just tagging along
* 
* ...and 6 other UQRUGers!

#### Topics discussed and code

* ggplot2 customisation: moving legend, filtering data out
    * [Cédric Scherer's slides](https://www.cedricscherer.com/slides/OutlierConf2021_ggplot-wizardry.pdf) (with customisation of legend using the `guides()` function)

```r
library(dplyr)
# do not keep these three eye colours
starwars %>% 
  filter(!eye_color %in% c("blue", "yellow", "green"))
```
* Preparation for species distribution modelling. Convert dataframe to sf object with `st_as_sf()`, and will probably need to go from vector data to raster data with `terra::rasterize()`
    * The [CRAN Task View on spatial data](https://CRAN.R-project.org/view=Spatial) lists a lot of useful packages
* Importing spatial points for dolphin occurences, using sf. Constructing a convex hull from them and visualising on an interactive map:

```r
# read CSV as dataframe
dolph <- read.csv("Adehabitat.csv")

library(sf)
# convert the dataframe to an sf object
dolph_sf <- st_as_sf(dolph, coords = c("Longitude", "Latitude"))
# see it with default plot method
plot(dolph_sf)

# interactive map
library(tmap)
tmap_mode("view")
tm_shape(dolph_sf) +
  tm_dots()

# convex hull
dolph_hull <- st_convex_hull(st_union(dolph_sf))

# visualise both
tm_shape(dolph_hull) +
  tm_borders() +
tm_shape(dolph_sf) +
  tm_dots()
```

* Detecting anomalies in chronological sequence of a dataframe. `dplyr::lag()` and `dplyr::lead()` functions can be used for comparisons. `any()` and `all()` help reducing many logical values to one.
* R Markdown troubles: Rmd is self-contained and needs to include all the necessary code. Its working directory is by default the directory where the .Rmd file is saved.
* factoextra's `fviz_pca*()` functions for PCA, colouring points per group.
    * [STHDA has examples](http://www.sthda.com/english/wiki/fviz-pca-quick-principal-component-analysis-data-visualization-r-software-and-data-mining)

#### Links

* [R Ladies Brisbane YouTube channel](https://www.youtube.com/channel/UC9oOCJe8kwkZ_6IgTmet9oQ)
* [Geospatial Analysis Community of Practice](https://geospatial-community.netlify.app/)

### 2022-04-27: UQRUG 26

#### Attendees

* Stéphane
* Veronika
* Chris
* Thuong
* Lily
* David

#### Topics discussed and code

* Machine learning with caret and glmnet
* High-performance computing: https://rcc.uq.edu.au/high-performance-computing
* Spatial data: sf, sfnetworks... Austroad dashboard
* Interactive viusalisations: plotly, highcharter, networkD3, leaflet, tmap, crosstalk, Shiny...
* API / direct link for accessing government data that gets updated weekly (see below)

##### Tide data

```r=
# Whyte island, station measuring tide level

path <- "http://opendata.tmr.qld.gov.au/Whyte_Island.txt"
# read with base function, ignore first lines, keep two columns
tide_data <- read.table(path, skip = 5)[,1:2]
# name the column
names(tide_data) <- c("date_time", "LAT")

# same with readr
library(readr)
library(dplyr)
tide_data <- read_table(path, skip = 5,
                        col_names = FALSE) %>% 
  select(1:2) %>% 
  rename(date_time = 1, LAT = 2)

# split the date time
library(lubridate)
tide_data <- tide_data %>% 
  mutate(date_time = dmy_hm(date_time))
# filter and visualise
library(ggplot2)
tide_data %>% 
  filter(LAT > 0.01) %>% 
  ggplot(aes(x = date_time, y = LAT)) +
  geom_line()

# save only the first time:
# write.csv(tide_data, "all_tide_data.csv", row.names = FALSE)

# append new data
all_tide_data <- read_csv("all_tide_data.csv")
all_tide_data <- bind_rows(all_tide_data, tide_data) %>% 
  unique() # check for duplicates
# overwrite file
write.csv(all_tide_data, "all_tide_data.csv", row.names = FALSE)
```

Automate running the script (on Windows): https://cran.r-project.org/web/packages/taskscheduleR/index.html



### 2022-03-30: UQRUG 25

#### Attendees

* **Steph** (Library): helping out!
* **Vicki Martin**: Postdoc, SEES
* **Nisa Abeysinghe**
* **Richard Bell**: PhD, POLSIS
* **Chris Mancini**: HDR - MPhil, School of Civil Engineering
* ... and 6 more UQRUGers!

#### Topics discussed and code

##### Big raster files
Use terra instead of raster, and use a temporary directory:

```r
library(terra)
terraOptions(tempdir = "path to somewhere with lots of space")
as.points() # instead of rasterToPoints()
```

The [Research Computing Centre](https://rcc.uq.edu.au/) can also provide access to supercomputers

##### [Patchwork](https://patchwork.data-imaginist.com/) for joining plots made with [ggforestplot](https://nightingalehealth.github.io/ggforestplot/articles/ggforestplot.html)

To merge two plots with the same y-axis. After creating Forest plot 1 (with y-axis labels), create Forest plot 2 with y-axis labels removed:

```r
library(ggforestplot)
F2plot <- 
  forestplot(
    df = F2,
    name = term,
    estimate = estimate,
    se = std.error,
    pvalue = p.value,
    psignif = 0.05, 
    title = "Plot 2",
    xlab = "estimate",
    ylab = element_text(family = "", size = 10)
  )+ 
  theme(axis.text.y = element_blank())
```
Or try replacing text in ylab (above) to ylab = ""

Then merge the plots:

```r
library(patchwork)
F1plot / F2plot
```

##### Slow `check_model()`

`check_model()` in [performance](https://easystats.github.io/performance/) package: weird behaviour in R Markdown, takes too long to execute. Richard might come back later with the answer!

### 2022-02-23: UQRUG 24

#### Attendees

* **Stéphane Guillou**: just helping out
* **Svetlina Vasileva**
* **Trinh Huynh** (USC)
* **Richard Bell**
* **Luke Gaiter** (ggplot2 lesson)
* ...and 5 other UQRUGers!

#### Code

Convert a table to a `gt` object and then save it to RTF (which can be opened by Word).

```r=
library(gt)
gt(mtcars) %>% 
  gtsave("test.rtf")
```

Attempting to highlight/label outliers in linear regression plot
```r=
### geom_text_repel
# only label players with QoG >  1 or < 0.2
# align text vertically with nudge_y and allow the labels to 
# move horizontally with direction = "x"
ggplot(linear_regression, aes(x= QOG, y = ten_political_conflict, label = district)) + 
        geom_point(color = dplyr::case_when(linear_regression$QOG > 1 ~ "#1b9e77", 
                                            linear_regression$QOG < 0.2 ~ "#d95f02",
                                            TRUE ~ "#7570b3"), 
                   size = 3, alpha = 0.8) +
        geom_text_repel(data          = subset(linear_regression, QOG > 1),
                        nudge_y       = 32 - subset(linear_regression, QOG > 1)$QOG,
                        size          = 4,
                        box.padding   = 1.5,
                        point.padding = 0.5,
                        force         = 100,
                        segment.size  = 0.2,
                        segment.color = "grey50",
                        direction     = "x") +
        geom_label_repel(data         = subset(linear_regression, QOG < 0.2),
                         nudge_y       = 16 - subset(linear_regression, QOG < 0.2)$QOG,
                         size          = 4,
                         box.padding   = 0.5,
                         point.padding = 0.5,
                         force         = 100,
                         segment.size  = 0.2,
                         segment.color = "grey50",
                         direction     = "x") +
        scale_x_continuous(expand = expansion(mult = c(0.2, .2))) +
        scale_y_continuous(expand = expansion(mult = c(0.1, .1))) +
        theme_classic(base_size = 16)
```




#### Shared resources and topics discussed

* Using Cloudstor's SWAN: [documentation](https://support.aarnet.edu.au/hc/en-us/articles/360000575395-What-is-CloudStor-SWAN-)
* Export tables to DOC or DOCX:
    * Svet tried to use [arsenal's write2word() function](https://mayoverse.github.io/arsenal/reference/write2specific.html), but didn't work... inside a R Markdown chunk! Had to run it outside, possibly because the function itself uses knitr...
    * Richard suggested using [stargazer](https://cran.r-project.org/web/packages/stargazer/index.html)
    * [gt](https://gt.rstudio.com) is a powerful package for customised tables, and can export to RTF, and its website has a useful [list of R packages for creating tables](https://gt.rstudio.com/#how-gt-fits-in-with-other-packages-that-generate-display-tables).
* [forcats](https://forcats.tidyverse.org/index.html) has been used twice during the session, once for changing the order of the levels to something arbitrary with `forcats::fct_relevel()`, and once for ordering them by value (with `dplyr::arrange()` followed by `forcats::fct_inorder()`)
* Sustainable transport planning with [stplanr](https://docs.ropensci.org/stplanr/)
* [lidR](https://cran.r-project.org/web/packages/lidR/news/news.html) moves away from sp/raster and uses sf/terra/stars instead
* [gghighlight](https://cran.r-project.org/web/packages/gghighlight/vignettes/gghighlight.html) was suggested to easily highlight (an label) cases on ggplot2 visualisations

### 2021-11-15: UQRUG 22

#### Attendees

* **Catherine**: Biology/Library, publish data for a paper 
* **Grechel**: PhD candidate/ PACE temporal trend analysis
* **Siu**: Bachelor of Biomedical Science
* **Einat**: PhD candidate / Civil Engineering School 

#### Code snippets

Example of for loop vs map() function from purrr package.

```r
# for loop to calculate the median of every column in mtcars
output <- vector("double", ncol(mtcars))
for (i in seq_along(mtcars)) {
   output[[i]] <- median(mtcars[[i]])
}
output # see the output

# same as above using a map() function
map_dbl(mtcars, median)
```
#### Shared resources

* See Stéphane's [tidyverse lesson](https://gitlab.com/stragu/DSH/-/blob/master/R/tidyverse_next_steps/tidyverse_next_steps.md) for more on purrr
* [ResBazQLD 2021](https://resbaz.github.io/resbaz2021/brisbane/) running 24-26th of Nov at UQ. Regsitration is $25.

### 2021-10-18: UQRUG 21

#### Attendees

* Stéphane
* Aklilu
* Uttara

### 2021-09-21: UQRUG 20

#### Participants: 14

* **Stéphane** (Library): thinking a lot about an "OpenStreetMap Recipes" package...
* **Catherine**: Library/Postdoc Biology, code/data into a repository for a paper
* **Shaoyang**: QAAFI PhD student.  Wine sensory/consumer science.  Data modelling.  Multivariate statistics.  Multi-block data.
* **Evan**: PhD Student, Developmental Neuroscience. Interested in moving from disorganised scripts to organised modules and packages.
* **Fathin**: PhD Student, SAFS. Looking to extract raster and use it to create model.
* **Huiyang**: PhD student, Faculty of Medicine, Diamantina Institute, Immunology. Would like to learn something about bioinformatics and data science related to R.
* **Muhammad Abdullah** PhD Student,QAAFI, I want to learn bioinformatics and data science releated R.
* **Luzia Bukali**: PhD Student, QIMR, Infection and Immunology. Relatively new to R. Looking to learn more about data analysis and creating figures in R.
* **Xiongzhi Wang**: PhD student, School of Communication and Arts. I want to learn and refresh knowledge of using R.
* **Muhammad Yahya**: PhD candidate at QAAFI. 
* **Gazi**: Masters's student, School of Economics. I just started learning R.
* ... **and 3 more UQRUGers**!

#### Shared resources

* Resources here!
* *R packages* book by Jenny Bryan and Hadley Wickham: https://r-pkgs.org/
* The Library's R packaging course: https://gitlab.com/stragu/DSH/-/blob/master/R/packaging/packaging.md
* usethis package to set up R packages: https://usethis.r-lib.org/
    * usethis for R packages kbroman: https://kbroman.org/AdvData/18_rpack_demo.html
* unit testing with the testthat package: https://testthat.r-lib.org/ 
* Input-output analysis:
    * iotables package: https://iotables.ceemid.eu/
    * ioanalysis package: https://cran.r-project.org/web/packages/ioanalysis/
* Exercism online coding practice! https://exercism.org/
* working with netcdf files for CMIP6 data: https://www.researchgate.net/publication/337991369_User-Friendly_R-Code_for_Data_Extraction_from_CMIP6_outputs; https://ui.adsabs.harvard.edu/abs/2019AGUFMPA33C1098K/abstract
* tax_name function for taxonomic, genetic data (from taxize package): https://cran.r-project.org/web/packages/taxize/taxize.pdf
* 
### 2021-08-16: UQRUG 19

#### Participants

* **Stéphane Guillou** (Library): just here to help!
* **Catherine Kim** (Library/Biology): working on publishing code with a paper
* **Jordan Pennells** (ANOVA structure)
* **Violeta Berdejo-Espinola** (make my code more efficient)
* **Omkar Ravindranatha Katagi** (Here to learn R)
* ... and 8 more UQRUGers!

#### Shared resources

Links we talked about today:

* Great books / resources to get started:
    * ***R for Data Science*** (aka "R4DS"): https://r4ds.had.co.nz/
        * [Slack community of R4DS](https://rfordatascience.slack.com/join/shared_invite/zt-n46lijeb-2RRzQ70U34eH530~PyZsmg#/shared-invite/email)
        * On Twitter: https://twitter.com/R4DScommunity
    * **R Cookbook**: https://www.cookbook-r.com/
    * **RStudio Education**: https://education.rstudio.com and https://education.rstudio.com/learn/
    * **learnr** package (also integrated in the RStudio "tutorial" tab): https://rstudio.github.io/learnr/
    * **article on linked points between boxplots**: https://datavizpyr.com/how-to-connect-data-points-on-boxplot-with-lines/

#### Code snippets

Change the order of categorical variable levels (so ggplot2 uses that order instead of the alphabetical order):

```r
library(dplyr)
library(ggplot2)
                          
# relevel factors using forcats package
library(forcats)
f <-  factor(c("a", "b", "c", "d"), levels = c("b", "c", "d", "a"))
fct_relevel(f, "a", "c", "d", "b")

# relevel eye_color of starwars data

starwars %>% 
   mutate(eye_color = fct_relevel(eye_color, "yellow")) %>% 
   ggplot(aes(x = eye_color)) +
   geom_bar()
```

Use case_when to rate or recode data:

```r
library(dplyr)

starwars
range(starwars$height, na.rm = TRUE)

# just based on height
starwars_rated <-  starwars %>% 
   mutate(height_rating = case_when(height < 70 ~ "very small",
                                    height < 140 ~ "quite small",
                                    height < 200 ~ "medium",
                                    TRUE ~ "tall"))                                       
                                    
# recode based on multiple conditions
range(starwars$mass, na.rm = TRUE) # check range of mass, second vairable to recode by

starwars_rated <-  starwars %>% 
   mutate(height_rating = case_when((height < 70) & (mass < 700)~ "very small and light",
                                    height < 140 ~ "quite small",
                                    height < 200 ~ "medium",
                                    TRUE ~ "tall"))
          
```

### 2021-07-19: UQRUG 18
Technical difficulties! No notes.

### 2021-06-21: UQRUG 17

#### Participants

* **Stéphane Guillou** (Library): just here to share help!
* **Catherine Kim** (Library/Biology): playing around spatial and open datasets from this [World's Oceans Day R-blogger post](https://www.r-bloggers.com/2021/06/celebrating-world-ocean-day-ropensci-style/)
* ... and 8 more UQRUGers!

#### Shared resources

* World Ocean Day post: https://www.r-bloggers.com/2021/06/celebrating-world-ocean-day-ropensci-style/
* performance package, `check_model()` function to check model assumptions: https://rdrr.io/cran/performance/man/check_model.html
* Create custom ggplot2 themes: https://rpubs.com/mclaire19/ggplot2-custom-themes
* Regular expression + stringr cheatsheet: http://edrub.in/CheatSheets/cheatSheetStringr.pdf
    * Read more about regexes: https://en.wikipedia.org/wiki/Regular_expression
* stargazer package for nice tables:
    * On CRAN: https://cran.r-project.org/web/packages/stargazer/index.html
    * Manual: https://cran.r-project.org/web/packages/stargazer/stargazer.pdf
    * warning: takes dataframes(!), not tibbles! (Might silently fail)
* The sf package now uses a spherical geometry by default: https://r-spatial.github.io/sf/articles/sf7.html

#### Tips for newcomers

* Projects for everything! Using R Projects allows you to keep separate projects... separate! And find files easily. Start organised to stay organised.
* *R 4 Data Science* book: https://r4ds.had.co.nz/


#### Code snippets

##### Export to CSV

```r
# export with write.csv()
write.csv(ToothGrowth,
          file = "exports/tooth_growth.csv",
          row.names = FALSE, # remove rowname column
          na = "") # empty cell instead of "NA"
```

##### Missing data handling in `dplyr::filter()`

```r
# insert missing data:
ToothGrowth[27,3] <- NA
library(dplyr)
# dplyr filtering:
filtered_dplyr <- filter(ToothGrowth, dose > 0.5)
    # dplyr filter gets rid of rows returning NA
# base indexing:
filtered_base <- ToothGrowth[ToothGrowth$dose > 0.5, ]
    # base subsetting with [] keeps rows returning NA
# check documentation:
?dplyr::filter
```

> "[In `dplyr::filter`], note that when a condition evaluates to NA the row will be dropped, unlike base subsetting with `[`."

##### New `alt` argument in ggplot2

Great news for accessibility in the new ggplot2 version 3.3.4: https://cloud.r-project.org/web/packages/ggplot2/news/news.html

For example:

```r
library(ggplot2)
ggplot(ToothGrowth, aes(x = supp, y = len)) +
  geom_boxplot() +
  labs(alt = "Boxplot of tooth growth rate with different supplements.\n
       The length is generally higher with the OJ supplement.")
```

This will allow tools that create documents that include ggplot2 visualisations to make use of the alternative text, for screen readers for example.

Know that R Markdown has the chunk option `fig.alt` for that purpose as well.

### 2021-05-31: UQRUG 16

#### Participants

* **Catherine Kim** (Library/Biology): using the R package boral for multivariate data ...
* **Stéphane Guillou** (Library): playing with APIs, trying the MusicBrainz one at the moment to build a Shiny app...?
* **David Green** (UQ RCC) helping HPC users to get R code running on the HPC ...
*  ** Roman Scheurer (UQ QCMHR): Interested in using RStudio for large population-level and time series data, applying geographic information systems to identify patterns of health utilisation
*  ... and a few more!


#### TidyTuesday datasets

See if you find an interesting dataset to play with: https://github.com/rfordatascience/tidytuesday#datasets

Share code and pictures here!

#### Shared resources

* R-Ladies Brisbane has a YouTube channel! First video is a presentation by Julie Vercelloni: https://www.youtube.com/watch?v=L_8e2xuyttI
* R 4.1 and RStudio: https://community.rstudio.com/t/psa-r-4-1-0-release-requires-rstudio-preview/105209
    * What's new in R 4.1: https://cran.r-project.org/doc/manuals/r-release/NEWS.html
    * If you need the preview version to fix the graphics issues: https://www.rstudio.com/products/rstudio/download/preview/
* useR 2021 conference: https://user2021.r-project.org/participation/registration/
* Share code on GitHub: https://github.com/
* Import LAS dataset with lidR package: https://jean-romain.github.io/lidRbook/
* `after_stat()` function in ggplot2: https://www.tidyverse.org/blog/2020/03/ggplot2-3-3-0/#more-control-over-aesthetic-evaluation

### 2021-04-19: UQRUG 15

#### Participants

* **Stéphane Guillou** (Library): I'd like start working on a package to query the MusicBrainz API
* **Catherine Kim** (Library/Biology): Write a function to automate coral reef image download from US NOAA database CoRIS.  Cleaning up code for sharing.
* **Rene Erhardt** (Pharmacy): beginner, just listening...
* **Andy Cui** (Engineering): First time attendance with aim of reshaping spectral data for visualisation purposes
* **Rhiannon Jeans** (Neuroscience): First time attending the meeting but not new to R. Looking to help others or learn from others. 
* ...
#### TidyTuesday datasets

See if you find an interesting dataset to play with: https://github.com/rfordatascience/tidytuesday#datasets

Share code and pictures here!

#### Shared resources

* R Markdown news: https://blog.rstudio.com/2021/04/15/2021-spring-rmd-news/
* reshape2 tutorial: https://www.datacamp.com/community/tutorials/long-wide-data-R
* Tidyverse information: https://www.tidyverse.org/
* ggplot2 visualisation wizardry: https://www.cedricscherer.com/slides/useR2021.pdf
* pipe operator:
    * first introduced by magrittr: https://github.com/tidyverse/magrittr
    * but coming to R base: https://cran.r-project.org/doc/manuals/r-devel/NEWS.html
* R Markdown gallery: https://rmarkdown.rstudio.com/gallery.html
* Tables
    * flextable: https://davidgohel.github.io/flextable/
    * officer: https://davidgohel.github.io/officer/
    * frequency (for tables similar to SPSS' `FREQUENCIES`): https://github.com/wilcoxa/frequency

For example, try this:

```r
library(dplyr)
library(frequency)
options(frequency_open_output = TRUE)
mtcars %>% 
  select(carb, cyl) %>% 
  freq()
```

### 2021-03-15: UQRUG 14

#### Participants

* **Stéphane Guillou** (Library): ...
* **Paula Andrea Martinez** (ReSA): are you interested in a Markdown workshop? two hours on the 24th of March by [NeSI](https://www.eventbrite.co.nz/e/rmarkdown-for-researchers-weave-together-narrative-text-and-code-registration-144069029345)
* **Fathin Azizan** (HDR SAFS): Need help to check on coding for the multiple linear regression using raster data.
* **Robyn**
* **Phoebe**: Hi everyone!
* **Tmnit**
* **Violeta**
* **Patrick**
* **Aljay**

#### This week's TidyTuesday dataset

[Bechdel Test](https://en.wikipedia.org/wiki/Bechdel_test) dataset: https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-09/readme.md

Get the data and play with it:

```r
raw_bechdel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')
movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv')
```

Share code and pictures here!

#### Shared resources

* Intro slides by Grant McDermott: https://raw.githack.com/uo-ec607/lectures/master/04-rlang/04-rlang.html#1
* mapsf is the successor to cartography: https://rgeomatic.hypotheses.org/2212
* Open Science Foundation: https://osf.io/
* OpenStreetMap data:
    * Geofabrik to get bulk OpenStreetMap downloads: http://download.geofabrik.de/
    * osmextract package: https://cran.r-project.org/web/packages/osmextract/index.html
    * osmdata package: https://docs.ropensci.org/osmdata/


### 2021-02-15: UQRUG 13

#### Participants

* **Stéphane Guillou** (Library): just happy to help and share resources! Looking for a quick way to do adress lookups.
*  **Paula Andrea Martinez** (co-organiser/ helper) Happy to share new ways of doing things. looking to plot answers from mentimeter.
* David
* Einat
* Alphabet
* Patrick

#### Shared resources

* Tidytext interactive course: https://juliasilge.com/blog/learn-tidytext-learnr/
* Pattern-based analysis with motif: https://nowosad.github.io/motif/
* ROpenSci Newsletter: https://news.ropensci.org/
* R Markdown:
    * Slides: https://slides.djnavarro.net/starting-rmarkdown
    * Training at UQ: search for "Reproducible Reports"
    * QCIF training: https://www.qcif.edu.au/training/training-courses/
    * Carpentries chapter on R Markdown: https://swcarpentry.github.io/r-novice-gapminder/15-knitr-markdown/index.html
* New Shiny version with easier theming: https://blog.rstudio.com/2021/02/01/shiny-1-6-0/

### 2021-01-25: UQRUG 12

**This is our first anniversary! UQRUG has one year!!**

#### Attendees and questions

* **Paula Martinez** I'm a keen R user, I also founded R Ladies Brisbane and you are welcome to join https://www.meetup.com/rladies-brisbane/
* **Kathy**: Phd SSI, wants to learn more R
* **David Green**: RCC, hacky hour
* **Stéphane Guillou** (Library): keen to start UQRUG again for 2021! 
* **Phoebe**: Just hanging to learn something :)
* **Isabel** (IMB), microbiologist, here to meet other R folks and learn :) 

#### Naming things

Paula presented these very useful slides by [Jenny Bryan](https://jennybryan.org/) about how to name files and directory for profit!

* Link to the slides: https://speakerdeck.com/jennybc/how-to-name-files
* Steph couldn't remember what that padding function was, but discovered stringr has a great one, `str_pad()`: https://www.rdocumentation.org/packages/stringr/versions/1.4.0/topics/str_pad

For example, try this:

```r
stringr::str_pad(c(0, 14, 178), width = 3, pad = 0)
```

#### This week's TidyTuesday

Have fun with this week's [TidyTuesday](https://github.com/rfordatascience/tidytuesday): the rKenyaCensus dataset.

```r
# Get the Data manually

gender <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/gender.csv')
crops <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/crops.csv')
households <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/households.csv')
```

#### Resources shared

* RStudio Global conference was last week. Recordings will be available on the [RStudio website](https://blog.rstudio.com/) soon.
    * Stéphane really recommends the presentation: _How to do things with words: learning to program in R with a "communicative approach"_, by [Riva Quiroga](https://rivaquiroga.cl/)
* Main R terms for beginners: https://gitlab.com/stragu/DSH/-/blob/master/R/terminology.md
    * Don't hesitate to send Steph some feedback!
* Converting Windows style to Unix:
https://support.nesi.org.nz/hc/en-gb/articles/218032857-Converting-from-Windows-style-to-UNIX-style-line-endings
* Notepad++, useful (open source) text editor which has an option to change file endings: https://notepad-plus-plus.org/
* `theme_publish()`, a ggplot2 theme provided by the package envalysis: https://rdrr.io/github/zsteinmetz/envalysis/man/theme_publish.html
* https://rstudio.com/resources/webinars/ to watch the presentations from the last RStudio conferences
* Visual Markdown editor in the new RStudio 1.4: https://blog.rstudio.com/2020/09/30/rstudio-v1-4-preview-visual-markdown-editing/
* Bar plots guide: https://michaeltoth.me/detailed-guide-to-the-bar-chart-in-r-with-ggplot.html
* Two-way anova: http://www.sthda.com/english/wiki/two-way-anova-test-in-r
* Other packages built on top of ggplot2: https://exts.ggplot2.tidyverse.org/gallery/


#### Phoebe's faceted visualisation

Phoebe needed to reshape her dataset to then visualise it in separate facets.

```r
 CBMI %>% 
        select(Gender, contains("BMI")) %>% 
        pivot_longer(contains("BMI"), names_to="Year", values_to="BMI") %>% 
        mutate(Year=fct_inorder(Year)) %>% 
        ggplot(aes(x=Gender, y=BMI)) + 
        geom_boxplot() +
        facet_grid(cols=vars(Year)) +
        theme_pubr()
```

#### Recommendations for Katherine's bar chart

```r
library(ggplot2)

# useful geometries:
geom_bar() # height of a bar is a count
geom_col() # if you already have the value for the height of the bar

# to have bars side by side, change the position to "dodge"
# (instead of the default "stack"), for example:
ggplot(mpg, aes(x = as.character(cyl), fill = class)) +
  geom_bar(position = "dodge")

# for adding error bars
geom_errorbar()
# you have to provide the values for the size of the bars (xmin, xmax)
# and their position (x, y)
```

You might find that an extra package to add on top of ggplot2 will do the hard work for you. Many are listed here: https://exts.ggplot2.tidyverse.org/gallery/

More resources:
* Bar plots guide: https://michaeltoth.me/detailed-guide-to-the-bar-chart-in-r-with-ggplot.html
* Two way anova: http://www.sthda.com/english/wiki/two-way-anova-test-in-r

### 2020-11-16: UQRUG 11 (cancelled)

### 2020-10-19: UQRUG 10

#### Attendees and problems

Please add your name and the problem you'd like some help with!

* **Stéphane** (Library): here to help! 
* **Chantelle**: Biological Sciences. I can't stay to long as I have to go track carpet pythons at 4pm ;)
* **Einat** (Social Sciences, R studio beginner): Apologies in advance would have to leave early. have some issues wiTh minor and basic procedures, like ...CONDITIONS!! and also with reading labels from csv/excel file. 
* **Patrick** (Agricultural Science) Honours student
* **Gabriel**: Hydrologist, spatial data analyst. PhD candidate at SMI. R beginner and Python enthusiast !
* **Natalie** (Mathematics): Undergraduate Mathematics and Statistics student
* **Phoebe**: learn more about data viz!
* ... and few more!

#### Today's challenge

Try playing with the latest TidyTuesday dataset: https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-10-13/readme.md

Share your findings and cool visualisations with the group!

#### Recoding data

This is a working example of recoding using dplyr's `case_when()`:

```r
library(dplyr)
CO2 %>% 
  mutate(uptake = case_when(
    uptake > 12 ~ "yay!",
    uptake > 10 ~ "OK.",
    TRUE ~ "oh no..."
  ))
```

The `TRUE` line is for "everything else".

#### Finding files

The "working directory" is the default location:

```r
getwd() # know where you are
setwd("path/to/correct/location") # change it

# functions will look there by default
read.csv("filename.csv")
# but you can use longer, absolute filepaths
read.csv("C:/Users/myname/filename.csv")
```

If you don't want to deal with that: **use R Projects**! Creating an R Project will set the working directory for you.

#### Dealing with overflowing labels

```r
library(ggplot2)
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

# horizontal bar chart
ggplot(diamonds, aes(y = cut)) +
  geom_bar()

# abbreviate the labels
abbreviate(diamonds$cut)

# using it in the visualisation is nice and concise
ggplot(diamonds, aes(x = cut)) +
  geom_bar() +
  scale_x_discrete(labels = abbreviate)
```

On the other hand, if labels are overflowing inside the canvas, we can expand axis limits:

```r
# expand limits
ggplot(diamonds, aes(x = cut)) +
  geom_bar() +
  ylim(c(0, 25000))
```

However, ggplot2 should expand the plot area to include all the geometries automatically, including a `geom_label()` or `geom_text()`.

#### Shared resources

Resources shared during the meetup can be listed here:

* Packages:
    * epiDisplay: https://rdrr.io/cran/epiDisplay/
    * lme4: https://www.rdocumentation.org/packages/lme4/versions/1.1-23/topics/lme4-package
    * Seurat: https://cran.r-project.org/web/packages/Seurat/index.html
    * reshape2: https://cran.r-project.org/web/packages/reshape2/index.html
* Functions:
    * `case_when()` to recode a variable: https://dplyr.tidyverse.org/reference/case_when.html
* Data viz:
    * ggplot2 extensions: https://exts.ggplot2.tidyverse.org/gallery/
    * Data to Viz: https://www.data-to-viz.com/
    * lattice: https://www.rdocumentation.org/packages/lattice/versions/0.20-41


### 2020-09-21: UQRUG 9

#### Attendees and problems

Please add your name and the problem you'd like some help with!

* **Stéphane** (Library): here to help! But challenged by using an API and turning the XML output into a dataframe...
* **Dwan** (CHRC): Enjoying my first day, and learning what the group is about
* Grace
* Amelia
* Mitch

#### Today's challenge

Try playing with the latest TidyTuesday dataset: https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-09-15/readme.md

Share your findings and cool visualisations with the group!

#### Shared resources

Resources shared during the meetup can be listed here

* Base R gems: https://ihaddadenfodil.com/post/r-base-gems/#
* ggplot2 extensions: https://exts.ggplot2.tidyverse.org/gallery/
* Mitch is using the lidR package:
    * Documentation: https://www.rdocumentation.org/packages/lidR/versions/3.0.3
    * Book: https://jean-romain.github.io/lidRbook/index.html
* the ggfortify package proved useful for PCA visualisation: https://cran.r-project.org/web/packages/ggfortify/vignettes/plot_pca.html

### 2020-08-17: UQRUG 8

#### Attendees and problems

Please add your name and the problem you'd like some help with!

* **Stéphane** (Library): no specific problem, here to help! :)
* **Dhananjeyan**: New to R, Trying to learn more
* **Phoebe**: Hi everybody, I started learning R last week (self-directed). I have problems using the right code for missing data and doing linear regression with categorical data. I am happy to learn other things as well!
* **Fathin** (SAFS): Problem yet to come, haha. I am going to add moving average on my boxplot. Don't know how can I do that.
* **Patrick** ($SAFS$): I got a problem of GLM(). Plotting mutiple model over a time period. 
* **Elspeth** Hi, I just started learning R last week as well. Just here to learn generally, no specific problem :)
* **Paula** CAI. I want to show you between and near for filters, using tidyverse
* **Evan** (QBI) Been using R for stats for about 3 years, will be doing some bioinformatics for PhD, and joining in to meet other people also using R (no specific problem - yet)
* **Jemima** Want to understand some warning messages in my CLMM analyses

#### Shared resources

* Jemima's CLMM and stats questions:
    * Patrick: "My biometrician recommended AIC the lower the better"
    * Evan: "this guide to fitting clmm that mght be helpful as well": https://cran.r-project.org/web/packages/ordinal/vignettes/clmm2_tutorial.pdf 
    * Paula: https://www.scribbr.com/statistics/akaike-information-criterion/#:~:text=The%20AIC%20function%20is%202K,it%20is%20being%20compared%20to 
    * Fathin recommends this QCIF course: _Exploring and Predicting using Linear Regression in R_ -- https://www.qcif.edu.au/trainingcourses/exploring-and-predicting-using-linear-regression/ 
    * Stéphane: the first warning you saw is related to recent R changes (in R 4.0) and it will be fixed in a future version of ordinal: https://github.com/runehaubo/ordinal/issues/34
* Patrick's plotting of multiple models over time:
    * Paula: http://www.sthda.com/english/articles/32-r-graphics-essentials/128-plot-time-series-data-using-ggplot/ 
* Cheatsheets: https://rstudio.com/resources/cheatsheets/
* Join R-Ladies!
    * Brisbane: https://www.meetup.com/rladies-brisbane/
        * on Twitter: https://twitter.com/RLadiesBrisbane/
    * Global: https://rladies.org/

### 2020-07-27: UQRUG 7

On Zoom, 3-5 pm: https://uqz.zoom.us/j/91844551770

#### Attendees and problems

* **Stéphane** (Library): anyone with experience with Tidyverse + quosure / quasiquotation? I want to use strings in one column as object names in a function.
* **Ruth** (HMNS): I don't have any specific issues this week. I am happy to listen and explore new packages.
* **Chantelle Derez** (Biological Science): I don't have any specific issues, just popping in to learn. Current favourite package is Thermimage and colour palette 'rainbow' for analysing thermal images. :rainbow: 
* **Paula Andrea M** (CAI) I'm here to help. Also I would like to invite you to the Rladies Brisbane events. https://www.meetup.com/rladies-brisbane/events/272075776 The topic of next month is R in Biology. 
* **Fathin** (SAFS) No issue to date. 
* **Damber** (I want to learn plotting glmm prediction) - shared on chat.uq.edu as well.
* **Candice**: RNAseq in R.
    * Found resources:
    * https://osca.bioconductor.org
    * https://bioconductor.riken.jp/packages/3.8/workflows/html/simpleSingleCell.html 
* **Greg** (Chemical Engineering) Late but here to help. Currently grappling with some nasty XML at the moment that I want to parse efficiently.  Writing my PhD thesis in RMarkdown.

#### Favourite packages

* tmap: https://mtennekes.github.io/tmap/
* stylr: https://github.com/r-lib/styler
* raster: https://rspatial.org/raster/pkg/index.html
* ggplot2: https://ggplot2.tidyverse.org/
    * ggpubr: https://rpkgs.datanovia.com/ggpubr/index.html
* Thermimage: https://cran.r-project.org/web/packages/Thermimage/index.html
* GGIR: https://cran.r-project.org/web/packages/GGIR/index.html

#### From today's questions
* Reading XML data into R
    * https://subscription.packtpub.com/book/big_data_and_business_intelligence/9781783989065/1/ch01lvl1sec11/reading-xml-data
    * https://stackoverflow.com/questions/40977885/extracting-nodes-by-name
    * Greg also this code worked well for missing nodes, but not for reapeated names. Have a try
```
library(XML)
library(methods)

xmldata <- xmlToDataFrame("data/plant_catalog_incomplete.xml")
View(xmldata)
```
* For Single cell analysis
    * https://osca.bioconductor.org/introduction.html
    * https://bioconductor.riken.jp/packages/3.8/workflows/html/simpleSingleCell.html
* For plotting gml data 
    * merTools https://rdrr.io/cran/merTools/man/plotREsim.html
    * https://easystats.github.io/see/articles/performance.html
* SAS to R migration
    * https://www.r-bloggers.com/sas-to-r-migration/
    * https://github.com/asnr/sas-to-r

### 2020-06-15: UQRUG 6

Anything you'd like to talk about? A problem? Resources? Feel free to add it here!

* **Stéphane Guillou** (Library): I will maintain the package [rinat](https://github.com/ropensci/rinat) from now on. If you have time, I'd love *you* to test it and report issues!
* **Ismail Garba** (SAFS): PhD researcher working on modeling covercropping in drylands for improved agronomic and environmental outcomes under current and future climates. I'm interested in using R to run APSIM model for multi-factor long term simulations.
* **Ruth Brady** (HMNS): PhD researcher working with accelerometers to measure physical activity patterns of adults. The package I am most interested in, is GGIR and creating a code that runs. I have basic R and GGIR knowledge but constantly run into problems I am unsure how to correct them. 
* **Chantelle Derez** (Biological Sciences): PhD researcher loving and hating making maps. I have an error relating to JAVA that would be great to get some help on. 
* **Adriana Vega** (SAFS) PhD studying tropical tree water use. Currently trying to use dendrometer (tree stem radius variations) data to separate "growth" from "water deficit". Hoping to get some advice on how to run a line through time series to separate these two components.
* **Clarisse Louvard**(SBS):PhD candidate studying parasites. First time at UQRUG. Currently searching for a way to do Principal Component Analyses with imputed datasets obtained with R package MICE.
* **Paula Andrea Martinez** I work for the National Imaging Facility, happy to help people with data organisation, data cleaning and munging. I'm also quite interested in web scrapping and APIs. I've worked with Bioconductor packages for some years too.
*  **Fathin Azizan** PhD student studying rubber phenological metrics using remote sensing data. Currently using R for extracting and analysing raster data.
* **Greg Siemon** PhD Candidate working on optimisation of energy use within a steelworks. I have done most of my PhD work in R and I am going to be writing my Thesis using RMarkdown (See unofficial RMarkdown Thesis template below). At the moment I'm trying to parse some messy XML formatted output from some optimisation software. If anyone is familiar with the XML2 package I'd be interested to have a chat.
* **Patrick Di** (*SAFS*) Undergraduate Honours student who is studying R for genetics and GIS. Data management and plotting nice figures. :1234: 

### 2020-05-18: UQRUG 5

We are meeting online again!

Today, we talk about whatever issues you might have, as well as **reprex** and **R 4.0**.

#### Attendees

Feel free to share your contact, specialty and questions here.

* **Steph** (UQ Library), technology trainer, likes R and maps and Open Science.
    * Email (work): s.guillou@uq.edu.au ; Social (personal): [mastodon](https://mastodon.indie.host/@stragu/)
* **Paula** 
* I am wondering if some could help me to do **asymptotic regression model**. Thank you!
* **Ruth** - I have seen online a package called "revtools" for screening abstracts and titles of journals, would someone help me with the code (for future reference/projects)
* ... and **11 more R users**!


#### reprex

The **reprex** website introduces what the reprex package is useful for, i.e. creating **reproducible examples**: https://reprex.tidyverse.org/

Share your reprex example here!

Steph's:

``` r
# R 4.0 does not import strings as factors by default anymore!

# create a fake dataframe:
df <- data.frame(ID = LETTERS[1:10],
                 gender = sample(c("man", "woman", "enby", "other", "PNS"),
                                 10, replace = TRUE),
                 age = sample(1:100,
                              10, replace = TRUE))

# check class
class(df$gender)
#> [1] "character"

# summary() might be a bit less informative
summary(df)
#>       ID               gender               age       
#>  Length:10          Length:10          Min.   : 5.00  
#>  Class :character   Class :character   1st Qu.:18.00  
#>  Mode  :character   Mode  :character   Median :65.50  
#>                                        Mean   :56.00  
#>                                        3rd Qu.:91.75  
#>                                        Max.   :96.00
```

<sup>Created on 2020-05-18 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>

#### Topics discussed

* New in **R 4.0**:
    * Improved default colour palette: https://developer.r-project.org/Blog/public/2019/11/21/a-new-palette-for-r/index.html
    * New StringsAsFactors default value set to `FALSE`: https://developer.r-project.org/Blog/public/2020/02/16/stringsasfactors/index.html
    * Matrices inherit the "array" class
* **reprex** package for reproducible examples:
    * Official docs: https://reprex.tidyverse.org/
* **Shiny** tutorials:
    * Tutorial: https://shiny.rstudio.com/tutorial/
* Ruth was interested in **revtools**, which provides "tools for evidence synthesis":
    * Website: https://revtools.net
    * Function documentation: https://cran.r-project.org/web/packages/revtools/revtools.pdf
* Resources for **learning R**:
    * exercism: https://exercism.io
    * Upcoming 1.3 version of RStudio integrates [learnr](https://rstudio.github.io/learnr/) with a new "Tutorial" pane: https://rstudio.com/products/rstudio/download/preview-release-notes/
* Patrick was interested in **uavRst**: _Unmanned Aerial Vehicle Remote Sensing Toolbox_ (not on CRAN):
    * Website: https://gisma.github.io/uavRst/
    * It requires quite a few libraries!

Example code used during the meetup:

```r
# R 4.0 updates

# does not import strings as factors by default anymore!

# create a fake dataframe:
df <- data.frame(ID = LETTERS[1:15],
                 gender = sample(c("man", "woman", "enby", "fluid", "other", "PNS"),
                                 15, replace = TRUE),
                 age = sample(1:100, 15, replace = TRUE),
                 score = sample(10:300, 15, replace = TRUE))

# check class
class(df$gender)

typeof(as.factor(df$gender))


# summary() might be a bit less informative
summary(df)

# default palette
plot(df$age, df$score, col = as.factor(df$gender))
# see the values
palette()

# class inheritance
class(diag(1))

# warning when joining datasets with different factor levels
# create two datasets:
df1 <- data.frame(name =  c("blah", "bloh"),
                  height = c(123, 234),
                  stringsAsFactors = TRUE)
df2 <- data.frame(name =  c("blah", "blih"),
                  weight = c(456, 678),
                  stringsAsFactors = TRUE)

# dplyr warns when joining by a key that does not share
# the exact same levels between the two tables
library(dplyr)
joined <- left_join(df1, df2)
# see that it converted to characters for safety
str(joined)
# see that original levels differ
df1$name
df2$name

# revtools
library(revtools)
# show all available data objects
data()

?revtools

```

### 2020-04-20: UQRUG 4 - moving online!

Because of physical isolation, we will be meeting online for now.

Join the zoom meeting at 3 pm on Monday the 20th of April

#### Attendees

Please add your **name and a problem you'd like to work on**, or just something you'd like to chat about! Feel free to add links too, so others can have a look and contribute.

* [Steph](https://mastodon.indie.host/@stragu/) (Library) - putting together a resource for learning reproducible reports with R Markdown.
* **Greg** - working on my PhD thesis using RMarkdown (I have converted the UQ thesis template to RMarkdown). Also working on some data analysis which involves manipulating data contained in multiple files. Lots of dplyr code.  Note: R 4.0 coming this week. This is a major release and it involves reinstalling all of your packages. Be careful if you update and make sure you keep backups.
* **Patrick** - Honours student in agriculture using R to analyse biomass of lettuce and genetic variations of weed species. 
* **Aljay** - Working in  fruit/vegetable quality changes in supply chains and using R to predict changes in the chain.
* **Fathiyya** - Currently I am working in remote sensing field for group of crops classification using R
*  **Paula** - I'm here to help with questions.
*  **Amelia** - Hello! I am a basic learner of R. I will start plotting some graphs, and if I have some questions I will let you know.
*  **Debbie** - Postdoc at SEES using R for catchment restoration projects.
We can create breakout rooms in Zoom for people to help each other.

#### Topics discussed

* **R 4.0** released in a few days. Find out more:
    * https://developer.r-project.org/Blog/public/
    * https://cran.r-project.org/doc/manuals/r-devel/NEWS.html
* **dplyr** soon to hit 1.0 release, planned for around the end of May. Details about changes are on the Tidyverse blog, in a series of posts:
    * https://www.tidyverse.org/categories/package/
* **R Markdown UQ thesis template** by Greg: https://github.com/gsiemon/UQThesis
    * Manage citations https://ropensci.org/technotes/2020/05/07/rmd-citations/
* **Bookdown** for bigger, structured R Markdown documents: https://bookdown.org/
* **Tidying** data with Tidyverse functions
* **Iterating** over several vectors of values
    * useful examples:
        * https://github.com/jennybc/row-oriented-workflows/blob/master/ex06_runif-via-pmap.md
        * https://github.com/jennybc/row-oriented-workflows/blob/master/iterate-over-rows.md
        * https://serialmentor.com/blog/2016/6/13/reading-and-combining-many-tidy-data-files-in-R
        * https://gitlab.com/stragu/DSH/-/blob/master/R/packaging/packaging.md#read-a-single-file

The code we worked on:

```r
# construct dataframe containing relevant data
site_number <- c(1, 2) # there are 2 numbers for this variable (1 and 2)
year <- c(2001, 2002) # there are 2 years (2001, 2002) 
veg_index <- c("EVI", "EVI2") # there are 2 VegIndices (EVI, EVI2)
# put everything together
df <- data.frame(site_number, year, veg_index)

# find all combinations of values
library(tidyr)
expanded <- expand(df, site_number, year, veg_index)

# create a path from other variables
library(dplyr)
with_paths <- expanded %>% 
  mutate(path = paste0("beginning/", site_number, "_", year, "-", veg_index))

# encapsulate code into a function
do_stats <- function(df, numCores) {
  siteShp <- readRDS(df$path)
  calcPixelwiseStats(siteShp, Year = df$year, removeBadGrads = removeBadGrads, optionsYldIdx = setOptionsYldIdx(minevitrees = 999, ndaysbeforemax4yldidx = 60, ndaysaftermax4yldidx = 60, VegIndex = df$veg_index), numCores = numCores, getFromBricks = FALSE)
}

# apply the custom function on 1-row tibbles by splitting
library(purrr)
siteInfoAllYrs <- with_paths %>% 
  split(1:nrow(with_paths)) %>% # create sequence as long as number of rows
  map(do_stats, numCores = 4)
# we end up with a list of results

# Other option: with pmap, which will work row-wise
# (which is why we have to have the df variables in the right order)
do_stats2 <- function(site_number, year, veg_index, path, numCores) {
  siteShp <- readRDS(path)
  calcPixelwiseStats(siteShp, Year = year, removeBadGrads = removeBadGrads, optionsYldIdx = setOptionsYldIdx(minevitrees = 999, ndaysbeforemax4yldidx = 60, ndaysaftermax4yldidx = 60, VegIndex = veg_index), numCores = numCores, getFromBricks = FALSE)
}

# apply the function row-wise
siteInfoAllYrs <- pmap(with_paths, do_stats2, numCore = 4)

# small example of how pmap works row-wise:
x <- c(1, 10, 100)
y <- c(1, 2, 3)
z <- c(5, 50, 500)
examp <- data.frame(x, y, z)
pmap(examp, sum)
```

### 2020-03-23: UQRUG 3

_Canceled because of UQ recommendations related to COVID-19._

### 2020-02-24: UQRUG 2
- Learning R? jump here: https://rstudio.github.io/learnr/
- Tidyverse tricks? https://suzan.rbind.io/
- Greg Siemon, (unofficial) Rmarkdown UQ Thesis Template: https://github.com/gsiemon/UQThesis
- Reka is here: https://rekadata.site/ Lecturer in Quantitative Methods at the Department of Criminology at University of Manchester. Member of the Software Sustainability Institute and an Honorary Lecturer at University College London.
- Welcome everyone!

### 2020-01-20: UQRUG 1

Topics discussed:

* Installing R and RStudio
* Password-protected Shiny apps
* Referencing with BibTex in R Markdown
* Suppressing messages in custon functions
* Data processing with Tidyverse
* Sharing useful resources and available training
* Mention upcoming changes in R 4.0 

Useful Links

* How to create fake data sets: https://cran.r-project.org/web/packages/synthpop/vignettes/synthpop.pdf
* Econ R Resources: 
    - https://www.core-econ.org/doing-economics/book/text/0-3-contents.html
    - https://otexts.com/fpp2/
