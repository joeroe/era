# era

[![DOI](https://zenodo.org/badge/311391850.svg)](https://doi.org/10.5281/zenodo.7327395)

**era** is an R package that provides a consistent representation of
year-based time scales as a numeric vector with an associated *era* –
the [yr class](https://era.joeroe.io/reference/yr.html).

It includes built-in [era
definitions](https://era.joeroe.io/reference/eras.html) for many year
numbering systems used in contemporary and historic calendars
(e.g. Common Era, Islamic ‘Hijri’ years); year-based time scales used in
archaeology, astronomy, geology, and other palaeosciences (e.g. Before
Present, SI-prefixed *annus*); and support for [arbitrary user-defined
eras](https://era.joeroe.io/reference/era.html). Years can converted
from any one era to another using the generalised transformation
function
[yr_transform()](https://era.joeroe.io/reference/yr_transform.html).

era’s classes are based on [vctrs](https://vctrs.r-lib.org/), and come
with methods for robust casting and coercion between years and other
numeric types, type-stable arithmetic with years, and pretty-printing in
tables.

## Installation

You can install the released version of era [from
CRAN](https://cran.r-project.org/package=era) with:

``` r
install.packages("era")
```

Or the development version from [GitHub](https://github.com/joeroe/era)
using the [remotes](https://remotes.r-lib.org/) package:

``` r
# install.packages("remotes")
remotes::install_github("joeroe/era")
```

## Basic usage

[`yr()`](https://era.joeroe.io/reference/yr.md) defines the era
associated with a vector of years:

``` r
library(era)
x <- yr(c(9000, 8000, 7000), "cal BP")
x
#> # cal BP years <yr[3]>:
#> [1] 9000 8000 7000
#> # Era: Before Present (cal BP): Gregorian years (365.2425 days), counted backwards from 1950
```

Use [`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md)
to convert between eras:

``` r
yr_transform(x, "BCE")
#> # BCE years <yr[3]>:
#> [1] 7051 6051 5051
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1
```

Many common calendar systems and time scales are predefined (see
`?eras()`) and can be referenced by their abbreviated labels. Other eras
can be defined using the
[`era()`](https://era.joeroe.io/reference/era.md) function directly.

For further usage, see the [package
introduction](https://era.joeroe.io/articles/era.html)
([`vignette("era")`](https://era.joeroe.io/articles/era.md)).
