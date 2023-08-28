#' Title
#'
#' @param plot 
#' @param color 
#' @param alpha 
#' @param judgement 
#' @param family 
#' @param fontface 
#' @param clip 
#' @param plot.margin 
#' @param x 
#' @param y 
#' @param vjust 
#' @param hjust 
#' @param size 
#' @param angle 
#'
#' @return
#' @export
#'
#' @examples
judge_plot <- function(
  plot = NULL, 
  color = "red", 
  alpha =.9, 
  judgement = "you made\na plot", 
  family = "Helvetica",
  fontface = "bold", 
  clip = "off", 
  plot.margin = margin(50, 70, 10, 10),
  x=1, y=1, vjust=1.1, hjust=1.1, size=35, angle = 0
  ){
  
  if(is.null(plot)){plot <- ggplot2::last_plot()}
  
  cowplot::ggdraw(plot + theme(plot.margin = plot.margin),
                  clip = clip) +
    cowplot::draw_text(paste0(judgement, ""), x=x, y=y, vjust=vjust, hjust=hjust, size=size, angle = angle,
              color=color, alpha=alpha, family = family, fontface = fontface) +
    
    cowplot::draw_line(c(1, 1), c(0, 1), size= 2.8, color=color, alpha=alpha)
}
