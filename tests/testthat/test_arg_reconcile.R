context("Reconcile user-supplied arguments with target function's call signature")
require("datasets")
require("tools")

sharedargs <- alist(x=iris,sep="\t",fileEncoding="UTF-8",showProgress=FALSE,
                    compress=FALSE)

test_that("warn on mismatched args and filter them out",{
  expect_warning(fwrite_args0 <- arg_reconcile(fwrite,fileEncoding="UTF-8",
                                               showProgress=FALSE,x=iris,
                                               compress=FALSE,file="iris.tsv",
                                               sep="\t"),
                 "fileEncoding")
  expect_identical(fwrite_args0,alist(showProgress=FALSE,x=iris,compress=FALSE,
                                      file="iris.tsv",sep="\t"))
  
  expect_warning(writetable_args0 <- arg_reconcile(write.table,
                                                  fileEncoding="UTF-8",
                                                  showProgress=FALSE,
                                                  x=iris,compress=FALSE,
                                                  file="iris.tsv",sep="\t"),
                 "showProgress")
  expect_identical(writetable_args0,alist(fileEncoding="UTF-8",x=iris,
                                         file="iris.tsv",sep="\t"))

  expect_warning(fwrite_args1 <- arg_reconcile(fwrite,file="iris.tsv",
                                               .args=sharedargs),"fileEncoding")
  expect_identical(fwrite_args0,fwrite_args1[names(fwrite_args0)])
  expect_identical(fwrite_args0[names(fwrite_args1)],fwrite_args1)
  
  expect_warning(writetable_args1 <- arg_reconcile(write.table,file="iris.tsv",
                                                   .args=sharedargs),"showProgress")
  expect_identical(writetable_args0,writetable_args1[names(writetable_args0)])
  expect_identical(writetable_args0[names(writetable_args1)],writetable_args1)
})

test_that(".remap argument remaps argument names",{
  expect_warning(dta_args0 <- arg_reconcile(haven::write_dta,encoding="UTF-8",
                                            showProgress=FALSE,x=iris,
                                            compress=FALSE,file="iris.dta",
                                            sep="\t",.remap = list(x='data',
                                                                   file='path'))
                 ,"sep")
  expect_identical(dta_args0,alist(data=iris,path="iris.dta"))
  expect_warning(sav_args0 <- arg_reconcile(haven::write_sav,encoding="UTF-8",
                                            showProgress=FALSE,x=iris,
                                            compress=FALSE,file="iris.sav",
                                            sep="\t",.remap = list(x='data',
                                                                   file='path'))
                 ,"sep")
  expect_identical(sav_args0,alist(compress=FALSE,data=iris,path="iris.sav"))
  expect_warning(dta_args1 <- arg_reconcile(haven::write_dta,file="iris.dta",
                                            .args=sharedargs),"sep")
  expect_identical(dta_args0,dta_args1[names(dta_args0)])
  expect_identical(dta_args0[names(dta_args1)],dta_args1)
  expect_warning(sav_args1 <- arg_reconcile(haven::write_sav,file="iris.sav",
                                            .args=sharedargs),"sep")
  expect_identical(sav_args0,sav_args1[names(sav_args0)])
  expect_identical(sav_args0[names(sav_args1)],sav_args1)
})

# TODO: ... overrides .args
# TODO: .warn = FALSE (expand the below version)
# TODO: .docall produces results identical to corresponding direct invokation
# TODO: do.call on *_args0 produces results identical to corresponding direct invokation

test_that("silently ignore mismatched args",{
  expect_silent(arg_reconcile(fwrite,fileEncoding="UTF-8",showProgress=FALSE,
                               x=iris,file="iris05.tsv",sep="\t",.warn=FALSE))
  expect_silent(arg_reconcile(write.table,fileEncoding="UTF-8",showProgress=FALSE,
                               x=iris,file="iris06.tsv",sep="\t",.warn=FALSE))
  expect_silent(arg_reconcile(fwrite,file="iris07.tsv",.args=sharedargs,
                              .warn=FALSE))
  expect_silent(arg_reconcile(write.table,file="iris08.tsv",.args=sharedargs,
                              .warn=FALSE))
})

rm(sharedargs)