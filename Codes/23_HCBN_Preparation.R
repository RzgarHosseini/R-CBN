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
    SelSubset<-Subsets[,i]
    SelGeno<-GenotypeMatrix[,SelSubset]
    dir.create(paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/H"),recursive=TRUE)
    OutputFileName<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/H/Genotype",i,".pat")
    write.table(cbind(1,SelGeno),file=OutputFileName,row.names = FALSE, col.names = FALSE)
    system(paste0("(echo ",Sample.Size," ",(n+1)," && cat ",OutputFileName,")>",OutputFileName,"t && mv ",OutputFileName,"t ",OutputFileName))
    system(paste0("mkdir ",DIR,"/",subDIR,"/",InputFileName,"_n",n,"/H/Genotype",i))
  }
}
##################################################################################################################################################################################################################################
##################################################################################################################################################################################################################################

### Note that the following part must be done after executing the CT-CBN model on the same data [23_CTCBN_Execution]
### The reason is that H-CBN model is based on a simulated annealing algorithm, which is initiated with the maximum-likelihood poset inferred by thge CT-CBN algorithm.

##################################################################################################################################################################################################################################
##################################################################################################################################################################################################################################
for (n in 4:N.Genes){
  Subsets<-combn(N.Genes,n)
  N.Subsets<-choose(N.Genes,n)
  for (i in 1:N.Subsets){
    
    filename<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/Results",i,".dat")
    mat<-read.table(filename)
    INDX<-which.max(mat[,4])#maximum likelihood DAG
    ZINDX<-mat[INDX,1]  
    
    strg<-paste0("00000",as.character(ZINDX))
    start_pos <- nchar(strg) - 4
    NumStr<-substr(strg, start_pos, nchar(strg))
    
    system(paste0("cp ",DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/Genotype",i,"/",NumStr,".poset ",DIR,"/",subDIR,"/",InputFileName,"_n",n,"/H/Genotype",i,".poset"))
    
  }
}
    





