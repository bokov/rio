context("SAS imports/exports")
require("datasets")

#test_that("Import from SAS (.sas7bdat)", {})
test_that("Export SAS (.xpt)", {
    expect_true(export(mtcars, "mtcars.xpt") %in% dir())
})

test_that("Import from SAS (.xpt)", {
    expect_true(inherits(import("mtcars.xpt"), "data.frame"))
    expect_identical(import("mtcars.xpt"), import_mapper("mtcars.xpt"))
})

test_that("Export SAS (.sas7bdat)", {
    expect_true(export(mtcars, "mtcars.sas7bdat") %in% dir())
})

test_that("Import from SAS (.sas7bdat)", {
  expect_true(inherits(import("mtcars.sas7bdat"), "data.frame"))
  expect_identical(import("mtcars.sas7bdat"), import_mapper("mtcars.sas7bdat"))
})

unlink("mtcars.sas7bdat")
unlink("mtcars.xpt")
