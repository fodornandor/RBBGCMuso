% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/outputMapping.R
\name{musoMappingFind}
\alias{musoMappingFind}
\title{musoMappingFind}
\usage{
musoMapping(code, mapData=NULL)
}
\arguments{
\item{variable}{If this is null, return the whole mapping table. In other cases search for the variable code}
}
\value{
The code of the specific output variable name
}
\description{
musoMappingFind can provide us the code of the Biome-BGCMuSo output variable name. Within Biome-BGCMuSo the state variables and fluxes are marked by integer numbers. In order to provide meaningful variable names (e.g. 3009 means Gross Primary Production) a conversion table is needed which is utilized by this function. This function converts variable names into codes. musoMapping does the opposite.
}
\author{
Roland HOLLOS
}
