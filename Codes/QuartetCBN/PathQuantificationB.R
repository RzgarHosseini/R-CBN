#!/usr/bin/env Rscript
###########################################################################################################################################################
source("./Codes/QuartetCBN/MainFunctions.R")
###########################################################################################################################################################
############################ B-CBN ########################################################################################################################
###########################################################################################################################################################
Binarizing<-function(mat,x){
  count<-0
  num<-0
  for (i in 1:x){
    for (j in 1:x){
      count<-count+1
      if (mat[i,j]==1){num<-num+2^count}
    }
  }
  return(num)
}


PathProbB<-function(num1,x){
  filename<-paste0("./Data/Real_Data/Quartets/R/Results",num1,".dat")
  mat<-read.table(filename)
  LogLik<-mat[,4]
  LAMBDA<-mat[,5:(5+x)]
  PathProb0<-matrix(0,219,factorial(x))
  
  IndxR<-numeric(219)
  for (i in 1:219){
    if (i==1){DAG<-matrix(0,0,0)} 
    else {DAG<-read.table(paste0("./Data/Posets4/poset",i,".dat"))}
    PathProb0[i,]<-PathProb_CBN(DAG,as.numeric(LAMBDA[i,]),x)
    
    TEMP<-matrix(0,x,x)
    D<-dim(DAG)[1]
    if (D>0){
      for (j in 1:D){
        TEMP[(DAG[j,1]),(DAG[j,2])]<-1
      }
    }
    IndxR[i]<-Binarizing(TEMP,x)
  }
  
  IndxS<-numeric(100000)
  load(paste0("./Data/Real_Data/Quartets/B/Results",num1,".RData"))
  for (i in 1:100000){
    IndxS[i]<-Binarizing(Results[[i]],x)
  }
  
  wt<-numeric(219)
  for (i in 1:219){
    wt[i]<-length(which(IndxS==IndxR[i]))
  }
  
  PathProb<-apply((wt*PathProb0),2,sum)/sum(wt)  
  return(PathProb)
}

