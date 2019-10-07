try_import <- function(file,which,
                       tryfirst = getOption('rio.tryfirst',
                                            c('xlsx','ods','xls','xml','rdata',
                                              'r','json','html')),
                       trylast = getOption('rio.trylast',c('dat','csvy','yml')),
                       nevertry = getOption('rio.nevertry',
                                            c('clipboard','fortran','csv',
                                              'csv2','psv','fwf','txt'
                                              ,'eviews')),
                       verbose = 1
                       ...){
  formatfound <- gsub('.import.rio_','',grep('^\\.import\\.rio_',
                                             methods(.import),value=TRUE))
  tryfirst <- intersect(tryfirst,formatfound)
  tryother <- setdiff(formats,c(tryfirst,trylast,nevertry))
  tryformats <- c(tryfirst,tryother,trylast)
  out <- try(import(file = file, which = which, ...),silent=TRUE)
  if (is(out,'try-error')){
    for (ii in tryformats){
      if(verbose > 0) message('Trying format: ',ii)
      out <- try(import(file = file, format = ii, which = which, ...)
                      ,silent=TRUE)
      if(is(out,'try-error')){
        out <- try(import(rv$infile,format=ii,which=1),silent=TRUE);
        if(!is(out,'try-error')){
          if (verbose > 0) warning('Specified table does not exist in file, ',
                                   'extracting first available table instead');
          break}
      } else break}}
  if (is(out,'try-error')) {
    stop('You have discovered an (as yet) unsupported file')}
  return(out)
}
