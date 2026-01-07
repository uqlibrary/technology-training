# UQ Library technology training resources

Source code for the [UQ Library Technology Training website](https://uqlibrary.github.io/technology-training/), on which you can find the material (and links to files) for our technology training sessions. Go to the website for a convenient listing of resources.

The website is built using [Quarto](https://quarto.org/).

## Format of training sessions

Most sessions are designed to be hands-on.

All programming sessions use the "live-coding" format in which the instructor and the attendees type and execute commands together. A collaborative online pad (e.g. [Etherpad](https://github.com/ether/etherpad-lite/wiki/Sites-That-Run-Etherpad), [CryptPad](https://cryptpad.fr/code) and [HedgeDoc](https://demo.hedgedoc.org)) can be used to list useful links, challenges, and to interact during the session.

## Archive

The following sessions are not currently maintained.

| Title | Course notes | Live collaborative pad |
|:-|:-:|:-:|
| Introduction to R for Humanities | [md](intro_to_programming/intro_to_programming.md) <sup>[source](intro_to_programming/intro_to_programming.qmd)</sup> | [html](https://cryptpad.fr/code/#/2/code/edit/Op8PvBdGbBxBO9efXUuEYGlB/) |

## Licence

All of the information on this repository (https://github.com/uqlibrary/technology-training) is freely available under the [Creative Commons - Attribution 4.0 International Licence](https://creativecommons.org/licenses/by/4.0/). You may re-use and re-mix the material in any way you wish, without asking permission, provided you cite the original source. However, we'd love to hear about what you do with it!

Part of this repository is based on [Paula Andrea Martinez](https://orcid.org/0000-0002-8990-1985)'s work [available under the same CC-By-4.0 licence](https://github.com/orchid00/CDS).

If you would like to develop on top of this, please cite the source as mentioned above, and conserve the git history if possible (so authors are credited).

## Contributing

 You can [raise an issue](https://github.com/uqlibrary/technology-training/issues) or submit a change in this repository if you spot something that needs fixing.

 To modify lesson materials:
 
### Uploading binary files (e.g. `.pdf`, `.docx`, `.xlsx` etc.)

Binary files are usually kept in a separate "assets" repository.

1. Go to the appropriate folder [in the assets repository](https://github.com/uqlibrary/technology-training-assets)
2. Press "Add file" > "Upload files"
3. Choose the file, include an appropriate message (e.g. "Updated excel notes") and press "Commit changes"

To *update* a file, **make sure the file name and location are the same**. Otherwise, the website will still link to the old file.

If you've used a new name, or are uploading a new file, you will also need to update the website by changing the corresponding `.qmd` file's link.

### Updating the website

 1. Modify the corresponding Quarto (`qmd`) file.
 2. Preview the website locally to see the changes:
 
 ```
 quarto preview <path/to/the_source.qmd>
 ```
 
 (Alternatively, click "Render" in the "Build" tab of RStudio, or "Preview" in Positron.)
 
 3. Once you are happy with the changes, commit and push them to this repository.

If you have questions about contributing to the material, please contact the UQ Library.

#### The `freeze: auto` setting

This website uses the `[freeze: auto](https://quarto.org/docs/projects/code-execution.html#freeze)` setting in the `_quarto.yml` file. This means that when the website is rendered, only the files that have been modified are re-rendered, whereas the others use the previously rendered files stored in the `_freeze` directory. This helps with:

* reducing rendering times significantly (for contributors as well as the GitHub workflow), and
* making sure pages don't break when using a system that is not capable of rendering the whole website (packages not installed, dependency on older versions...).

When rendering locally after a change, the files in the `_freeze` directory will likely change, so make sure to commit those changes too.

#### {renv} for reproducibility

The {renv} package is used to keep track of what R package versions were used to run the chunks of code. This can have several benefits:

* More consistency between systems that render
* More reproducibility, as we know which package version were successfully used when rendering a page

However, this means that one should remember to:

* run `renv::restore(clean = TRUE)` before making changes to code in the R lessons, so your local package versions match what is currently used (and so unused packages are removed)
* run `renv::snapshot()` to update the `renv.lock` file if packages had to be updated or new packages had to be installed.

If a package dependency is not caught automatically by {renv} (for example, if a function depends on an optional package), you can manually add it to the `_dependencies.R` file.

Make sure to commit any changes to `renv.lock` and `_dependencies.R`.

#### Captions and alternative text for images

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

## Contact

If you are part of the UQ community, you can contact the technology trainers for a 1-on-1 consultation, an enquiry about sessions, or any question about the software supported by the UQ Library: training<sub><[commercial at](https://en.wikipedia.org/wiki/At_sign)></sub>library.uq.edu.au
