#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1]
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/03_SyntheticDataGeneration_Functions.R"))
######################################################################################################################################################################################################Associated_TNBC<-read.csv("/Users/rzgar/Desktop/Research/ENCORE_LIBRARY/OLD/Associated_TNBC.csv")
######################################################################################################################################################################################################Associated_TNBC<-read.csv("/Users/rzgar/Desktop/Research/ENCORE_LIBRARY/OLD/Associated_TNBC.csv")
### Synthetic Data Generation 

ALL_Genotypes<-matrix(c(0,1,0,0,0,1,1,1,0,0,0,1,1,1,0,1,0,0,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,0,1,0,0,1,0,1,0,1,1,0,1,1,1,0,0,0,0,1,0,0,1,0,1,1,0,1,1,1,1),nrow=16,ncol=4)
Samples1<-list()### without Mutual Exclusivity
Samples2<-list()### with Mutual Exclusivity

for (i in 1:219){
  
  Posets<-read.table(file=paste0(DIR,"/Data/Posets4/poset",i,".dat"),sep=" ")
  
  Samples1[[i]]<-Sampling_Genotypes(ALL_Genotypes,Posets,200,0.8,0)#without mutual exclusivity
  write.table(Samples1[[i]],file=paste0(DIR,"/Data/Synthetic_Data/Genotypes/Without_Mutual_Exclusivity/genotype",i,".dat"),row.names = FALSE, col.names = FALSE)
  
  Samples2[[i]]<-Sampling_Genotypes(ALL_Genotypes,Posets,200,0.8,1)#with mutual exclusivity
  write.table(Samples2[[i]],file=paste0(DIR,"/Data/Synthetic_Data/Genotypes/With_Mutual_Exclusivity/genotype",i,".dat"),row.names = FALSE, col.names = FALSE)
}

