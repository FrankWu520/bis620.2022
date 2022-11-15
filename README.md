
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bis620.2022

<!-- badges: start -->

[![R-CMD-check](https://github.com/FrankWu520/bis620.2022/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/FrankWu520/bis620.2022/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/FrankWu520/bis620.2022/branch/main/graph/badge.svg)](https://app.codecov.io/gh/FrankWu520/bis620.2022?branch=main)
<!-- badges: end -->

The goal of bis620.2022 is to get the spectral signature of
accelerometry data and plot UKBiobank accelerometry data. Using the
function `spectral_signature()` in `spectral.R`, you can obtain the
spectral signature of UKBiobank data, which is calculated by taking the
modulus of the Fourier coefficients of the signal. The function takes a
data setwith columns `X`, `Y`, `Z`, and `time`, and returns a data frame
with the modulus of the Fourier coefficients for the X, Y, and Z
channels. With the function `accel_plot()` in `plot.R`, you can plot
UKBiobank accelerometry data. The function takes a data set that is
assumed to have a `time`, `X`, `Y`, and `Z` column along with either a
`time` or `freq` column, and returns a a time-series plot faceted by
axis. I created this package to capture functions, data, and
documentation for BIS620 class in Fall 2022.

## Installation

You can install the development version of bis620.2022 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("FrankWu520/bis620.2022")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(bis620.2022)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
