Follow the [tidyverse style guide](https://style.tidyverse.org/). The sections below note deviations and additions.

## Workflow

The steps below describe the full TDD workflow for **new features**. Adjust
the workflow as appropriate for other kinds of changes:

* **Bug fixes:** Start by writing a failing test that reproduces the bug
  (step 2), then implement the fix (step 3). Documentation (step 1) is
  only updated if the fix changes documented behaviour.
* **Refactoring:** Skip steps 1 and 2. Implementation (step 3) is followed
  by running the existing tests to confirm behaviour is unchanged.
* **Documentation-only changes:** Skip steps 2 and 3. Just update the
  documentation and regenerate any affected `man/` pages or `NAMESPACE`.

In all cases, finish with the final checks (step 4).

1. Update documentation to reflect the user's instructions.
   Documentation is the human-readable, user-facing source of truth
   for package behaviour. If something is unclear, ask the user.

2. Write tests based on the documentation.
   This is pure TDD: write tests first, before any implementation.
   Include tests for edge cases, even if not explicitly mentioned in
   the documentation. If the documentation is ambiguous about a
   behaviour, ask the user before writing the test.

3. Delegate implementation to a sub-agent.
   The sub-agent writes code and runs tests in a loop until all tests
   pass. The sub-agent must not modify tests or documentation.
   
   If the sub-agent cannot pass the tests or encounters a problem, it
   reports back. The main agent then decides whether to:
   * Modify the tests (if they are incorrect or incomplete)
   * Modify the documentation and tests (if the instructions were
     unclear or wrong)
   * Report back to the user (if the task cannot be completed as
     specified)

4. Run final checks.
   Delegate `devtools::check()` and `lintr::lint_package()` to a
   sub-agent. Fix any issues reported. Repeat until both pass cleanly.

## Naming

* Prefix function names based on the type of input they expect. E.g. `c14_*()`
  functions work with raw radiocarbon data; `cal_*()` with calibrated
  distributions; `strat_*()` with stratigraphic data frames; `strg_*()` with
  stratigraphic graph objects; `control_*()` with controlled vocabularies.
* Clarity over concision. Spell out whole words; avoid acronyms and
  abbreviations. E.g. `cal_function()` not `cal_fn()` or `cal_func()`.
* Helper functions should be placed below the functions that call them.

## Functional style

* Functions should do one thing only and have no side-effects unless strictly
  necessary.
* Functions should be vectorized by default, building on existing vectorized
  functions where possible.
* If vectorization is not possible, use a map-apply pattern with purrr (if it
  is already a dependency) or the base apply() family.
* Never use for loops.
* Use the native pipe `|>`, not magrittr's `%>%`.

## Classes

* Use S3. Use vctrs when the class describes a vector.
* Follow the constructor pattern: a public constructor that validates inputs,
  an internal `new_*()` constructor that does not, and `is_*()` /
  `validate_*()` predicate and validator functions.
* Validate on construction.

## Error handling

* Use `rlang::abort()` and `rlang::warn()` for all conditions.
* Define package-prefixed condition classes (e.g.
  `"<pkg>_invalid_argument"`).
* Use named character vectors for structured messages (e.g. `x` for errors,
  `i` for hints).

## Documentation and testing

* Document with roxygen2 (markdown enabled). Build the website with pkgdown
  (Bootstrap 5 template). Write vignettes with knitr.
* Test with testthat (edition 3). Use `spelling` to check prose. Track
  coverage with covr.
* Use British English (`en-GB`) for all prose.

## Test structure

* **File organisation:** One test file per source file
  (`tests/testthat/test-<source>.R`), with shared inputs defined as
  top-level assignments.
* **`test_that()` descriptions:** Format as `<function>() <behaviour>`
  (e.g. `"as_cal_dist.matrix works"`, `"cal() recycles inputs to common
  length"`). For error conditions, name the condition class in the
  description (e.g. `"cal() errors with class c14_invalid_curve for
  non-curve input"`).
* **Error and warning testing:** Test conditions by class only. If a regex
  is needed, the condition is missing an appropriate class and should be
  fixed.

## Quality and tooling

* Use lintr with its default (tidyverse) configuration. Each package should
  have a `.lintr` file.
* Use `devtools::test()` during development to test specific functionality
  without running a full check.

## References

Consult these if unsure about a style or pattern:

* <https://style.tidyverse.org/>
* <https://r-pkgs.org/>
* <https://adv-r.hadley.nz/>
