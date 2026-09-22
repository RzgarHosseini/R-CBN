#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1] #Path to the repository
subDIR<-args[2] #Path to the file within the repository
InputFileName<-args[3] #filename
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/05_PathwayCompatibility_Functions"))
#################################################################################################################
GenotypeMatrix<-read.table(paste0(DIR,"/",subDIR,"/",InputFileName,".dat"))
Sample.Size<-dim(GenotypeMatrix)[1]
N.Genes<-dim(GenotypeMatrix)[2] ## Must be larger than 4
#################################################################################################################
# Constructing the Pathway-Genotype Compatibility Matrix and quantifying compatibility score of each pathway
for (n in 4:N.Genes){
  Subsets<-combn(N.Genes,n)
  N.Subsets<-choose(N.Genes,n)
  Gen2<-BinarizeGenotype(n)
  GPmap<-Genotype2PathwayMap(n)
  Path2Geno<-matrix(0,N.Subsets,factorial(n))
  
  for (i in 1:N.Subsets){
    TEMP<-matrix(0,Sample.Size,factorial(n))
    SEL<-as.numeric(Subsets[,i])
    Genotypes<-GenotypeMatrix[,SEL]
    for (j in 1:Sample.Size){
      GENO<-base2(Genotypes[j,])
      INDX<-which(Gen2==GENO)
      TEMP[j,]<-GPmap[,INDX]
    }
    Path2Geno[i,]<-apply(TEMP,2,sum)
    save(Path2Geno,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/Path2Geno.RData"))
  }
}
####################################################################################################################################################################
################## Compatibility Analysis ##################################################################################################################
####################################################################################################################################################################
for (n in 4:N.Genes){
  
  Subsets<-combn(N.Genes,n)
  N.Subsets<-choose(N.Genes,n)
  
  load(file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/Path2Geno.RData"))
  
  load(file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/C/PathProbC.RData"))
  load(file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/H/PathProbH.RData"))
  load(file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/B/PathProbB.RData"))
  load(file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/R/PathProbR.RData"))
  
  RankCorC<-numeric(N.Subsets)
  RankCorH<-numeric(N.Subsets)
  RankCorB<-numeric(N.Subsets)
  RankCorR<-numeric(N.Subsets)
  
  for (i in 1:N.Subsets){
    RankCorC[i]<-cor(PathProbC[i,],Path2Geno[i,],method="spearman")
    RankCorH[i]<-cor(PathProbH[i,],Path2Geno[i,],method="spearman")
    RankCorB[i]<-cor(PathProbB[i,],Path2Geno[i,],method="spearman")
    RankCorR[i]<-cor(PathProbR[i,],Path2Geno[i,],method="spearman")
  }
  
  save(RankCorC,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/R/RankCorC.RData"))
  save(RankCorH,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/R/RankCorH.RData"))
  save(RankCorB,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/R/RankCorB.RData"))
  save(RankCorR,file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",n,"/R/RankCorR.RData"))
  
}


