## RMarkdown template for responses to peer-review comments <img src="https://github.com/pjbouchet/respondR/blob/main/hex/respondR-hex.png?raw=true" class="logo" height="200" align="right"/>

This package provides an Rmarkdown template for writing clear, professional-looking and consistently formatted responses to peer-review comments on scientific papers.

### Rationale

Responding to comments on a manuscript is an essential yet sometimes daunting part of the peer-review process, particularly as clear and well-crafted responses are often tedious to formulate but can go a long way towards ensuring acceptance. `respondR` was designed to take away some of that strain by providing a user-friendly RMarkdown template that can produce professional-looking and consistently formatted response documents — encouraging authors to focus on content rather than style.

In particular, `respondR` conforms to best practice rules for academic peer-reviewing [Noble (2017)](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005730), and facilitates the tasks of:

-   Providing an overview of edits (Rule 1).
-   Making the response self-contained (Rule 3).
-   Using typography to assist reviewers and editors in navigating the response (Rule 6).
-   Clearly identifying the changes made to the submitted draft (Rule 9).

### Installation

The package and associated template can be installed using the following command:

``` r
# install.packages("remotes")
remotes::install_github("pjbouchet/respondR")
```

`respondR` is built around two core files:

-   A **Microsoft Word (.docx)** document housing the content of the response.
-   An **RMarkdown** document (and LaTeX backend) used for formatting.

The idea is to write up responses to reviewer comments in Word using the provided template, and subsequently generate a formatted PDF directly from within RStudio.

**After installation, follow these simple steps:**

-   **Step 1:** In RStudio, go to `File > New File > R Markdown > From Template` [Note: You may need to restart RStudio first].
-   **Step 2:** Select the `Response to Reviewers` template from the list and click `OK`. This will create an Rmd file, populated with a default template.
-   **Step 3:** Save the file to disk.
-   **Step 4:** Knit the document by going to `File > Knit` Document or clicking on the `Knit` icon in the top bar of the Rstudio editor and choosing `Knit to response`.
-   **Step 5:** Fill in the Microsoft Word table template (see the [vignette](https://pjbouchet.github.io/respondR/articles/respondR.html)).
-   **Step 6:** Knit the Rmd file.

**Final step:** Say "Abracadabra"!

Further details on how to use the template are given in the package [vignette](https://pjbouchet.github.io/respondR/articles/respondR.html).

### Comments and bug reports

Found a bug? Would like to see a feature? Please submit an issue or send a pull request to the [Github repository](https://github.com/pjbouchet/respondR/).

### Colophon

The template provided was inspired by the Monash University R Markdown templates available in package [MonashEBSTemplates](https://github.com/robjhyndman/MonashEBSTemplates/).
