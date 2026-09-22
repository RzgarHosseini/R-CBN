###########################################################################################################################################################
### Functions required for calculating the pathway probabilities using the results of the Quartet-RCBN model

####### 1. Poset-Level weighting #################################################################
# Reciprocal Ranking based weighting
IW<-function(vec){
  w<-numeric(length(vec))
  for (i in 1:length(vec)){
    temp<-sort(vec,index.return=TRUE,decreasing=TRUE)$ix
    w[i]<-1/(which(temp==i))
  }
  return(w)
}

PathProbQuantifyR<-function(DIR,subDIR,InputFileName,num1,num2){
  x<-num1
  filename<-paste0(DIR,"/",subDIR,"/",InputFileName,"_Quintet/R/Results",num2,".dat")
  mat<-read.table(filename)
  LogLik<-mat[,4]
  LAMBDA<-mat[,5:(5+x)]
  wt<-IW(LogLik)
  PathProb0<-matrix(0,4231,factorial(x))
  for (i in 1:4231){
    if (i==1){DAG<-matrix(0,0,0)} 
    else {DAG<-read.table(paste0(DIR,"/Data/Posets5/poset",i,".dat"))}
    PathProb0[i,]<-PathProb_CBN(DAG,as.numeric(LAMBDA[i,]),x)
  }
  PathProb<-apply((wt*PathProb0),2,sum,na.rm=TRUE)/sum(wt) 
  return(PathProb)
}

####### 2. Pathway-Level weighting #################################################################

Path_Edge_Mapper<-function(x){
  PATH<-permutations(x,x)
  EDGE<-permutations(x,2)
  P<-dim(PATH)[1]
  E<-dim(EDGE)[1]
  PEmap<-matrix(0,P,E)
  for (i in 1:P){
    for (j in 1:E){
      x1<-which(PATH[i,]==EDGE[j,1])
      x2<-which(PATH[i,]==EDGE[j,2])
      if (x1<x2){PEmap[i,j]<-1}
    }
  }
  return(PEmap)
}

EdgeMarginalized<-function(PathProb,x){
  PEmap<-Path_Edge_Mapper(x)
  D<-dim(PEmap)[2]
  EdgeProb<-numeric(D)
  for (i in 1:D){
    INDX<-which(PEmap[,i]==1)
    EdgeProb[i]<-sum(PathProb[INDX])
  }
  return(EdgeProb)
}

EW<-function(EdgeProb,PEmap){
  D<-dim(PEmap)[1]
  w<-numeric(D)
  for (i in 1:D){
    w[i]<-1
    INDX<-which(PEmap[i,]==1)
    for (j in INDX){
      w[i]<-w[i]*EdgeProb[j]
    }
  }
  w<-w/sum(w)
  return(w)
}

Path_Normalization<-function(PathProb,x){
  PEmap<-Path_Edge_Mapper(x)
  EdgeProb<-EdgeMarginalized(PathProb,x)
  w<-EW(EdgeProb,PEmap)
  PathProbn<-((w*PathProb)/sum(w*PathProb)) #The normalized pathway probability 
  return(PathProbn)
}

