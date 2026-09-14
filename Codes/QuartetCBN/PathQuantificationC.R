#!/usr/bin/env Rscript
###########################################################################################################################################################
source("./Codes/QuartetCBN/MainFunctions.R")
###########################################################################################################################################################
PathProbC<-function(num1,x){
  
  filename1<-paste0("./Data/Real_Data/Quartets/C/Results",num1,".dat")
  
  mat<-read.table(filename1)
  INDX<-which.max(mat[,4])#maximum likelihood DAG
  ZINDX<-mat[INDX,1]
  LAMBDA<-as.numeric(mat[INDX,5:(5+x)])
  
  strg<-paste0("00000",as.character(ZINDX))
  start_pos <- nchar(strg) - 4
  NumStr<-substr(strg, start_pos, nchar(strg))
  
  filename2<-paste0("./Data/Real_Data/Quartets/C/Genotype",num1,"/",NumStr)
  
  DAG<-readPoset(filename2)$sets
  if (is.na(DAG)[1]==TRUE){DAG<-matrix(0,0,0)}
  PathProb<-PathProb_CBN(DAG,LAMBDA,x)
  return(PathProb)
}
###########################################################################################################################################################





