#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
library("rBCBN")
Data<-read.table(paste0("./Data/Real_Data/Quartets/B/Genotype",args[1],".dat"))
Results<-bcbn_mcmc(data = Data, n_samples = 25000, theta = 0, epsilon = 0.05, n_chains = 4,thin = 10, Max_L =1000, n_cores = 1)
save(Results,file=paste0("./Data/Real_Data/Quartets/B/Results",args[1],".RData"))
