#' Output formats for respondR template
#'
#' Each function is a wrapper for \code{\link[bookdown]{pdf_document2}} to
#' produce documents in a suitable style
#'
#' @param \dots Arguments passed to \code{\link[bookdown]{pdf_document2}}.
#' @return An R Markdown output format object.
#' @author Phil J. Bouchet
#' @export
#' @rdname response
#' @export

response <- function(...) {
  template <- system.file("rmarkdown/templates/response_doc/resources/response_doc.tex", package = "respondR")
  bookdown::pdf_document2(..., template = template)
}
