#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
#################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2]
n<-5
Quartets<-combn(N.Genes,n)
N.Quartets<-choose(N.Genes,n)
#################################################################################################################
for (i in 1:N.Quartets){
  for (j in 1:4231){
    system(paste0("cp ",DIR,"/Data/Posets5/poset",j,".poset ",DIR,"/",subDIR,"/",InputFileName,"_Quintet/R/Genotype",i,".poset"))
    system(paste0(DIR,"/ct-cbn-0.1.04b/ct-cbn -f ",DIR,"/",subDIR,"/",InputFileName,"_Quintet/R/Genotype",i,"|tail -1>>",DIR,"/",subDIR,"/",InputFileName,"_Quintet/R/Results",i,".dat"))
    system(paste0("rm ",DIR,"/",subDIR,"/",InputFileName,"_Quintet/R/Genotype",i,".poset"))
  }
}

