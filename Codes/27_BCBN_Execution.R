#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
#################################################################################################################
library("rBCBN")
#################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2]
for (n in 4:N.Genes){
  Subsets<-combn(N.Genes,n)
  N.Subsets<-choose(N.Genes,n) 
  for (i in 1:N.Subsets){
    Data<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/B/Genotype",i,".dat"))
    Results<-bcbn_mcmc(data = Data, n_samples = 25000, theta = 0, epsilon = 0.05, n_chains = 4,thin = 10, Max_L =1000, n_cores = 1)
    save(Results,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/B/Results",i,".RData"))  
  }
}
#################################################################################################################
