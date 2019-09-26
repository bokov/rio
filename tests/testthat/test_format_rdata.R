context("Rdata imports/exports")
require("datasets")

test_that("Export to Rdata", {
    # data.frame
    expect_true(export(iris, "iris.Rdata") %in% dir())
    # environment
    e <- new.env()
    e$iris <- iris
    expect_true(export(e, "iris.Rdata") %in% dir())
    # character
    expect_true(export("iris", "iris.Rdata") %in% dir())
    # expect error otherwise
    expect_error(export(iris$Species, "iris.Rdata") %in% dir())
})

test_that("Import from Rdata", {
    save(iris, mtcars, file="multi.Rdata")
    expect_warning(import("multi.Rdata"),
                   "Rdata file contains multiple objects. Returning first object.")
    expect_warning(import_mapper("multi.Rdata"),
                   "Rdata file contains multiple objects. Returning first object.")
    expect_true(is.data.frame(import("multi.Rdata", which = 1)))
    expect_identical(import("multi.Rdata", which = 1), 
                     import_mapper("multi.Rdata", which = 1))
    expect_identical(import("multi.Rdata", which = 2), 
                     import_mapper("multi.Rdata", which = 2))
})

test_that("Export to rda", {
    expect_true(export(iris, "iris0.rda") %in% dir())
})

test_that("Import from rda", {
    expect_true(is.data.frame(import("iris0.rda")))
    expect_true(is.data.frame(import("iris0.rda", which = 1)))
    expect_identical(import("iris0.rda"), import_mapper("iris0.rda"))
})

unlink("iris.Rdata")
unlink("iris.rda")
unlink("iris0.rda")
unlink("multi.Rdata")
