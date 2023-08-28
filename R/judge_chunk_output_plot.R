#' Title
#'
#' @param chunk_name 
#' @param judgement 
#'
#' @return
#' @export
#'
#' @examples
judge_chunk_output_plot <- function(chunk_name, judgement = "some output"){
    
  knitr::knit_code$get(name = chunk_name) |>  
  paste(collapse = "\n") ->
text
  
eval(parse(text = text)) -> p

p %>% judge_plot(family = "Helvetica", color = "red", alpha = .9, judgement = judgement, fontface = "bold")

}
