#' Look for sequences of integers in a vector
#' 
#' The function is adapted from the \code{rle} function for computing the lengths and values of runs of equal values in a vector -- or the reverse operation.
#' 
#' @param x Vector of integers
#' 
#' @return A list with two components: 
#' \tabular{ll}{
#'   \code{lengths} \tab An integer vector containing the length of each run.\cr
#'   \code{values} \tab a vector of the same length as lengths with the corresponding values.\cr
#'  }
#' @author Carl Witthoft
#' 
#' @references https://stackoverflow.com/questions/8400901/group-integer-vector-into-consecutive-runs/8402950#8402950

seqle <- function(x) {
  if (!is.numeric(x)) x <- as.numeric(x)
  n <- length(x)
  y <- x[-1L] != x[-n] + 1
  i <- c(which(y | is.na(y)), n)
  list(
    lengths = diff(c(0L, i)),
    values = x[head(c(0L, i) + 1L, -1L)]
  )
}
