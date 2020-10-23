#' Flag differences between two text excerpts
#'
#' This function produces a LaTeX mark up that highlights text differences between two input sentences.
#'
#' @param sentence1 Original text 
#' @param sentence2 Revised text
#' @param highlight_diff Font type used to highlight text differences. Defaults to `underline`. Other options are `bold`, `italics`, and `standard`.
#' @param NA.string String defining characters recognised as "NA".
#'
#' @return A LaTeX formatted string showing text differences when rendered.
#' @author Phil J. Bouchet
#' @export
#'
#' @examples
#' 
#' library(respondR)
#' library(tidyverse)
#' 
#'compare_sentences(sentence1 = "My name is Patricia.", 
#'                  sentence2 = "My name is Stacey.", 
#'                  highlight_diff = "underline", 
#'                  NA.string = c("n/a", "na", "N/A", "NA"))
#'                 
#'compare_sentences(sentence1 = "The sky is blue and the grass is green.", 
#'                  sentence2 = "The ocean is blue and the apples are green!",
#'                  highlight_diff = "underline", 
#'                  NA.string = c("n/a", "na", "N/A", "NA", "Not applicable",
#'                  "not applicable", "Not Applicable"))
#'
#'compare_sentences(sentence1 = "My tailor is rich, 
#'                  and those flowers are beautiful!", 
#'                  sentence2 = "Their tailor is very wealthy, 
#'                  and these flowers are beautiful!",
#'                  highlight_diff = "underline", 
#'                  NA.string = c("n/a", "na", "N/A", "NA"))

compare_sentences <- function(sentence1, sentence2, highlight_diff = "underline", NA.string = not.applicable) {
  
  if(highlight_diff == "bold") highlight <- "\\textbf"
  if(highlight_diff == "underline") highlight <- "\\underline"
  if(highlight_diff == "italics") highlight <- "\\textit"
  if(highlight_diff == "standard") highlight <- "\\normalfont"
  highlight_strip <- gsub(pattern = "\\\\", replacement = "", x = highlight)
  
  if(sentence1 == "" & sentence2 == ""){
    
    sentence3 <- ""
    
  }else if(sentence1 %in% NA.string & sentence2 %in% NA.string){
    
    sentence3 <- ""
    
  }else{
    
    # Break sentences up 
    sentence1 <- unlist(strsplit(sentence1,"[[:space:]]|(?=[.,;!?])", perl = TRUE))
    sentence2 <- unlist(strsplit(sentence2,"[[:space:]]|(?=[.,;!?])", perl = TRUE))
    
    # Identify differences and corresponding positions of words in the sentence  (use \\b to match whole words)
    diffWords <- setdiff(sentence2, sentence1)
    diffIndex <- sapply(X = diffWords, FUN = function(w) which(grepl(pattern = paste0("\\b", w, "\\b"), x = sentence2)))
    diffSeq <- seqle(diffIndex)
    
    # Reconstruct sentence
    sentence2[diffIndex] <- paste0(highlight, "{", sentence2[diffIndex], "}")
    sentence2 <- sentence2[!sentence2 == ""]
    sentence3 <- gsub(pattern = paste0("\\} \\\\", highlight_strip, "\\{"), " ", paste0(sentence2, collapse = " "))
    sentence3 <- qdapRegex::rm_white(sentence3) # Remove white spaces
    
    return(sentence3)
  }
}