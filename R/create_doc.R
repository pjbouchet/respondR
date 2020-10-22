#' Copy/find the Microsoft Word template document
#'
#' @param output.dir Destination folder. If \code{rstudio = TRUE}, the file will be saved in the same directory as the current file. If \code{rstudio = TRUE} and \code{destination} is not specified, will default to the current working directory.
#' @param file.name Name of the output file. If not specified, will default to `response_template.docx`.
#' @param rstudio Logical. Whether the function is being called from within RStudio. Defaults to TRUE.
#' @return A LaTeX formatted string showing text differences when rendered.
#' @author Phil J. Bouchet
#' @export

create_doc <- function(output.dir = NULL, file.name = NULL, rstudio = TRUE){
  
  # Directory
  if (rstudio) {
    if (is.null(output.dir)) dir_path <- dirname(rstudioapi::getSourceEditorContext()$path) else dir_path <- output.dir
  } else {
    if (is.null(output.dir)) dir_path <- getwd() else dir_path <- output.dir
  }

  # File name
  if (is.null(file.name)) file.name <- "response_template.docx"
  if(!grepl(pattern = ".docx", x = file.name)) file.name <- paste0(file.name, ".docx")
  
  # Full path
  filepath <- file.path(dir_path, file.name)
  
  # Make a copy of the template if necessary
  if(file.exists(filepath)){ cat("A file with this name already exists. Using version on disk.")
  } else { file.copy(from = system.file("inst/response_template.docx", package = "respondR"), 
              to = tolower(filepath), overwrite = FALSE)}

  return(filepath)
} 