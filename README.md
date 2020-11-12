
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/joeroe/era/workflows/R-CMD-check/badge.svg)](https://github.com/joeroe/era/actions)
[![Codecov test
coverage](https://codecov.io/gh/joeroe/era/branch/master/graph/badge.svg)](https://codecov.io/gh/joeroe/era?branch=master)
<!-- badges: end -->

**era** is an R package that provides a consistent vector representation
of years with an associated calendar era or time scale. It includes
built-in definitions of many contemporary and historic calendars; time
scales commonly used in archaeology, astronomy, geology, and other
palaeosciences (e.g. Before Present, SI-prefixed *annus*); and support
for arbitrary user-defined eras. Functions for converting between eras
and for type-stable arithmetic with years are also provided.

## Installation

You can install the development version of era from GitHub with the
[remotes](https://remotes.r-lib.org/) package.

``` r
# install.packages("remotes")
remotes::install_github("joeroe/era")
```

## Basic usage

`yr()` defines the era associated with a vector of years:

``` r
library(era)
yr(10010:10001, "cal BP")
#> # cal BP years <yr[10]>:
#>  [1] 10010 10009 10008 10007 10006 10005 10004 10003 10002 10001
#> # Era: Before Present (cal BP): calendar years, counted backwards from 1950
```

`yr` is a vector class is based on [vctrs](https://vctrs.r-lib.org/).
This means it behaves in a consistent, type-stable way across base R and
other packages, and fits neatly into tibbles and data frames. Many
common calendar systems and time scales are built into the package (see
`?eras()`) and can be referenced by simply passing their abbreviated
label to `yr()`. Other eras can be defined using the `era()` function
directly.

Use `yr_transform()` to convert between eras:

``` r
yr(10010:10001, "cal BP") %>% 
  yr_transform(era("BCE"))
#> # BCE years <yr[10]>:
#>  [1] 8060 8059 8058 8057 8056 8055 8054 8053 8052 8051
#> # Era: Before Common Era (BCE): calendar years, counted backwards from 0
```

For further usage, see the [package
introduction](https://era.joeroe.io/articles/era.html)
(`vignette("era")`).
