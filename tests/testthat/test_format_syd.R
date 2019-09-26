context("Systat (.syd) imports/exports")

test_that("Import from Systat", {
    expect_true(inherits(dd <- import(system.file("files/Iris.syd"
                                                  , package="foreign")[1])
                         , "data.frame"))
    expect_identical(dd, import_mapper(system.file("files/Iris.syd"
                                                  , package="foreign")[1]))
})
