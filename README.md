# UQ Library Technology Training

The [UQ Library Technology Training website](https://uqlibrary.github.io/technology-training/) is where manuals and files used in our training sessions are published.

The website is built using [Quarto](https://quarto.org/) and uses the latest patches of R v4.5 and Python v3.12.

## Format of training sessions

Most sessions are designed to be hands-on.

All programming sessions use the "live-coding" format in which the instructor and the attendees type and execute commands together. A collaborative online pad (e.g. [Etherpad](https://github.com/ether/etherpad-lite/wiki/Sites-That-Run-Etherpad), [CryptPad](https://cryptpad.fr/code) and [HedgeDoc](https://demo.hedgedoc.org)) can be used to list useful links, challenges, and to interact during the session.

## Contributing

Contributions are welcome! You can [raise an issue](https://github.com/uqlibrary/technology-training/issues) or submit a change in this repository.

### Linked files

To keep this repository light, PDF manuals, PDF slides and other example files (e.g. DOCX, XLSX, video samples...) that are destined to be downloaded are usually kept in a separate "assets" repository.

1. Go to the appropriate folder [in the assets repository](https://github.com/uqlibrary/technology-training-assets)
2. Press "Add file" > "Upload files"
3. Choose the file, include an appropriate message (e.g. "Update Excel manual") and press "Commit changes"

To *update* a file, **make sure the file name and location are the same**. Otherwise, the website will have a broken link.

If you've used a new name, or are uploading a new file, you will also need to update the website by changing the URL in the corresponding `.qmd` file.

### Updating the website

Small changes can be made directly on GitHub, by editing files directly (if you have the rights), or submitting a pull request.

If you prefer to work on your local copy of the repository:

 1. Modify the corresponding Quarto (`.qmd`) file.
 2. Preview the website locally to see the changes:
 
 ```
 quarto preview <path/to/the_source.qmd>
 ```
 
 (Alternatively, click "Render" in the "Build" tab of RStudio, or "Preview" in Positron.)
 
 3. Once you are happy with the changes, commit and push them to this repository.

#### The `freeze: auto` setting

This website uses the [`freeze: auto`](https://quarto.org/docs/projects/code-execution.html#freeze) setting in the [_quarto.yml](_quarto.yml) file. This means that when the website is rendered, only the files that have been modified are re-rendered, whereas the others use the previously rendered files stored in the [_freeze](/_freeze/) directory. This helps with:

* reducing rendering times (for contributors as well as the GitHub workflow), and
* making sure pages don't break when using a system that is not capable of rendering the whole website (packages not installed, dependency on older versions...).

When rendering locally after a change (to a `.qmd` file containing code), the files in the [_freeze](/_freeze/) directory will likely change, so do commit those changes too - as long as your environment is set up properly (more on that in the next section).

#### Managing dependencies

We use [renv](https://rstudio.github.io/renv/index.html) for managing R dependencies and `requirements.txt` (with [venv](https://docs.python.org/3/library/venv.html)) for Python.

The benefits are:

* More consistency between systems that render
* More reproducibility, as we know which package versions were successfully used when rendering a page

If your contributions need new or updated packages, you'll need to update these dependencies.

Before you do, some things to consider:

* The website uses an Ubuntu runner. Some Python and R packages are specific to Windows/macOS, so please ensure that the packages you are updating are required for *Ubuntu*. (Ideally, you would make such changes on an Ubuntu machine / in WSL.)
* You will need to use virtual environments. Specifically, your clone of this repo should use Python/R environments that have the same dependencies (**and no more**) as specified in [renv.lock](renv.lock) (R) or [requirements.txt](requirements.txt) (Python). Once the clones are actually clones, you can then start to add new dependencies as required.
* Please ensure you only install what is necessary! There are too many dependencies already.

##### R environment with renv

The renv package use the `renv.lock` file to record package versions.

When working on R lessons:

* run `renv::restore(clean = TRUE)` before making changes to code in the R lessons, so your local package versions match what is currently used (and so unused packages are removed)
* run `renv::snapshot()` to update the `renv.lock` file if packages had to be updated or new packages had to be installed.

If a package dependency is not caught automatically by renv (for example, if a function depends on an optional package), you can manually add it to the [_dependencies.R](_dependencies.R) file.

Make sure to commit any changes to [renv.lock](renv.lock) and [_dependencies.R](_dependencies.R).

##### Python environment with `requirements.txt`

This repository also comes with a [requirements.txt](requirements.txt) file that keeps track of Python dependencies used during website rendering.

If your changes require new Python packages, be sure to include these in the [requirements.txt](requirements.txt) file.

To update the file, **use a virtual environment manager**. We recommend [venv](https://docs.python.org/3/library/venv.html). 

1. Make a clean Python environment in your local clone of the repo. **Do not check this into version control: ensure the folder is in [.gitignore](.gitignore).**
2. Install the packages in [requirements.txt](requirements.txt) (typically via `pip install -r requirements.txt`)
3. Install any other packages you require if you still need to (typically via `pip install ...`)
4. Update [requirements.txt](requirements.txt) (typically via `pip freeze > requirements.txt`).
5. Commit any changes to [requirements.txt](requirements.txt). Do not commit any venv-related files.

#### Captions and alternative text

For images that are not generated by code, you can use this syntax for caption and alternative text:

```markdown
![Caption goes here](picture.png){fig-alt="Alternative text goes here"}
```

If the image (a graph, for example) is generated by a code chunk, use the chunk options `fig-cap` and `fig-alt`:

``````markdown
```{language}
#| fig-cap: "Caption goes here"
#| fig-alt: "Alternative text goes here"
Executable code goes here
```
``````

Learn more about alt text:

* [alt text in Quarto](https://quarto.org/docs/authoring/figures.html#alt-text)
* [Wikipedia's guide on alt text](https://en.wikipedia.org/wiki/Help:Alt_text)
* [Wikipedia's example of alt text](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style/Accessibility/Alternative_text_for_images#Examples)
* Amy Cesal's article on [writing alt text for data visualisation](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)

## Automation

The [_processing](/_processing/) folder contains some scripts which run before and after render, and change depending on whether the render occurs locally or during CI (i.e. the GitHub workflow). Specifically:

### During local renders

* Preprocessing checks all links across the repo and records their status (OK, CHECK, BROKEN, EXEMPT, VALID on ...) in [ok_links.csv](_processing/ok_links.csv) and [check_links_log.csv](_processing/check_links_log.csv). Manually validated links can be updated in [validated_links.csv](_processing/validated_links.csv).
* Postprocessing does nothing.

### During workflow renders

* Preprocessing injects banners onto all `.qmd` files which are associated with upcoming, advertised training. This has the unfortunate consequence of requiring those files to re-render, regardless of the state in [_freeze](/_freeze/).
* Postprocessing removes banners from files. 

Note that all changes made during workflow renders occur on the runner, none of which are actually committed to the repo.

## Archive

The following sessions are not currently maintained.

| Title | Course notes |
|:-|:-:|
| Introduction to R for Humanities | [qmd](R/text_analysis/text_analysis.qmd) |
| R statistics: time series | [qmd](R/time_series/time_series.qmd) |

## Licence

Files in this repository (https://github.com/uqlibrary/technology-training) are freely available under the [Creative Commons - Attribution 4.0 International Licence](https://creativecommons.org/licenses/by/4.0/) ("CC BY") unless specified otherwise. You may re-use and re-mix the CC BY material in any way you wish, without asking permission, provided you cite the original source. However, we'd love to hear about what you do with it!

Part of this repository is based on [Paula Andrea Martinez](https://orcid.org/0000-0002-8990-1985)'s work [available under the same CC-By-4.0 licence](https://github.com/orchid00/CDS).

If you would like to develop on top of this, please cite the source as mentioned above, and conserve the git history if possible (so authors are credited).

## Contact

If you are part of the UQ community, you can contact the technology trainers for a 1-on-1 consultation, an enquiry about sessions, or any question about the software supported by the UQ Library: training<sub><[commercial at](https://en.wikipedia.org/wiki/At_sign)></sub>library.uq.edu.au
