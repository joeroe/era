# era 0.2.1

Second beta / CRAN pre-release.

* Added new era definitions:
  * Islamic calendars (Lunar Hijri, Solar Hijri).
* Reworked era definition scheme:
  * Direction is now coded as `1` ("forwards") or `-1` ("backwards"). The previous character arguments still work but are deprecated.
* Improved `yr_transform()`:
  * Now has a `precision` argument, allowing the result to be rounded (#23).
* `era` and `yr` objects are now validated when constructed, using new functions `validate_era()`/`is_valid_era()` and `validate_yr()`/`is_valid_yr()` (#7 and #8).
* Bug fixes:
  * `era(NA)` now returns an error, not a vector of all standard eras (#20).

# era 0.2.0

First beta release, including:

* S3 vector class `yr` (`era_yr`) representing years with an era
  * `yr()` constructor
  * Functions for getting and setting the era of a `yr` object: `yr_era()`, `yr_era()<-` and `yr_set_era()`
  * Format and print methods for `yr`s
  * Vector arithmetic methods for `yr`s
* S3 record class `era` representing an era definition
  * `era()` constructor
  * Format and print methods for `era`s
  * Getter functions for era parameters: `era_label()`, `era_name()`, `era_epoch()`, `era_unit()`, `era_scale()`, `era_direction()`
  * `eras()` defining standard eras
* `yr_transform()` function for converting years between eras
* Function documentation and introductory vignette: `vignette("era")`
* A `NEWS.md` file to track changes to the package.

# era 0.1.0

Initial development version.
