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
  Quartet<-Quartets[,i]
  Geno4<-GenotypeMatrix[,Quartet]
  dir.create(paste0(DIR,"/",subDIR,"/",InputFileName,"_Quintet/R"),recursive=TRUE)
  OutputFileName<-paste0(DIR,"/",subDIR,"/",InputFileName,"_Quintet/R/Genotype",i,".pat")
  write.table(cbind(1,Geno4),file=OutputFileName,row.names = FALSE, col.names = FALSE)
  system(paste0("(echo ",Sample.Size," ",(n+1)," && cat ",OutputFileName,")>",OutputFileName,"t && mv ",OutputFileName,"t ",OutputFileName))
  system(paste0("mkdir ",DIR,"/",subDIR,"/",InputFileName,"_Quintet/R/Genotype",i))
}
