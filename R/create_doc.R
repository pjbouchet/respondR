#' Copy the Microsoft Word template document
#'
#' @param rstudio Logical. Whether the function is being called from within RStudio. Defaults to TRUE.
#' @param destination Destination folder. If \code{rstudio = TRUE}, the file will be saved in the same directory as the current file. If \code{rstudio = TRUE} and \code{destination} is not specified, will default to the current working directory.
#' @param file.name Name of the output file. If not specified, will default to `response_template.docx`.
#' 
#' @return A LaTeX formatted string showing text differences when rendered.
#' @author Phil J. Bouchet
#' @export

create_doc <- function(rstudio = TRUE, destination = NULL, file.name = NULL){

  # Directory
  if (rstudio) {
    if (is.null(destination)) dir_path <- dirname(rstudioapi::getSourceEditorContext()$path) else dir_path <- destination
  } else {
    if (is.null(destination)) dir_path <- getwd() else dir_path <- destination
  }

  # File name
  if (is.null(file.name)) file.name <- "response_template.docx"
  if(!grepl(pattern = ".docx", x = file.name)) file.name <- paste0(file.name, ".docx")
  
  # Copy (and rename) file
  if(!file.exists(file.path(dir_path, file.name))) file.copy(from = system.file("inst/response_template.docx", package = "respondR"), to = file.path(dir_path, tolower(file.name)))

}