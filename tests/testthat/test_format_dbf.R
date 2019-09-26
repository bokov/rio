context("XBASE (.dbf) imports/exports")
require("datasets")

test_that("Export to XBASE (.dbf)", {
    expect_true(export(iris, "iris.dbf") %in% dir())
})

test_that("Import from XBASE (.dbf)", {
    expect_true(is.data.frame(import("iris.dbf")))
    expect_identical(import("iris.dbf"),import_mapper("iris.dbf"))
})

unlink("iris.dbf")
