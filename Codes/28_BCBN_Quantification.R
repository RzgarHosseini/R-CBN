#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"10_BCBN_Functions.R"))
#################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2]

#################################################################################################################
### BCBN
for (n in 4:N.Genes){
  Subsets<-combn(N.Genes,n)
  N.Subsets<-choose(N.Genes,n)
  PathProbB<-matrix(0,N.Subsets,factorial(n))
  for (i in 1:N.Subsets){
    if (n==4){FINAL<-PathProbQuantifyB4(DIR,subDIR,InputFileName,n,i)} else {FINAL<-PathProbQuantifyB(DIR,subDIR,InputFileName,n,i)}
    for (j in 1:factorial(n)){
      PathProbB[i,j]<-FINAL[j] 
    }
  }
  save(PathProbB,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/B/PathProbB.RData"))
}
#################################################################################################################
