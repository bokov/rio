context("EViews import")

test_that("Import from EViews", {
    skip_if_not_installed(pkg="hexView")
    expect_true(is.data.frame(dd <- suppressWarnings(import(hexView::hexViewFile("data4-1.wf1")))))
    expect_identical(dd,suppressWarnings(import_mapper(hexView::hexViewFile("data4-1.wf1"))),
                     label="import_mapper() can replicate import()")
})
