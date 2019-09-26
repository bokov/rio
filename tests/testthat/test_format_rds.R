context("Rds imports/exports")
require("datasets")

test_that("Export to rds", {
    expect_true(export(iris, "iris.rds") %in% dir())
})

test_that("Import from rds", {
    expect_true(is.data.frame(import("iris.rds")))
    expect_identical(import("iris.rds"), import_mapper("iris.rds"))
})

test_that("Export to rds (non-data frame)", {
    expect_true(export(list(1:10, letters), "list.rds") %in% dir())
    expect_true(inherits(import("list.rds"), "list"))
    expect_true(length(import("list.rds")) == 2L)
    expect_identical(import("list.rds"), import_mapper("list.rds"))
})

unlink("iris.rds")
unlink("list.rds")
