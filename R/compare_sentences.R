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

compare_sentences <- function(sentence1, 
                              sentence2, 
                              highlight_diff = "underline", 
                              NA.string = c("n/a", "na", "N/A", "NA", "Not applicable", 
                                            "not applicable", "Not Applicable")) {
  
  # Define LaTeX formatting command
  if(highlight_diff == "bold") highlight <- "\\textbf"
  if(highlight_diff == "underline") highlight <- "\\underline"
  if(highlight_diff == "italics") highlight <- "\\textit"
  if(highlight_diff == "standard") highlight <- "\\normalfont"
  
  highlight_strip <- gsub(pattern = "\\\\", replacement = "", x = highlight)
  
  if(sentence1 == "" & sentence2 == ""){
    
    sentence <- ""
    
  }else if(sentence1 %in% NA.string & sentence2 %in% NA.string){
    
    sentence <- ""
    
  }else{
    
    # Break sentences up 
    s1 <- unlist(strsplit(sentence1,"[[:space:]]|(?=[.,;!?])", perl = TRUE))
    s2 <- unlist(strsplit(sentence2,"[[:space:]]|(?=[.,;!?])", perl = TRUE))
    
    # Identify differences
    diff.df <- diffobj::ses_dat(s1, s2)
    
    # Identify replacements as two consecutive rows marked "Delete" and "Insert" respectively 
    # Mark the first as NA to avoid redundancies
    for(r in 1:nrow(diff.df)){
      if(diff.df$op[r] ==  "Delete" & diff.df$op[r + 1] == "Insert") diff.df$op[r] <- NA}
    diff.df <- diff.df[!is.na(diff.df$op), ]
    
    # Function to assign the correct LaTeX formatting
    to_latex <- function(input, diff.type){
      if(diff.type == "Match") output <- input
      if(diff.type == "Delete") output <- paste0(highlight, "{...} ")
      if(diff.type == "Insert") output <- paste0(highlight, "{", input, "}")
      return(output)
    }

    # Construct output text
    sentence <- diff.df %>% 
      dplyr::rowwise(.) %>% 
      dplyr::mutate(text = to_latex(input = val, diff.type = op)) %>% 
      dplyr::pull(text)
    
    
    # Identify differences and corresponding positions of words in the sentence  (use \\b to match whole words)
    # The first element contains words that have been added
    # The second contains words that have been removed
    # diffWords <- list(added = setdiff(x = s2, y = s1), deleted = setdiff(x = s1, y = s2))
    # # add.remove <- which.max(purrr::map_dbl(.x = diffWords, .f = ~length(.x)))
    # add.remove <- purrr::map_dbl(.x = diffWords, .f = ~length(.x))
    # 
    # if(add.remove[2]==0 & add.remove[1]>0) diffWords <- diffWords[["added"]]
    # if(add.remove[1]==0 & add.remove[2]>0) diffWords <- diffWords[["deleted"]]
    # if(add.remove[2]==add.remove[1]) diffWords <- diffWords[["added"]]
    # 
    # if(class(diffWords)=="character") diffWords <- list(diffWords)
    # 
    # diffIndex <- purrr::map(.x = length(diffWords), 
    #                         .f = ~sapply(X = diffWords[[.x]], 
    #                                      FUN = function(w) 
    #                                        {c(which(grepl(pattern = paste0("\\b", w, "\\b"), x = list(s2, s1)[[.x]])),
    #                                           which(grepl(pattern = paste0("\\b", w, "\\b"), x = list(s1, s2)[[.x]])))}))
    #       
    # 
    # 
    # # if(add.remove == 1) diffIndex <- sapply(X = diffWords, FUN = function(w) which(grepl(pattern = paste0("\\b", w, "\\b"), x = sentence2)))
    # # 
    # # if(add.remove == 2) diffIndex <- sapply(X = diffWords, FUN = function(w) which(grepl(pattern = paste0("\\b", w, "\\b"), x = sentence1)))
    # 
    # diffIndex <-  purrr::map(.x = diffIndex, .f = ~ .x[which(!names(.x) =="")])
    #              # diffIndex[[1]] <- diffIndex[[1]][which(!names(diffIndex[[1]]) =="")]
    # 
    # 
    # # Reconstruct sentence
    # # if(add.remove == 1){ 
    #   sentence <- s2
    #   # diffSeq <- seqle(diffIndex)
    #   # sentence[diffIndex] <- paste0(highlight, "{", sentence[diffIndex], "}") 
    #   
    #   if(add.remove[1]>0) sentence[unlist(diffIndex)] <- paste0(highlight, "{", sentence[unlist(diffIndex)], "}") 
    #   # if(length(diffIndex) > 1){
    #   if(add.remove[2]>0){
    #   dots <- unlist(diffIndex)
    #   dots <- dots[which(dots < length(s1))]
    #   sentence[dots] <- paste0(highlight, "{...} ", sentence[dots]) }
   #  } else {
   #    sentence <- sentence1
   #    sentence[diffIndex] <- paste0(highlight, "{", "...", "}") 
   #    }
   #  


    sentence <- sentence[!sentence == ""]
    dots <- paste0("\\...")
    duplicate.dots <- rep(0, length(sentence))
    for(i in 2:length(sentence)){
      if(grepl(pattern = dots, x = sentence[i - 1]) & grepl(pattern = dots, x = sentence[i])){
        duplicate.dots[i] <- 1}}
    sentence <- sentence[duplicate.dots == 0]
    sentence <- gsub(pattern = paste0("\\} \\\\", highlight_strip, "\\{"), " ", paste0(sentence, collapse = " "))
    
    sentence <- qdapRegex::rm_white(sentence) # Remove white spaces
    
    return(sentence)
  }
}