## RMarkdown template for responses to peer-review comments <img src="https://github.com/pjbouchet/respondR/blob/main/hex/respondR-hex.png" height=200 align="right" class="logo"/>

This package provides an Rmarkdown template for writing clear, consistently formatted responses to peer-review comments.
 
### Rationale

Writing responses to peer-review comments can be a challenging and tedious process, especially as presentation and clarity are key to making 

### Installation

The package and associated template can be installed using the following command:

``` r
# install.packages("remotes")
remotes::install_github("pjbouchet/respondR")
```

After installation, follow these few steps:

(1) Restart RStudio [this only needs to be done once upon installation].
(2) Go to File > New File > R Markdown > From Template.
(3) Select the template from the list and click OK. This will create an Rmd file, populated with a default template.
(4) Save the file to disk.
(5) Use the `initialise_template()` function to download the Microsoft Word (.docx) template document. If the function is run within RStudio, the .docx will be saved in the same location as active file within the GUI. If not, the function will default to the current working directory. This behaviour can be overridden by specifying the path to a desired directory using the `destination` argument.

``` r
respondr::initialise_template()
respondr::initialise_template(destination = "~MyComputer/Documents/")
```

(6) Fill in the response template in Word (see details below).
(7) Knit the Rmd file.
(8) Say "Abracadabra!".

### How to use the Microsoft Word template

The template consists of several tables with example text.

Citations can be added using one's favourite reference management software (e.g., Endnote, Mendeley, Zotero, PaperPile), making sure that the bibliography is placed in the last table entitled "References".

### Colophon

The template provided was inspired by the Monash University R Markdown templates available in package [MonashEBSTemplates](https://github.com/robjhyndman/MonashEBSTemplates/).
