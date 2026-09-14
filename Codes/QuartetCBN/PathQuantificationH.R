#!/usr/bin/env Rscript
###########################################################################################################################################################
source("./Codes/QuartetCBN/MainFunctions.R")
###########################################################################################################################################################
PathProbH<-function(num1,x){
  
  filename1<-paste0("./Data/Real_Data/Quartets/H/Genotype",num1,".lambda")
  LAMBDA<-as.numeric(read.table(filename1)$V1)
  filename2<-paste0("./Data/Real_Data/Quartets/H/Genotype",num1,"/00000.poset")
  DAG<-read.table(filename2)
  if (is.na(DAG)[1]==TRUE){DAG<-matrix(0,0,0)}
  PathProb<-PathProb_CBN(DAG,LAMBDA,x)
  return(PathProb)
  
}
###########################################################################################################################################################

