#################################################################################################################
#################################################################################################################
Geno10<-read.table("./Data/Real_Data/Genotypes/Glioblastoma_Multiforme.dat")
Sample.Size<-dim(Geno10)[1]
TotalGenes<-10
nGenes<-4
Quartets<-combn(TotalGenes,nGenes)
N.Quartets<-choose(TotalGenes,nGenes)


################################################### CT-CBN: #####################################################
source("./Codes/QuartetCBN/PathQuantificationC.R")
PathProbC<-matrix(0,N.Quartets,factorial(nGenes))

for (i in 1:N.Quartets){
  FINAL<-PathProbC(i,nGenes)
  for (j in 1:factorial(nGenes)){
    PathProbC[i,j]<-FINAL[j] 
  }
}

save(PathProbC,file="./Data/Real_Data/Quartets/C/PathProbC.RData")


################################################### H-CBN: ######################################################
source("./Codes/QuartetCBN/PathQuantificationH.R")
PathProbH<-matrix(0,N.Quartets,factorial(nGenes))

for (i in 1:N.Quartets){
  FINAL<-PathProbH(i,nGenes)
  for (j in 1:factorial(nGenes)){
    PathProbH[i,j]<-FINAL[j] 
  }
}

save(PathProbH,file="./Data/Real_Data/Quartets/H/PathProbH.RData")


################################################### B-CBN: ######################################################
source("./Codes/QuartetCBN/PathQuantificationB.R")
PathProbB<-matrix(0,N.Quartets,factorial(nGenes))

for (i in 1:N.Quartets){
  FINAL<-PathProbB(i,nGenes)
  for (j in 1:factorial(nGenes)){
    PathProbB[i,j]<-FINAL[j] 
  }
}

save(PathProbB,file="./Data/Real_Data/Quartets/B/PathProbB.RData")


################################################### R-CBN: ######################################################
source("./Codes/QuartetCBN/PathQuantificationR.R")
PathProbR<-matrix(0,N.Quartets,factorial(nGenes))

for (i in 1:N.Quartets){
  TEMP<-PathProbR(i)
  FINAL<-Path_Normalization(TEMP,nGenes)
  for (j in 1:factorial(nGenes)){
    PathProbR[i,j]<-FINAL[j] 
  }
}

save(PathProbR,file="./Data/Real_Data/Quartets/R/PathProbR.RData")
#################################################################################################################

