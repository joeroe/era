# Package index

## Years with era

Functions for constructing and transforming `yr` objects, representing
years with an associated era.

- [`yr()`](https://era.joeroe.io/reference/yr.md) : Create a vector of
  years with era
- [`yr_era()`](https://era.joeroe.io/reference/yr_era.md)
  [`yr_set_era()`](https://era.joeroe.io/reference/yr_era.md)
  [`` `yr_era<-`() ``](https://era.joeroe.io/reference/yr_era.md) : Get
  or set the era of a vector of years
- [`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md) :
  Convert years from one era to another

## Era definitions

Functions for defining calendar eras and time scales.

- [`era()`](https://era.joeroe.io/reference/era.md) : Create an era
  object
- [`eras()`](https://era.joeroe.io/reference/eras.md) : Standard era
  definitions

## Chronological sorting and extremes

Functions for sorting and calculating the extreme values of `yr` vectors
that take into account the direction of its era.

- [`yr_earliest()`](https://era.joeroe.io/reference/yr_extremes.md)
  [`yr_latest()`](https://era.joeroe.io/reference/yr_extremes.md)
  [`yr_range()`](https://era.joeroe.io/reference/yr_extremes.md) :
  Chronological minima and maxima
- [`yr_sort()`](https://era.joeroe.io/reference/yr_sort.md) :
  Chronological ordering of year vectors

## Helper functions

Miscellaneous utility functions for working with `yr` and `era` objects.

- [`era()`](https://era.joeroe.io/reference/era.md) : Create an era
  object

- [`era_label()`](https://era.joeroe.io/reference/era_parameters.md)
  [`era_epoch()`](https://era.joeroe.io/reference/era_parameters.md)
  [`era_name()`](https://era.joeroe.io/reference/era_parameters.md)
  [`era_unit()`](https://era.joeroe.io/reference/era_parameters.md)
  [`era_scale()`](https://era.joeroe.io/reference/era_parameters.md)
  [`era_direction()`](https://era.joeroe.io/reference/era_parameters.md)
  : Get parameters of an era

- [`era_year()`](https://era.joeroe.io/reference/era_year.md) : Year
  units

- [`era_year_label()`](https://era.joeroe.io/reference/era_year_parameters.md)
  [`era_year_days()`](https://era.joeroe.io/reference/era_year_parameters.md)
  :

  Get the parameters of an `era_year` object.

- [`is_era()`](https://era.joeroe.io/reference/is_era.md)
  [`validate_era()`](https://era.joeroe.io/reference/is_era.md)
  [`is_valid_era()`](https://era.joeroe.io/reference/is_era.md) :

  Validation functions for `era` objects

- [`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md) :

  Validation functions for `era_year` objects

- [`is_yr()`](https://era.joeroe.io/reference/is_yr.md)
  [`validate_yr()`](https://era.joeroe.io/reference/is_yr.md)
  [`is_valid_yr()`](https://era.joeroe.io/reference/is_yr.md) :

  Validation functions for `yr` objects

- [`this_year()`](https://era.joeroe.io/reference/this_year.md) :
  Current year
