#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/06_QuartetRCBN_Functions.R"))
#################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2]
n<-4
Quartets<-combn(N.Genes,n)
N.Quartets<-choose(N.Genes,n)
#################################################################################################################
PathProbR<-matrix(0,N.Quartets,factorial(n))
for (i in 1:N.Quartets){
  TEMP<-PathProbQuantifyR(DIR,subDIR,InputFileName,n,i)
  FINAL<-Path_Normalization(TEMP,n)
  for (j in 1:factorial(n)){
    PathProbR[i,j]<-FINAL[j] 
  }
}
save(PathProbR,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n4/R/PathProbR.RData"))

