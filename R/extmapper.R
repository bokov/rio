extmapper <- function(ext,..., .verbose=0, .whichreader = NULL,
                      .extmap.local = getOption("extmap.local",list())){
  backupxmap <- xmap <- if (ext %in% names(.extmap.local)) .extmap.local[[ext]]
          else if (ext %in% names(extmap)) extmap[[ext]]
          else stop("The file extension ",ext," is not currently supported.")
  # in cases where more than one reader available, attempt to select
  # the requested one
  if (!is.null(.whichreader)) {
    tempxmap <- grep(.whichreader, xmap, val=TRUE)
    xmap <- if (length(tempxmap)==1) tempxmap
            else if (length(tempxmap)<1) {
              warning("Requested reader not found, defaulting to ",xmap[1])
              xmap[1]}
            else {
              warning("More than one reader matches '.whichreader' pattern. ",
                      "Defaulting to ",tempxmap[1])
              tempxmap[1]
            }
  }
  backupxmap <- setdiff(backupxmap,xmap)
  xmap <- strsplit(xmap, "::", fixed=TRUE)[[1]]
  reqxmap <- xmap[1]
  while(!requireNamespace(xmap[1])){
    if (length(backupxmap)==0) stop("The requested package, ",reqxmap,
                                    " is not installed and no alternatives are installed")
    xmap <- strsplit(backupxmap[1], "::", fixed = TRUE)
    warning("The requested package, ", reqxmap, " is not installed, trying",
            backupxmap[1], " instead")
    backupxmap <- backupxmap[-1]
  }
  if (!requireNamespace(xmap[1])){
      if (backupavailable){
          warning("The library ", xmap[1], " is not installed\n",
                  "Trying to use ", backupxmap, " instead")
          xmap <- strsplit(backupxmap, "::", fixed = TRUE)
      } else {
          stop("The library ", xmap[1], " is not installed.")
      }
  }
  out <- argmapper(xmap[2],xmap[1],.verbose=.verbose,...)
}
