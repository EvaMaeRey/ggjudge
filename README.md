
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggjudge

Using FDV (Wilke) strategy for expressing high level judgments about
plot’s effectiveness, also extending to code, and to text console
output. Uses cowplot’s ggdraw functions.

<!-- badges: start -->

<!-- badges: end -->

``` r

judge_plot <- function(
  p = NULL, 
  color = "red", 
  alpha =.9, 
  judgement = "you made\na plot", 
  family = "Helvetica",
  fontface = "bold", 
  clip = "off", 
  plot.margin = margin(50,70,10,10),
  x=1, y=1, vjust=1.1, hjust=1.1, size=35, angle = 0
  ){
  
  if(is.null(p)){p <- ggplot2::last_plot()}
  
  cowplot::ggdraw(p + theme(plot.margin = plot.margin),
                  clip = clip) +
    cowplot::draw_text(paste0(judgement, ""), x=x, y=y, vjust=vjust, hjust=hjust, size=size, angle = angle,
              color=color, alpha=alpha, family = family, fontface = fontface) +
    
    cowplot::draw_line(c(1, 1), c(0, 1), size= 2.8, color=color, alpha=alpha)
}
```

``` r
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.0     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.1     ✔ tibble    3.2.0
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.1     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors


tidytitanic::passengers %>% 
  mutate(adult = age >= 18 ) %>% 
  filter(!is.na(age)) %>% 
ggplot() + 
  aes(x = adult) + 
  geom_bar()
```

<img src="man/figures/README-survived_plot-1.png" width="100%" />

``` r
judge_plot(judgement = "awkward")
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r
tidytitanic::passengers %>% 
  ggplot() + 
  aes(x = ifelse(survived, 
                 "survived",
                 "not survived")) + 
  geom_bar() + 
  labs(x = NULL)
```

``` r

# judge_code <- function(code, judgement, ...){
#   
#   
#   
# }

judge_chunk_code <- function(chunk_name, judgement = "you wrote code", ...){
  
  knitr::knit_code$get(name = chunk_name) |>  
  paste(collapse = "\n") ->
code


# text <- "tidytitanic::passengers %>% \n  mutate(adult = age >=18 ) %>% \n  filter(!is.na(age)) %>% \nggplot() + \n  aes(x = adult) + \n  geom_bar()"

ggplot2::ggplot(data = data.frame(x = c(0, 1), y = c(0,1))) +
  ggplot2::aes(x = x, y = y) +
  ggplot2::geom_blank() +
  ggplot2::annotate("text", label = code, x = 0, y = 1, hjust = 0, vjust = 1, size = 5, family = "Courier") + 
  ggplot2::theme_void() ->
syntax_plot

syntax_plot %>% judge_plot(judgement = judgement, ...)
  
}

judge_chunk_code("test_chunk", judgement = "repetative")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

# need to run in interactive session…

``` r
library(magrittr)
#> 
#> Attaching package: 'magrittr'
#> The following object is masked from 'package:purrr':
#> 
#>     set_names
#> The following object is masked from 'package:tidyr':
#> 
#>     extract
tidytitanic::passengers |> 
  janitor::tabyl(sex, survived)
#>     sex   0   1
#>  female 154 308
#>    male 709 142
```

``` r
judge_chunk_output <- function(chunk_name, judgement = "some output"){
    
  knitr::knit_code$get(name = chunk_name) |>  
  paste(collapse = "\n") ->
text
  
capture.output(eval(parse(text = text))) -> output

output %>% 
   paste(collapse = "\n") ->
output_clean


library(ggplot2)
ggplot(data = data.frame(x = c(0, 1), y = c(0,1))) +
  aes(x = x, y = y) +
  geom_blank() +
  annotate("text", label = output_clean, 
           x = 0, y = 1, hjust = 0, vjust = 1, 
           size = 5, family = "Courier") + 
  theme_void() ->
output_plot

output_plot %>% judge_plot(family = "Helvetica", color = "red", alpha = .9, judgement = judgement, fontface = "bold")

}

judge_chunk_code(chunk_name = "test_chunk_2")
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

``` r
judge_chunk_output(chunk_name = "test_chunk_2")
```

<img src="man/figures/README-unnamed-chunk-5-2.png" width="100%" />

# maybe later ideas

``` r
library(patchwork)

judge_chunk_plot <- function


judge_chunk <- function(chunk_name, 
                        judgement_code = "code", 
                        judgement_output = "output", 
                        ...){
  
  
  judge_chunk_code(chunk_name = chunk_name, 
                   judgement = judgement_code) /
    judge_chunk_output(chunk_name = chunk_name, 
                       judgement = judgement_output)
  
  
}
```

``` r
judge_chunk(chunk_name = "test_chunk_2", judgement_code = "code: using indicator variable directly", judgement_output = "output: information is lost")
```
