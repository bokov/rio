argmapper <- function(fn,lib,...,.verbose=0,
                      .argmap.local = getOption('argmap.local',list()),
                      alwaysArgs=NULL,.functions=list(),.ignoreUnusedArgs=TRUE){
  aa <- list(...)
  libfn <- paste(lib,fn,sep="::")
  mappings <- if (libfn %in% names(.argmap.local)) .argmap.local[[libfn]]
              else if (libfn %in% names(argmap)) argmap[[libfn]] 
              else argmap$default
  # map the standardized arguments function-specific arguments
  for (ii in intersect(names(aa),names(mappings$args))){
    aa[[mappings$args[ii]]] <- aa[[ii]]}
  # set any missing required function-specific arguments 
  for (ii in setdiff(names(mappings$defaults),names(aa))) {
    aa[[ii]] <- mappings$defaults[[ii]]}
  # perform the function upon the final arguments
  objfun <- eval(substitute(lib::fn,list(lib=lib,fn=fn)))
  out <- R.utils::doCall(objfun, args=aa, alwaysArgs=alwaysArgs, 
                         .functions = c(list(objfun), .functions), 
                         .ignoreUnusedArgs = .ignoreUnusedArgs)
  # return the result
  if (! is.null(mappings$postprocess)) mappings$postprocess(out) else out
}
