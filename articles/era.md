# Years with an era

Archaeologists, geologists, and other palaeoscientists use different
systems for numbering years in the distant past. For example, the year
10,000 BCE is 11,950 [Before
Present](https://en.wikipedia.org/wiki/Before_Present) or 11.95
[ka](https://en.wikipedia.org/wiki/Year#Symbols). It is usually fine to
store years as a plain numeric vector in R, but sometimes it helps to be
explicit about which system is being used:

- When you have data that mixes different systems
- When you want to transform years between different systems
- When you need to do arithmetic with years

The **era** package helps in these cases by providing classes which
define the ‘era’ associated with a vector of years and functions for
formatting, combining, and transforming years with different eras. This
vignette is an introduction to the main features of the package.

``` r
library("era")
library("tibble")
library("dplyr")
```

## Years with an era

Vectors of years with an era are represented by the `yr` (`era_yr`)
class, which is constructed with
[`yr()`](https://era.joeroe.io/reference/yr.md):

``` r
yr(c(10000, 11000, 12000), "BP")
#> # BP years <yr[3]>:
#> [1] 10000 11000 12000
#> # Era: Before Present (BP): Gregorian years (365.2425 days), counted backwards from 1950
```

The first argument is a numeric vector of years. These can be integers
or doubles.

The second argument, `era`, defines the numbering system associated with
the years. This is an object of class `era` which defines the
[parameters of the calendar, epoch and time scale](#era). Most of the
time, you can simply specify the abbreviated label of the era, which
will be looked up in the standard eras defined by
[`eras()`](https://era.joeroe.io/reference/eras.md):

``` r
yr(c(10000, 11000, 12000), "BCE")
#> # BCE years <yr[3]>:
#> [1] 10000 11000 12000
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1
yr(c(10000, 11000, 12000), "uncal BP")
#> # uncal BP years <yr[3]>:
#> [1] 10000 11000 12000
#> # Era: uncalibrated Before Present (uncal BP): radiocarbon years (NA days), counted backwards from 1950
yr(c(10000, 11000, 12000), "ka")
#> # ka years <yr[3]>:
#> [1] 10000 11000 12000
#> # Era: kiloannum (ka): 1000 Gregorian years (365.2425 days), counted backwards from 1950
```

[`yr_era()`](https://era.joeroe.io/reference/yr_era.md) returns details
of the era associated with a `yr` vector:

``` r
neolithic <- yr(11700:7500, "BP")
yr_era(neolithic)
#> <era[1]>
#> [1] Before Present (BP): Gregorian years (365.2425 days), counted backwards from 1950
```

[`yr_era()`](https://era.joeroe.io/reference/yr_era.md), and its
pipe-friendly alias
[`yr_set_era()`](https://era.joeroe.io/reference/yr_era.md), can also be
used to set the era of an existing object:

``` r
chalcolithic <- 7500:6000
yr_era(chalcolithic) <- yr_era(neolithic)
yr_era(chalcolithic)
#> <era[1]>
#> [1] Before Present (BP): Gregorian years (365.2425 days), counted backwards from 1950
```

Note that this only updates the vector’s era attribute; it doesn’t
change the data itself. To *convert* years from one era to another, you
need to use [the `yr_transform()` function](#yr_transform).

`yr` vectors fit nicely into tables, both base data frames and tibbles:

``` r
postglacial <- tribble(
  ~period,           ~start_ka,
  "Late Holocene",   4.2,
  "Mid Holocene",    8.326,
  "Early Holocene",  11.7,
  "Younger Dryas",   12.9,
  "Bølling-Allerød", 14.7,
  "Heinrich 1",      17.0
)

postglacial |> 
  mutate(start_ka = yr(start_ka, "ka"))
#> # A tibble: 6 × 2
#>   period          start_ka
#>   <chr>               <yr>
#> 1 Late Holocene     4.2 ka
#> 2 Mid Holocene    8.326 ka
#> 3 Early Holocene   11.7 ka
#> 4 Younger Dryas    12.9 ka
#> 5 Bølling-Allerød  14.7 ka
#> 6 Heinrich 1         17 ka
```

## Era definitions

era includes built-in definitions of many time scales and year numbering
systems from contemporary and historic calendars.
[`eras()`](https://era.joeroe.io/reference/eras.md) returns the [full
list](#era-list) of built-in definitions. You can use any definition in
this list by passing its abbreviated `label` to
[`era()`](https://era.joeroe.io/reference/era.md) or as the `era`
argument of [`yr()`](https://era.joeroe.io/reference/yr.md) or any other
function in the package:

``` r
era("BP")
#> <era[1]>
#> [1] Before Present (BP): Gregorian years (365.2425 days), counted backwards from 1950

yr(10000, "BP")
#> # BP years <yr[1]>:
#> [1] 10000
#> # Era: Before Present (BP): Gregorian years (365.2425 days), counted backwards from 1950

yr_transform(yr(10000, "BP"), "BCE")
#> # BCE years <yr[1]>:
#> [1] 8051
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1
```

If you need to use a time scale that is not in this list, you can
[define it yourself](#defining-other-eras) with
[`era()`](https://era.joeroe.io/reference/era.md). Suggestions for new
eras to include in the package are also welcome; please [create an
issue](https://github.com/joeroe/era/issues) on GitHub with suggestions.

### List of built-in eras

| label    |       epoch | name                                 | unit                                           | scale | direction | this_year |
|:---------|------------:|:-------------------------------------|:-----------------------------------------------|------:|----------:|:----------|
| BP       |   1950.0000 | Before Present                       | Gregorian years (365.2425 days)                | 1e+00 |        -1 | -76       |
| cal BP   |   1950.0000 | Before Present                       | Gregorian years (365.2425 days)                | 1e+00 |        -1 | -76       |
| BC       |      1.0000 | Before Christ                        | Gregorian years (365.2425 days)                | 1e+00 |        -1 | -2025     |
| BCE      |      1.0000 | Before Common Era                    | Gregorian years (365.2425 days)                | 1e+00 |        -1 | -2025     |
| AD       |      0.0000 | Anno Domini                          | Gregorian years (365.2425 days)                | 1e+00 |         1 | 2026      |
| CE       |      0.0000 | Common Era                           | Gregorian years (365.2425 days)                | 1e+00 |         1 | 2026      |
| a        |   1950.0000 | annum                                | Gregorian years (365.2425 days)                | 1e+00 |        -1 | -76       |
| ka       |   1950.0000 | kiloannum                            | Gregorian years (365.2425 days)                | 1e+03 |        -1 | 0         |
| Ma       |   1950.0000 | megaannum                            | Gregorian years (365.2425 days)                | 1e+06 |        -1 | 0         |
| Ga       |   1950.0000 | gigaannum                            | Gregorian years (365.2425 days)                | 1e+09 |        -1 | 0         |
| kya      |   1950.0000 | thousand years ago                   | Gregorian years (365.2425 days)                | 1e+03 |        -1 | 0         |
| mya      |   1950.0000 | million years ago                    | Gregorian years (365.2425 days)                | 1e+06 |        -1 | 0         |
| bya      |   1950.0000 | billion years ago                    | Gregorian years (365.2425 days)                | 1e+09 |        -1 | 0         |
| b2k      |   2000.0000 | years before 2000                    | Gregorian years (365.2425 days)                | 1e+00 |        -1 | -26       |
| uncal BP |   1950.0000 | uncalibrated Before Present          | radiocarbon years (NA days)                    | 1e+00 |        -1 | NA        |
| RCYBP    |   1950.0000 | Radiocarbon Years Before Present     | radiocarbon years (NA days)                    | 1e+00 |        -1 | NA        |
| bp       |   1950.0000 | Before Present (uncalibrated)        | radiocarbon years (NA days)                    | 1e+00 |        -1 | NA        |
| bc       |   1950.0000 | Before Christ (uncalibrated)         | radiocarbon years (NA days)                    | 1e+00 |        -1 | NA        |
| bce      |   1950.0000 | Before Common Era (uncalibrated)     | radiocarbon years (NA days)                    | 1e+00 |        -1 | NA        |
| ad       |   1950.0000 | Anno Domini (uncalibrated)           | radiocarbon years (NA days)                    | 1e+00 |         1 | NA        |
| ce       |   1950.0000 | Common Era (uncalibrated)            | radiocarbon years (NA days)                    | 1e+00 |         1 | NA        |
| AD O.S.  |      0.0000 | Anno Domini (Old Style)              | Julian years (365.25 days)                     | 1e+00 |         1 | 2025      |
| BC O.S.  |      1.0000 | Before Christ (New Style)            | Julian years (365.25 days)                     | 1e+00 |         1 | 2024      |
| H        |    621.5366 | Hijra                                | Islamic lunar years (354.36708 days)           | 1e+00 |         1 | 1447      |
| AH       |    621.5366 | Anno Hegirae                         | Islamic lunar years (354.36708 days)           | 1e+00 |         1 | 1447      |
| BH       |    622.5366 | Before the Hijra                     | Islamic lunar years (354.36708 days)           | 1e+00 |        -1 | -1446     |
| SH       |    621.2190 | Solar Hijri                          | Nowruz years (365.2424 days)                   | 1e+00 |         1 | 1404      |
| BSH      |    622.2190 | Before Solar Hijri                   | Nowruz years (365.2424 days)                   | 1e+00 |        -1 | -1403     |
| AM       |  -3760.2361 | Anno Mundi                           | Hebrew lunisolar years (365.246822205978 days) | 1e+00 |         1 | 5786      |
| HE       | -10000.0000 | Holocene Era                         | Gregorian years (365.2425 days)                | 1e+00 |         1 | 12026     |
| BHE      | -10000.0000 | Before Holocene Era                  | Gregorian years (365.2425 days)                | 1e+00 |        -1 | -12026    |
| AL       |  -4000.0000 | Anno Lucis                           | Gregorian years (365.2425 days)                | 1e+00 |         1 | 6026      |
| ADA      |  -8000.0000 | After the Development of Agriculture | Gregorian years (365.2425 days)                | 1e+00 |         1 | 10026     |

### Defining other eras

Eras are defined by the `era` class with the following parameters:

- **label**: an abbreviated label that uniquely identifies the era
- **name**: the full name of the era
- **epoch**: the origin year from which years are counted (in Gregorian
  astronomical years)
- **unit**: the unit of years counted, defined as its length in solar
  days
- **scale**: the number of years represented by one unit
- **direction**: whether years are counted forwards (`1`) or backwards
  (`-1`) from the epoch

These parameters are passed to
[`era()`](https://era.joeroe.io/reference/era.md) to construct an `era`
object. `epoch`, `unit`, `scale`, and `direction` determine the
transformation between eras; `label` and `name` are purely descriptive.

You can define arbitrary eras by using the
[`era()`](https://era.joeroe.io/reference/era.md) function directly:

``` r
era("T.A.", epoch = -9021, name = "Third Age", direction = 1)
#> <era[1]>
#> [1] Third Age (T.A.): Gregorian years (365.2425 days), counted forwards from -9021
```

As long as all the parameters are specified correctly, user-defined eras
can also be used in
[`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md).

## Converting between eras: `yr_transform()`

Use [`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md)
to convert between eras:

``` r
postglacial |> 
  mutate(start_ka = yr(start_ka, "ka")) |> 
  mutate(start_bp = yr_transform(start_ka, era("BP")),
         start_bce = yr_transform(start_ka, era("BCE")))
#> # A tibble: 6 × 4
#>   period          start_ka start_bp start_bce
#>   <chr>               <yr>     <yr>      <yr>
#> 1 Late Holocene     4.2 ka  4200 BP  2251 BCE
#> 2 Mid Holocene    8.326 ka  8326 BP  6377 BCE
#> 3 Early Holocene   11.7 ka 11700 BP  9751 BCE
#> 4 Younger Dryas    12.9 ka 12900 BP 10951 BCE
#> 5 Bølling-Allerød  14.7 ka 14700 BP 12751 BCE
#> 6 Heinrich 1         17 ka 17000 BP 15051 BCE
```

This function implements a generic algorithm for transforming years
based on the era parameters described above. This means that, with a few
exceptions (see [invalid transformations](#invalidtransform), you can
transform between any two eras that can be described by the `era` class.

### Transformation precision

By default, era transformations are exact:

``` r
yr(500000, "BCE") |> 
  yr_transform(era("ka"))
#> # ka years <yr[1]>:
#> [1] 501.949
#> # Era: kiloannum (ka): 1000 Gregorian years (365.2425 days), counted backwards from 1950
```

Often, this precision is not necessary. For example, when converting
years between calendar- and present-based eras, the 76 year difference
between the formal definition of “Present” and the actual present is
rarely significant on a geologic time scale. Use the `precision`
argument of `yr_transform` to get rounded results:

``` r
yr(10000, "BP") |> 
  yr_transform(era("BCE"), precision = 1000)
#> # BCE years <yr[1]>:
#> [1] 8000
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1

yr(500000, "BCE") |> 
  yr_transform(era("mya"), precision = 0.1)
#> # mya years <yr[1]>:
#> [1] 0.5
#> # Era: million years ago (mya): 1000000 Gregorian years (365.2425 days), counted backwards from 1950
```

### Invalid transformations

Some transformations are not possible. Notably, the length of a
‘radiocarbon year’ is not well defined on a calendar time scale without
[calibration](https://en.wikipedia.org/wiki/Radiocarbon_calibration).
Eras that use non-calendar year unit are represented with an `NA` and
will cause an error if passed to
[`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md):

``` r
era_unit(era("uncal BP"))
#> <era_year[1]>
#> [1] radiocarbon years (NA days)
yr_transform(yr(9000, "uncal BP"), era("cal BP"))
#> Error in `yr_transform()`:
#> ! Cannot transform uncalibrated Before Present to Before Present years:
#> ✖ Calendar length of a radiocarbon year is undefined.
```

`c14_calibrate()` from the
[stratigraphr](https://stratigraphr.joeroe.io) package implements
radiocarbon calibration with `yr` objects.

Conversion between eras that both have an `NA` unit are also an error,
following the R convention that `NA == NA` is `NA`. In other words, we
don’t know whether two non-calendar units are the *same* non-calendar
unit. This means that it is not possible to use
[`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md) to
convert bp (radiocarbon years Before Present) to bce (radiocarbon years
before the Common Era) years, for example.

## Arithmetic with year vectors

The `yr` class is based on [vctrs](https://vctrs.r-lib.org/), ensuring
type- and size-stable computations. For example, you can do arithmetic
with year vectors:

``` r
a <- yr(1500, "CE")
b <- yr(2020, "CE")
b - a
#> # CE years <yr[1]>:
#> [1] 520
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0
```

But only when they have the same era:

``` r
c <- yr(0.5, "ka")
b - c
#> Error in `vec_cast.era_yr.era_yr()`:
#> ! Can't convert `y` <yr (ka)> to <yr (CE)>.
#> Reconcile eras with yr_transform() first.
```

Note that, when comparing eras, only the parameters significant to the
transformation are considered (i.e. not `label` or `name`). This means
that it is possible to combine year vectors with differently-named but
functionally equivalent eras, for example `era("BP")` and
`era("cal BP")`, although doing so will print a warning about the loss
of information:

``` r
era("BP") == era("BC")
#> [1] FALSE
era("BP") == era("cal BP")
#> [1] TRUE

yr(1000, "BP") + yr(1000, "cal BP")
#> Warning: eras have different label or name parameters.
#> # BP years <yr[1]>:
#> [1] 2000
#> # Era: Before Present (BP): Gregorian years (365.2425 days), counted backwards from 1950
```

Years will be coerced to a plain numeric vector if a computation means
their era no longer makes sense:

``` r
a * b
#> [1] 3030000
```
