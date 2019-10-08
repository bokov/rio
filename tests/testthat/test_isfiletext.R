context("correctly identifying files as text vs binary")
require("datasets")

txtformats <- c('arff','csv','csv2','csvy','dump','fwf','html','json','psv',
                 'r','tsv','txt','xml','yml')
binformats <- c('dbf','dta','feather','fst','matlab','ods','rda','rdata','rds',
                'sas7bdat','sav','xlsx','xpt')
names(iris) <- gsub('\\.','_',names(iris))
for(xx in txtformats) expect_true(isfiletext(export(iris,paste0('iris.',xx))),
                                  label = paste0(xx,' should be text'))
expect_true(isfiletext(export(iris[,-5],'iris.pzfx')),
            label = 'pzfx should be text')
for(xx in binformats) expect_false(isfiletext(export(iris,paste0('iris.',xx))),
                                  label = paste0(xx,' should be binary'))
# Read when they shouldn't...
# csv, csv2, psv, tsv, txt, yml

# Too nitpicky to call programatically
# fwf