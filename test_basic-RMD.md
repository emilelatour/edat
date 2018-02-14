EEDA examples
================
Emile Latour
2018-02-13

<!------ Thanks for any contributions! Please edit the .Rmd, the .md is a byproduct of the .Rmd! --------->
Load the script for the EEDA plots
==================================

``` r
source(
  here::here("make-eeda-plots.R")
  )
```

Examples of `plot_cont()`
=========================

Usisng the `mtcars` data set.

``` r
plot_cont(data = mtcars, var = disp)
```

<img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-2-1.png" width="70%" style="display: block; margin: auto;" />

``` r
plot_cont(data = mtcars, var = disp, binw_select = "Sturges")
```

<img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-2-2.png" width="70%" style="display: block; margin: auto;" />

``` r
plot_cont(data = mtcars, var = disp, binw_select = "Scott")
```

<img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-2-3.png" width="70%" style="display: block; margin: auto;" />

``` r
plot_cont(data = mtcars, var = disp, binw_select = "Hadley")
```

<img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-2-4.png" width="70%" style="display: block; margin: auto;" />

Examples of `plot_categ()`
==========================

Again, using the `mtcars` data set.

``` r
mt2 <- mtcars %>% 
  mutate(cyl = factor(cyl))

plot_categ(data = mt2, var = cyl)
```

<img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-3-1.png" width="70%" style="display: block; margin: auto;" />

Example of make\_plots()
========================

Using the `diamonds` data set fromm the `ggplot2` package.

``` r
make_plots(data = diamonds)
```

<img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-1.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-2.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-3.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-4.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-5.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-6.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-7.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-8.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-9.png" width="70%" style="display: block; margin: auto;" /><img src="test_basic-RMD_files/figure-markdown_github/unnamed-chunk-4-10.png" width="70%" style="display: block; margin: auto;" />
