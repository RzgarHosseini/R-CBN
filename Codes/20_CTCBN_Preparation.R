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
    dir.create(paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C"),recursive=TRUE)
    OutputFileName<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/Genotype",i,".pat")
    write.table(cbind(1,SelGeno),file=OutputFileName,row.names = FALSE, col.names = FALSE)
    system(paste0("(echo ",Sample.Size," ",(n+1)," && cat ",OutputFileName,")>",OutputFileName,"t && mv ",OutputFileName,"t ",OutputFileName))
    system(paste0("mkdir ",DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/Genotype",i))
    system(paste0("echo '",n,"'>>",DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/Genotype",i,".poset"))
    system(paste0("echo '0'>>",DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/Genotype",i,".poset"))  
  }
}
#################################################################################################################




