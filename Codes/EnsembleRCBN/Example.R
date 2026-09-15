#!/usr/bin/env Rscript
###########################################################################################################################################################
source("./Codes/QuartetCBN/MainFunctions.R")
source("./Codes/EnsembleRCBN/EnsembleRCBN.R")
#################################################################################################################
#################################################################################################################
Geno10<-read.table("./Data/Real_Data/Genotypes/Glioblastoma_Multiforme.dat")
Sample.Size<-dim(Geno10)[1]
Quartets<-combn(10,4)
N.Quartets<-choose(10,4)

load("./Data/Real_Data/Quartets/R/PathProbR.RData") ## This is obtained from step 5 of the Quartet R-CBN pipeline.

DIR<-"./Data/Real_Data/Others/R/"
N<-10
PathProbs<-PathProbR

#################################################################################################################
#################################################################################################################
EnsembleRCBN(PathProbs,N,DIR)




