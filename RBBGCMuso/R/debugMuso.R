#'rungetMuso
#'
#' This function runs the Biome-BGCMuSo model and reads its outputfile in a well structured way.
#' 
#' @author Roland Hollos
#' @keywords internal
#'
## degubMuso <- function(inputloc,outputloc,debugging,errorsign,){

    
##     if((debugging=="stamplog")|(debugging==TRUE)){#If debugging option turned on
##                                         ##If log or ERROR directory does not exists create it!
##         dirName<-paste(inputloc,"LOG",sep="") 
##         dirERROR<-paste(inputloc,"ERROR",sep="")
        
##         if(!dir.exists(dirName)){
##             dir.create(dirName)
##         }

##         if(!dir.exists(dirERROR)){
##             dir.create(dirERROR)
##         }
##     }

##  if(debugging=="stamplog"){
##         stampnum<-stamp(dirName)
##         if(inputloc==outputloc){
##             lapply( logfiles, function (x) file.rename(from=paste(outputloc,x, sep=""), to=paste(dirName, "/",(stampnum+1),"-",x,sep="")))
            
##         } else {
##             lapply( logfiles, function (x) file.rename(from=paste(outputloc,x, sep="/"), to=paste(dirName, "/",(stampnum+1),"-",x,sep="")))
##         }
        
##         if(errorsign==1){
##             lapply( logfiles, function (x) file.copy(from=paste(dirName, "/",(stampnum+1),"-",x,sep=""), to=dirERROR  ))}

##     } else { if(debugging){
##                  if(is.null(logfilename)){

##                      if(inputloc==outputloc){
##                           lapply( logfiles, function (x) file.rename(from=paste(outputloc,x, sep=""), to=paste(dirName,"/", x, sep="")))
##                      } else {
##                          lapply( logfiles, function (x) file.rename(from=paste(outputloc,x, sep="/"), to=paste(dirName,"/", x, sep="")))     
##                      }

##                      if(errorsign==1){
##                          lapply( logfiles, function (x) file.rename(from=paste(dirName,"/", x, sep=""), to=dirERROR))
##                      }

##                  } else {

##                      if(inputloc==outputloc){#These are very ugly solutions for a string problem: inputloc: "./", if outputloc equalent of inputloc, it ends with "/", the string manipulation can not handle this. The better solution is easy, but I dont have enough time(Roland Hollo's) 
##                          lapply( logfiles, function (x) file.rename(from=paste(outputloc,x, sep=""), to=paste(dirName, "/",logfilename,"-",x,sep="")))                        
##                      } else {
##                          lapply( logfiles, function (x) file.rename(from=paste(outputloc,x, sep="/"), to=paste(dirName, "/",logfilename,"-",x,sep="")))    
##                      }
                     
##                      if(errorsign==1){
##                          lapply( logfiles, function (x) file.rename(from=paste(dirName, "/",logfilename,"-",x,sep=""), to=dirERROR))
##                      }
##                  }    
                 
##              }}
    

## return(errorsign)

## }
