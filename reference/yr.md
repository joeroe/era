# Create a vector of years with era

A `yr` object represents years with an associated calendar era or time
scale.

## Usage

``` r
yr(x = numeric(), era = character())
```

## Arguments

- x:

  A numeric vector of years.

- era:

  The calendar era used by `x`. Either:

  - A string matching one of the standard era labels defined in
    [`eras()`](https://era.joeroe.io/reference/eras.md)

  - An `era` object constructed with
    [`era()`](https://era.joeroe.io/reference/era.md)

## Value

A `yr` (`era_yr`) object.

## See also

Other years with era functions:
[`yr_era()`](https://era.joeroe.io/reference/yr_era.md),
[`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md)

## Examples

``` r
# The R Age
yr(1993:2020, "CE")
#> # CE years <yr[28]>:
#>  [1] 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007
#> [16] 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0

# A bad movie
yr(10000, "BC")
#> # BC years <yr[1]>:
#> [1] 10000
#> # Era: Before Christ (BC): Gregorian years (365.2425 days), counted backwards from 1
```
