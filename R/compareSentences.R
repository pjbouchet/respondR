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
#'compareSentences(sentence1 = "The skye is blue and the grass is green.", 
#'                 sentence2 = "The ocean is blue and the apples are green!",
#'                 highlight_diff = "underline", 
#'                 NA.string = c("n/a", "na", "N/A", "NA", "Not applicable",
#'                  "not applicable", "Not Applicable"))
#'
#'compareSentences(sentence1 = "My name is Patricia.", 
#'                 sentence2 = "My name is Stacey.", 
#'                 highlight_diff = "underline", 
#'                 NA.string = c("n/a", "na", "N/A", "NA"))
#'
#'compareSentences(sentence1 = "My tailor is rich, 
#'                 and those flowers are beautiful!", 
#'                 sentence2 = "Their tailor is very wealthy, 
#'                 and these flowers are beautiful!",
#'                 highlight_diff = "underline", 
#'                 NA.string = c("n/a", "na", "N/A", "NA"))

compareSentences <- function(sentence1, sentence2, highlight_diff = "underline", NA.string = not.applicable) {
  
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
    
    # sentence1 <- sentence1 %>% tm::removePunctuation(.)
    # sentence2 <- sentence2 %>% tm::removePunctuation(.) 
    
    sentence1 <- if(!sentence1 == "") unlist(strsplit(sentence1, " "))
    sentence2 <- if(!sentence2 == "") unlist(strsplit(sentence2, " "))
    
    diffWords <- setdiff(sentence2, sentence1)
    # diffIndex <- purrr::map_dbl(.x = diffWords, .f = ~which(str_detect(sentence2, paste0("\\b", .x, "\\b"))))
    diffIndex <- purrr::map_dbl(.x = diffWords, .f = ~which(str_detect(sentence2, .x)))

    # Identify 
    diffSeq <- seqle(diffIndex)
    sentence2[diffIndex] <- paste0(highlight, "{", sentence2[diffIndex], "}")
    
    sentence3 <- gsub(pattern = paste0("\\} \\\\", highlight_strip, "\\{"), " ", paste0(sentence2, collapse = " "))
    
    # if(length(diffIndex) == 1 & all(diffIndex == length(sentence2))){
    #   sentence3 <- sentence2
    # }else{
    # sentence3 <- c()
    # 
    # for(w in 1:length(sentence2)){
    #   
    #   if(w == 1){indices <- c(w, w+1, w+2)
    #   }else if(w == length(sentence2)){indices <- c(w, w-1, w-2)
    #   }else{indices <- c(w, w-1, w+1)}
    #   
    #   is.highlighted <- stringr::str_detect(string = sentence2[indices], pattern = highlight_strip)
    #   
    #   if(sum(is.highlighted)==0){
    #     
    #     sentence3[w] <- sentence2[w]
    #     
    #   }else if(sum(is.highlighted)==3 & w == length(sentence2)){
    #     
    #     sentence3[w] <- sentence2[w] %>% 
    #       gsub(pattern = "\\{", replacement = "", x = .) %>% 
    #       gsub(pattern = highlight_strip, replacement = "", x = .) %>% 
    #       gsub(pattern = "\\\\", replacement = "", x = .)
    #     
    #   }else if(sum(is.highlighted)==3 & w == 1){
    #     
    #     sentence3[w] <- sentence2[w] %>% 
    #       gsub(pattern = "}", replacement = "", x = .)
    #     
    #   }else if(sum(is.highlighted)==3){
    #     
    #     sentence3[w] <- sentence2[w] %>% 
    #       gsub(pattern = "}", replacement = "", x = .) %>% 
    #       gsub(pattern = highlight_strip, replacement = "", x = .) %>% 
    #       gsub(pattern = "\\{|\\}", replacement = "", x = .) %>% 
    #       gsub(pattern = "\\\\", replacement = "", x = .)
    #     
    #   }else if(is.highlighted[3]){
    #     sentence3[w] <- sentence2[w] %>% 
    #       gsub(pattern = "}", replacement = "", x = .)
    #     
    #   }else if(is.highlighted[2] & !w == length(sentence2)){
    #     sentence3[w] <- sentence2[w] %>% 
    #       gsub(pattern = highlight_strip, replacement = "", x = .) %>% 
    #       gsub(pattern = "\\{|\\}", replacement = "", x = .) %>% 
    #       gsub(pattern = "\\\\", replacement = "", x = .)
    #     
    #   }else if(is.highlighted[1] & w == length(sentence2)){
    #     sentence3[w] <- sentence2[w] %>% 
    #       gsub(pattern = highlight_strip, replacement = "", x = .) %>% 
    #       gsub(pattern = "\\{", replacement = "", x = .) %>% 
    #       gsub(pattern = "\\\\", replacement = "", x = .)
    #     
    #   }else if(is.highlighted[1] & sum(is.highlighted[2:3])==0){
    #     
    #     sentence3[w] <- sentence2[w]
    #   }
    #   
    # }
    # sentence3 <- paste0(sentence3, collapse = " ")
    # sentence3 <- paste0(sentence3, ".")}
    return(sentence3)
  }
}