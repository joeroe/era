# Contributing to era

era is free and open source (FOSS) software maintained in the interests of open science.
Contributions of all types are welcome.

## New era definitions

We are especially interested in expanding the [built-in eras](https://era.joeroe.io/articles/era.html#era-list) defined in the package.
These can be any calendar system or time scale that uses years.

To suggest an era for inclusion in the package, please create a new issue at https://github.com/joeroe/rpaleoclim/issues.

Or to implement it yourself, you can [fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repository, then:

1. Add a row to the `tribble` in `data-raw/era_table.R` with the [parameters of your new era](https://era.joeroe.io/articles/era.html#defining-other-eras)
2. "Source" `data-raw/era_table.R` to regenerate and export the new era table
3. Rebuild (`devtools::build()`) the package and check that your new era is now returned by `era("<label>")`
4. Run `devtools::check()` to build the package and run automated tests
5. Commit your changes

Then follow the [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow) and make a pull request with your new era.
If possible, please include sources for the era parameters you added in your pull request.

## Bug reports

To report a bug or problem, please create a new issue at https://github.com/joeroe/rpaleoclim/issues.
Please include as much information as possible and, if you can, a [minimal reproducible example](https://www.tidyverse.org/help/#reprex) ("reprex").

## Suggestions

To suggest an new feature or improvement, please create a new issue at https://github.com/joeroe/rpaleoclim/issues.

## Code

All contributions are welcome, but if possible please follow these conventions:

* For R code, follow the [tidyverse style guide](https://style.tidyverse.org/)
* For documentation, use [roxygen2](https://roxygen2.r-lib.org/)
* If you add new functionality, write unit tests for it with [testthat](https://testthat.r-lib.org/)
* Run `devtools::check()` to build the package and run tests before making a pull request

Then follow the [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow) and make a pull request with your contributions. 

## Questions and comments

For any other questions or comments on this software, please feel free to email the maintainer at <joe@joeroe.io>.
