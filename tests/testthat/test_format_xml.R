context("XML imports/exports")
require("datasets")

test_that("Export to XML", {
    expect_true(export(iris, "iris.xml") %in% dir())
})

test_that("Import from XML", {
    expect_true(is.data.frame(import("iris.xml")))
    #expect_identical(import("iris.xml"), import_mapper("iris.xml"))
})

unlink("iris.xml")
