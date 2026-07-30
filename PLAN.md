# Plan: Add `yr_earlier_than()` and `yr_later_than()` to era

## Motivation

The `yr` class uses numeric comparison for `<`/`<=`/`>`/`>=`, not chronological
comparison. This is semantically correct for the class (years are numeric), but
downstream packages (e.g. `tempo`) need chronological comparison functions.

For example, `yr(100, "BP") > yr(50, "BP")` is `TRUE` numerically, but 100 BP is
chronologically *earlier* than 50 BP. The existing `yr_earliest()` and
`yr_latest()` functions handle this for finding extremes, but there is no
equivalent for pairwise comparison.

## Proposed functions

### `yr_earlier_than(x, y)`

Returns `TRUE` where `x` is chronologically earlier than `y`.

- For forward-counting eras (CE, etc.): `x < y`
- For backward-counting eras (BP, BCE, etc.): `x > y`
- NAs propagate
- Inputs are recycled to common length
- If `x` and `y` are in different eras, `y` is transformed to `x`'s era

### `yr_later_than(x, y)`

Returns `TRUE` where `x` is chronologically later than `y`.

- For forward-counting eras: `x > y`
- For backward-counting eras: `x < y`
- Same NA, recycling, and era transformation behaviour as `yr_earlier_than()`

## Implementation

Add to `R/yr_sort_range.R`, alongside `yr_sort()`, `yr_earliest()`,
`yr_latest()`, and `yr_range()`.

```r
yr_earlier_than <- function(x, y) {
  if (!is_yr(x) || !is_yr(y)) {
    abort("Both `x` and `y` must be yr objects", class = "era_invalid_yr")
  }

  c(x, y) %<-% vec_recycle_common(x, y)

  if (yr_era(x) != yr_era(y)) {
    y <- yr_transform(y, yr_era(x))
  }

  if (era_direction(yr_era(x)) < 0) x > y
  else x < y
}

yr_later_than <- function(x, y) {
  if (!is_yr(x) || !is_yr(y)) {
    abort("Both `x` and `y` must be yr objects", class = "era_invalid_yr")
  }

  c(x, y) %<-% vec_recycle_common(x, y)

  if (yr_era(x) != yr_era(y)) {
    y <- yr_transform(y, yr_era(x))
  }

  if (era_direction(yr_era(x)) < 0) x < y
  else x > y
}
```

## Tests

Add to `tests/testthat/test-yr_sort_range.R`:

- Respects era direction (forward and backward)
- Handles NAs (propagates)
- Recycles inputs to common length
- Transforms between eras when needed
- Errors on non-yr inputs (class `era_invalid_yr`)

## Documentation

- Roxygen docs with `@family functions for chronological ordering and extremes`
  (same family as `yr_sort`, `yr_earliest`, etc.)
- Examples showing forward and backward-counting eras
- `NEWS.md` entry under development version
