#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/11_FitnessLandscapeSSWM_Functions.R"))
#####################################################################################################################################################
Fitness<-as.matrix(readRDS(paste0(DIR,"/Data/Simulated_Data/FitnessLandcapes.rds")))
## Fitness is matrix of dimension 128 by 100 encoding fitness of 2^7=128 binary genotypes on 100 representable fitness landscapes. 
## The set of 128 binary genotypes corresponding to the rows of the above matrix can be obtained by: AllGenotypes7<-generate_matrix_genotypes(7)
PathProbs7<-matrix(0,5040,100)
for (i in 1:100){
  PathProbs7[,i]<-pathProbSSWM(Fitness[,i],7)
}
## PathProbs7 is matrix of dimension 5040 by 100 encoding probability of all 7!=5040 mutational pathways of length n=7 on each of the 100 representable fitness landscapes.
## The set of 5040 pathways corresponding to the rows of the above matrix can be obtained by: AllPathways7 <- permutations(7, 7)

Predictability7<-numeric(100)
for (i in 1:100){
  Predictability7[i]<-predictability(PathProbs7[,i],7)
}
## Predictability7 encodes the SSWM-based predictability on each of the 100 fitness landscapes.


JSD7<-matrix(0,100,100)
for (i in 1:100){
  for (j in 1:100){
    JSD7[i,j]<-jensenShannonDivergence(PathProbs7[,i],PathProbs7[,j])
  }
}
## JSD7 encodes the pairwise Jensen-Shannon Divergence between the SSWM-based probability distributions on all pairs of the 100 representable fitness landscapes.

