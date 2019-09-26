argmap <- list(
  "base::load" = list(
    defaults = list(envir=new.env()),
    postprocess = function(xx,callenv=parent.frame()){
        args <- callenv$aa
        if (!'which' %in% names(args)) {
            if (length(args$envir) > 1) {
              # warning('Objects: ',paste0(ls(args$envir),collapse=','),
              #         '\nArgs:',paste0(names(args),collapse=','))
              warning("Rdata file contains multiple objects. Returning first object.")
            }
            args$which <- 1
        }
        # return value from the environment
        with(args,
             if (is.numeric(which)) {
                get(ls(envir)[which], envir)
             } else {
                get(ls(envir)[grep(which, ls(envir))[1]], envir)
             })
    }
  ),
  "haven::read_dta" = list(postprocess = standardize_attributes),
  "foreign::read.dta" = list(
    defaults = list(convert.dates = TRUE,convert.factors = FALSE,
                    missing.type = FALSE),
    postprocess = function(xx) {
      attr(xx, "expansion.fields") <- NULL
      attr(xx, "time.stamp") <- NULL
      standardize_attributes(xx)
    }
  ),
  "hexView::readEViews" = list(
    args = c(file = 'filename')
  ),
  "feather::read_feather" = list(
    args = c(file="path")
  ),
  "utils::read.fortran" = list(
    args = c(style = "format")
  ),
  "fst::read.fst" = list(
    args = c(file = "path")
  ),
  "jsonlite::fromJSON" = list(
    args = c(file = "txt")
  ),
  "rmatio::read.mat" = list(
    args = c(file = "filename")
  ),
  # bunch of other formats...
  "readxl::read_xls" = list(
    args = c(file="path", which="sheet", nrows = "n_max")
  ),
  "readxl::read_xlsx" = list(
    args = c(file="path", which="sheet")
  ),
  "openxlsx::read.xlsx" = list(
    args = c(file="xlsxFile", which="sheet", n_max = "nrows")
  ),
  "readODS::read_ods" = list(
    args = c(file="path", which="sheet", header = "col_names")
  ),
  "haven::read_sas" = list(
    args = c(file = "data_file"),
    postprocess = standardize_attributes
  ),
  "haven::read_sav" = list(
    postprocess = standardize_attributes
  ),
  "foreign::read.spss" = list(
    defaults = list(to.data.frame = TRUE, use.value.labels = FALSE),
    postprocess = standardize_attributes
  ),
  "yaml::read_yaml" = list(
    postprocess = function(xx) as.data.frame(xx, stringsAsFactors = FALSE)
  ),
  "default" = list(
    args = c(),
    defaults = list(),
    postprocess = identity
  )
);
