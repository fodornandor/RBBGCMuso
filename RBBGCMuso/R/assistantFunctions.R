#' getLogs
#'
#'This function gives us the muso logfiles with their path
#'
#'@param outputLoc This is the location of the output files.
#'@param outputNames These are the prefixes of the logfiles
#'@return Logfiles with paths
#'@keywords internal


getLogs <- function(outputLoc, outputNames, type = "spinup"){
    switch(type,
           "spinup" = return(grep(paste0(outputNames[1], ".log"), list.files(outputLoc), value = TRUE)),
           "normal" = return(grep(paste0(outputNames[2], ".log"), list.files(outputLoc), value = TRUE)),
           "both" = return(sapply(1:2, function (x){grep(paste0(outputNames[x], ".log"), list.files(outputLoc), value = TRUE)})))
}


#' readErrors
#'
#'This function reads the spinup and the normal logfiles and gives back the last line which indicates weather there are any errors during the model execution or not.
#'
#'@param outputLoc This is the location of the output file.
#'@param logfiles These are the names of the logfiles.
#'@return vector with 0 and 1 values, 1, if succed, 0 if not. The first is the spinup run, the second is the normal.
#'@keywords internal


readErrors <- function(outputLoc, logfiles, type = "both"){

    if(length(logfiles)==0){
        if(type=="normal"){
            return(1)
        } else {
            return(c(0,0))
        }
    } 
        
    
    switch( type,
           "both" = return(
               as.numeric(
                   as.vector(
                       lapply(paste(outputLoc,logfiles,sep = "/"),
                              function(x) {
                                  tail(readLines(x,-1),1) 
                              }
                              )
                   )
               )
           ),
           "spinup" = print("spinup"),
           "normal" = return(
               abs(as.numeric(tail(readLines(file.path(outputLoc,logfiles),-1),1))-1)
           )
           )
}

#' getOutFiles
#'
#'This function gives us the muso output files with their paths
#'
#'@param outputLoc This is the location of the output files.
#'@param outputNames These are the prefixes of the logfiles.
#'@return Output files with their paths.
#'@keywords internal


getOutFiles <- function(outputLoc, outputNames){

    return(grep("out$", grep(paste(paste0(outputNames, "*"), collapse = "|"), list.files(outputLoc), value=TRUE), value = TRUE))
}

#' stampAndCopy
#'
#'This function gives us the model output files with their paths
#'
#'@param outputLoc This is the location of the output files.
#'@param outputNames These are the prefixes of the logfiles
#'@return Output files with their paths
#'@keywords internal

stampAndDir <- function(outputLoc,names,stampDir, wrongDir, type="output", errorsign, logfiles){

    switch(type,
        "output" = (
           file.copy(file.path(outputLoc,names)
                            ,file.path(stampDir,paste0((stamp(stampDir)+1),"-",names))) ),
        "general" = (function (){
            stampnum <- stamp(stampDir)
            lapply(names,function (x) file.copy(from = x ,to=paste(stampDir,"/",(stampnum+1),"-", basename(x),sep="")))
            if(errorsign==1){
                lapply(names, function (x) file.copy(from = paste(stampDir,"/",(stampnum+1),"-",basename(x),sep=""), to=wrongDir))}})()

    )

}



compareNA <- function(v,a){
    compared<- (v==a)
    compared[is.na(compared)] <- FALSE
    return(compared)
}

#' dynRound
#'
#'This function rounds a sequence (definded by its endpoints and the length) optimally
#'
#'@param  x The lower end of the sequence
#'@param y The higher end of the sequence
#' @param seqLen The length of the sequence
#'@return rounded sequence
#'@keywords internal

dynRound <- function(x,y,seqLen){
    digitNum <- 2
    a <- seq(x,y, length = seqLen)
    while(length(a) != length(unique(round(a,digitNum)))){
        digitNum <- digitNum +1
    }
    
    return(round(a,digitNum))
}

