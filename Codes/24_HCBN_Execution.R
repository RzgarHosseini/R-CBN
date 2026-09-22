#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
#################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2]
for (n in 4:N.Genes){
  Subsets<-combn(N.Genes,n)
  N.Subsets<-choose(N.Genes,n) 
  for (i in 1:N.Subsets){
    system(paste0(DIR,"/ct-cbn-0.1.04b/h-cbn -f ",DIR,"/",subDIR,"/",InputFileName,"_n",n,"/H/Genotype",i," -s -T 1 -N 10000 -w"))
  }
}
#################################################################################################################

