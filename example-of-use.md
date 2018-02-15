edat plot examples
================
Emile Latour
2018-02-14

<!------ Thanks for any contributions! Please edit the .Rmd, the .md is a byproduct of the .Rmd! --------->
Load the script for the EEDA plots
==================================

``` r
source(
  here::here("make-edat-plots.R")
  )
```

Examples of `plot_cont()`
=========================

The `plot_cont()` function will plot a histogram and table of summary statistics for **continuous** variables. As one of the inputs, the user can specify the method to use for creating histogram bins.

Below are some examples using the `mtcars` data set.

``` r
plot_cont(data = mtcars, var = disp)
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-2-1.png" width="100%" style="display: block; margin: auto;" />

``` r
plot_cont(data = mtcars, var = disp, binw_select = "Sturges")
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-2-2.png" width="100%" style="display: block; margin: auto;" />

``` r
plot_cont(data = mtcars, var = disp, binw_select = "Scott")
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-2-3.png" width="100%" style="display: block; margin: auto;" />

``` r
plot_cont(data = mtcars, var = disp, binw_select = "Hadley")
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-2-4.png" width="100%" style="display: block; margin: auto;" />

Examples of `plot_categ()`
==========================

The `plot_categ()` function creates a bar plot and frequency table for **categorical** variables.

Here is another example using the the `mtcars` data set.

``` r
mt2 <- mtcars %>% 
  mutate(cyl = factor(cyl))

plot_categ(data = mt2, var = cyl)
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />

Or another using th `iris` data set.

``` r
plot_categ(data = iris, var = Species)
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

Example of `make_plots()`
=========================

The `make_plots()` function takes a data set as an input and will apply either `plot_cont()` or `plot_categ()` depending on the variable class.

An example using the `diamonds` data set fromm the `ggplot2` package.

``` r
make_plots(data = diamonds)
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-1.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-2.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-3.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-4.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-5.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-6.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-7.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-8.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-9.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-5-10.png" width="100%" style="display: block; margin: auto;" />

It works with the `%>%` oprator
===============================

Note that all three functions are pipeable using `dplyr`. So if instead of the entire data set, you wanted to plot a subset:

``` r
diamonds %>% 
  dplyr::select(carat, color, clarity, price) %>% 
  make_plots(.)
```

<img src="example-of-use_files/figure-markdown_github/unnamed-chunk-6-1.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-6-2.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-6-3.png" width="100%" style="display: block; margin: auto;" /><img src="example-of-use_files/figure-markdown_github/unnamed-chunk-6-4.png" width="100%" style="display: block; margin: auto;" />
