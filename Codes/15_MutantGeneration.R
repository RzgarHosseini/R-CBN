#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1]
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/04_MutantGeneration_Function.R"))
########################################################################################################################################################################################################################################################################################
########################################################################################################################################################################################################################################################################################
### Example I: Generating mutated (synthetic) genotypes of varying FP and FN rates [Without mutual exclusivity]
FP<-c(0.0,0.1,0.2,0.3)
FN<-c(0.0,0.1,0.2,0.3)
for (i in 1:219){
  Samples<-read.table(file=paste0(DIR,"/Data/Synthetic_Data/Genotypes/Without_Mutual_Exclusivity/genotype",i,".dat"))
  for (j in 1:4){
    for (k in 1:4){
      Mutated_Samples<-Matrix_Mutator(Samples,FP[j],FN[k])
      write.table(Mutated_Samples,file=paste0(DIR,"/Data/Synthetic_Data/Genotypes/Without_Mutual_Exclusivity/Mutated_genotype",i,"_",FP[j],"_",FN[k],".dat"),row.names = FALSE, col.names = FALSE)
    }
  }  
}


########################################################################################################################################################################################################################################################################################
########################################################################################################################################################################################################################################################################################
### Example II: Generating mutated (synthetic) genotypes of varying FP and FN rates [With mutual exclusivity]
for (i in 1:219){
  Samples<-read.table(file=paste0(DIR,"/Data/Synthetic_Data/Genotypes/With_Mutual_Exclusivity/genotype",i,".dat"))
  for (j in 1:4){
    for (k in 1:4){
      Mutated_Samples<-Matrix_Mutator(Samples,FP[j],FN[k])
      write.table(Mutated_Samples,file=paste0(DIR,"/Data/Synthetic_Data/Genotypes/With_Mutual_Exclusivity/Mutated_genotype",i,"_",FP[j],"_",FN[k],".dat"),row.names = FALSE, col.names = FALSE)
    }
  }  
}


########################################################################################################################################################################################################################################################################################
########################################################################################################################################################################################################################################################################################
### Example III: Generating mutated (simulated) genotypes of varying FP and FN rates [Low Mutation Rate]
for (i in 1:100){
  Samples<-read.table(file=paste0(DIR,"/Data/Simulated_Data/Genotypes/Low_Mutation_Rate/genotype",i,".dat"))
  for (j in 1:4){
    Mutated_Samples<-Matrix_Mutator(Samples,FP[j],FN[j])
    write.table(Mutated_Samples,file=paste0(DIR,"/Data/Simulated_Data/Genotypes/Low_Mutation_Rate/Mutated_genotype",i,"_",FP[j],"_",FN[j],".dat"),row.names = FALSE, col.names = FALSE)
  }  
}


########################################################################################################################################################################################################################################################################################
########################################################################################################################################################################################################################################################################################
### Example IV: Generating mutated (simulated) genotypes of varying FP and FN rates [High Mutation Rate]
for (i in 1:100){
  Samples<-read.table(file=paste0(DIR,"/Data/Simulated_Data/Genotypes/High_Mutation_Rate/genotype",i,".dat"))
  for (j in 1:4){
    Mutated_Samples<-Matrix_Mutator(Samples,FP[j],FN[j])
    write.table(Mutated_Samples,file=paste0(DIR,"/Data/Simulated_Data/Genotypes/High_Mutation_Rate/Mutated_genotype",i,"_",FP[j],"_",FN[j],".dat"),row.names = FALSE, col.names = FALSE)
  }  
}


