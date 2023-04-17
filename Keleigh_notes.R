#Trying out some documentations stuff
#press control, alt, shift, R for roxygenation, when your cursor is in the function
#' Title
#'
#' @param .df A data frame that is from the SMAS lab
#'
#' @return A data frame that was renamed to temp.df,and avialable in the global environment
#' @export
#'
#' @examples
#' #rename the lab data 
#' keleigh(lab.data)
#' #rename the internal data
#' keleigh(internal.data)
#' 
keleigh<-function(.df){
  .df<-temp.df
}

#to make the .rd file you run, these are essentially the "help" files
devtools::document()

#############################################################################
#to check your function/package you can run
devtools::check()
