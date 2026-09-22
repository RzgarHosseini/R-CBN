#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/07_EnsembleRCBN_Functions.R"))
###########################################################################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2]
###########################################################################################################################################################################
load(file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n4/R/PathProbR.RData")) ## Quartet-RCBN-based pathway probabilities obtained from "18_QuartetRCBN_Quantification.R"
###########################################################################################################################################################################
EnsembleRCBN(PathProbR,N.Genes,DIR,subDIR,InputFileName)
### Comments on Running Time:
## The 1st iteration: Quantifying the probabilities of 5! pathways of length 5 is done in 10 seconds
## The 2nd iteration: Quantifying the probabilities of 6! pathways of length 6 is done in 3 minutes
## The 3rd iteration: Quantifying the probabilities of 7! pathways of length 7 is done in 42 minutes
## The 4th iteration: Quantifying the probabilities of 8! pathways of length 8 is done in 12 hours
## The 5th iteration: Quantifying the probabilities of 9! pathways of length 9 is done in 4 days            [Efficient execution requires parallelization on an HPC server]
## The 6th iteration: Quantifying the probabilities of 10! pathways of length 10 requires more than a month [Efficient execution requires parallelization on an HPC server]




