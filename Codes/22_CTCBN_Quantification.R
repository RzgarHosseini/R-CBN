#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/08_CTCBN_Functions.R"))
#################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2]

for (n in 4:N.Genes){
  Subsets<-combn(N.Genes,n)
  N.Subsets<-choose(N.Genes,n)
  PathProbC<-matrix(0,N.Subsets,factorial(n))
  for (i in 1:N.Subsets){
    FINAL<-PathProbQuantifyC(DIR,subDIR,InputFileName,n,i)
    for (j in 1:factorial(n)){
      PathProbC[i,j]<-FINAL[j] 
    }
  }
  save(PathProbC,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/PathProbC.RData"))
}

#################################################################################################################

