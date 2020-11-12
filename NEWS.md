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
