#' updateMusoMapping
#'
#' This function updates the Biome-BGCMuSo output code-variable matrix. Within Biome-BGCMuSo the state variables and fluxes are marked by integer numbers. In order to provide meaningful variable names (e.g. 3009 means Gross Primary Production in Biome-BGCMuSo v5) a conversion table is needed which is handled by this function. 
#' @author Roland HOLLOS
#' @param output_map_init The output code-variable bindings are described in output_map_init.c file that is part of the Biome-BGCMuSo source code. Using this function the user can read the output_map_init.c file and pass it to RBBGCMuso for further work.
#' @return The output code-variable matrix, and also the function changes the global variable
#' @export
#' @usage updateMusoMapping(output_map_init="output_map_init.c")

updateMusoMapping<-function(output_map_init="output_map_init.c"){
    
    outputRaw<-grep("\\[",readLines(output_map_init,-1),value=TRUE)

    codes <- as.vector(lapply(outputRaw, function (x)  as.numeric(unlist(strsplit(unlist(strsplit(x,"\\["))[2],"\\]"))[1])))
    names <- unlist(lapply(outputRaw, function (x) unlist(strsplit(unlist(strsplit(x,"\\&"))[2],";"))[1]))
    mMapping <-cbind(codes,names)
    save(mMapping, file="mMap.RData")
    return(mMapping)
}

#' musoMapping
#'
#' musoMapping can provide the user the name of a Biome-BGCMuSo output code. Within Biome-BGCMuSo the state variables and fluxes are marked by integer numbers. In order to provide meaningful variable names (e.g. 3009 means Gross Primary Production) a conversion table is needed which is utilized by this function. This function converts variable codes into names musoMappingFind does the opposite.
#' @author Roland HOLLOS
#' @param code the MuSo outputcode
#' @param mapData updateMusomapping generated matrix
#' @return The name of the Biome-BGCMuSo output code (e.g. if code is 3009 this function should return GPP to the user)
#' @export
#' @usage musoMapping(code, mapData=NULL)


musoMapping <- function(code, mapData=NULL){
    if(is.null(mapData)){
        return(unlist(mMapping[which(mMapping[,1]==code),2])) #mMapping is package-scoped system variable generated by udateMusoMapping
    } else {
        return(unlist(mapData[which(mapData[,1]==code),2]))
    }
}


#' musoMappingFind
#'
#' musoMappingFind can provide us the code of the Biome-BGCMuSo output variable name. Within Biome-BGCMuSo the state variables and fluxes are marked by integer numbers. In order to provide meaningful variable names (e.g. 3009 means Gross Primary Production) a conversion table is needed which is utilized by this function. This function converts variable names into codes. musoMapping does the opposite.
#' @author Roland HOLLOS
#' @param variable If this is null, return the whole mapping table. In other cases search for the variable code
#' @return The code of the specific output variable name
#' @export
#' @usage musoMapping(code, mapData=NULL)


musoMappingFind <- function(variable=NULL){
    if(is.null(variable)){
        return(mMapping)
    } else {
                            mMapping[grep(variable,mMapping[,2]),]
                    }
}

