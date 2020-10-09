#' Download Microsoft Word template document
#'
#' @param rstudio Logical. Whether the function is being called from within RStudio Defaults to TRUE.
#' @param destination Destination folder. If \code{rstudio = TRUE}, the file will be saved in the same directory as the current file. Otherwise, defaults to the current working directory.
#' 
#' @return A LaTeX formatted string showing text differences when rendered.
#' @author Phil J. Bouchet
#' @export

initialise_template <- function(rstudio = TRUE, destination = NULL){
  
  if(rstudio){
    if(is.null(destination)) dir_path <- dirname(rstudioapi::getSourceEditorContext()$path) else dir_path <- destination
  }else{
    if(is.null(destination)) dir_path <- getwd() else dir_path <- destination
  }
  
  word_url <- "https://raw.github.com/sebastiansauer/Daten_Unterricht/master/Affairs.csv"
  word_file <- "Affairs.csv"
  
  if(!file.exists(file.path(dir_path, word_file))) utils::download.file(url = word_url, destfile = file.path(dir_path, word_file)) else cat("Template file already exists.")

}