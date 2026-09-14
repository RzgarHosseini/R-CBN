#!/usr/bin/env Rscript
#######################################################################################################################################################################
source("./Codes/QuartetCBN/MainFunctions.R")
#######################################################################################################################################################################
base2<-function(vec){
  count<-1
  for (i in 1:length(vec)){if (vec[i]==1){count<-count+2^i}}
  return(count)
}
#######################################################################################################################################################################
Pathway_Genotype_Compatiblility<-function(Pathway,Genotype){
  C<-1 #by default compatible unless:
  for (i in 1:(length(Pathway)-1)){
    P<-Pathway[i]
    if (Genotype[P]==0){
      for (j in (i+1):length(Pathway)){
        Q<-Pathway[j]
        if (Genotype[Q]==1){C<-0;break;}
      }
    }
    if (C==0){break;}
  }    
  return(C)
}
#######################################################################################################################################################################
Genotype2PathwayMap<-function(n){
  Pathways<-permutations(n,n)
  Genotypes<-generate_matrix_genotypes(n)
  Gen2Path<-matrix(0,factorial(n),(2^n))
  for (i in 1:factorial(n)){
    for (j in 1:(2^n)){
      Gen2Path[i,j]<-Pathway_Genotype_Compatiblility(Pathways[i,],Genotypes[j,])
    }
  }
  return(Gen2Path)
}

### Binarizing
BinarizeGenotype<-function(n){
  Gen2<-numeric(2^n)
  Genotypes<-generate_matrix_genotypes(n)
  for (i in 1:(2^n)){
    Gen2[i]<-base2(unname(Genotypes[i,]))
  }
  return(Gen2) 
}

#########################################################################################################################################################################
#########################################################################################################################################################################
#########################################################################################################################################################################
#########################################################################################################################################################################
GenotypeData<-read.table("./Data/Real_Data/Genotypes/Glioblastoma_Multiforme.dat")
Sample.Size<-dim(GenotypeData)[1]
TotalGenes<-10
nGenes<-4
Quartets<-combn(TotalGenes,nGenes)
N.Quartets<-choose(TotalGenes,nGenes)


Gen2<-BinarizeGenotype(nGenes)
GPmap<-Genotype2PathwayMap(nGenes)

Path2Geno<-matrix(0,N.Quartets,factorial(nGenes))

for (i in 1:N.Quartets){
  TEMP<-matrix(0,Sample.Size,factorial(nGenes))
  SEL<-as.numeric(Quartets[,i])
  Genotypes<-GenotypeData[,SEL]
  for (j in 1:Sample.Size){
    GENO<-base2(Genotypes[j,])
    INDX<-which(Gen2==GENO)
    TEMP[j,]<-GPmap[,INDX]
  }
  Path2Geno[i,]<-apply(TEMP,2,sum)
}

save(Path2Geno,file="./Data/Real_Data/Quartets/R/Path2Geno.RData")

####################################################################################################################################################################
################## Compatibility Analysis ##################################################################################################################
####################################################################################################################################################################
RankCorC<-numeric(N.Quartets)
RankCorH<-numeric(N.Quartets)
RankCorB<-numeric(N.Quartets)
RankCorR<-numeric(N.Quartets)

for (i in 1:N.Quartets){
  RankCorC[i]<-cor(PathProbC[i,],Path2Geno[i,],method="spearman")
  RankCorH[i]<-cor(PathProbC[i,],Path2Geno[i,],method="spearman")
  RankCorB[i]<-cor(PathProbC[i,],Path2Geno[i,],method="spearman")
  RankCorR[i]<-cor(PathProbC[i,],Path2Geno[i,],method="spearman")
}

save(RankCorC,file="./Data/Real_Data/Quartets/C/RankCorC.RData")
save(RankCorH,file="./Data/Real_Data/Quartets/H/RankCorH.RData")
save(RankCorB,file="./Data/Real_Data/Quartets/B/RankCorB.RData")
save(RankCorR,file="./Data/Real_Data/Quartets/R/RankCorR.RData")


