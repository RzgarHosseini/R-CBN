#!/usr/bin/env Rscript
###########################################################################################################################################################
source("./Codes/QuartetCBN/MainFunctions.R")
#################################################################################################################
#################################################################################################################
PathEnumerator<-function(N,n){
  x<-choose(N,n)
  y<-factorial(n)
  Paths<-list()
  
  Subsets<-t(combn(1:N,n))
  PERM<-permutations(n,n)
  
  for (i in 1:x){
    Paths[[i]]<-matrix(0,y,n)
    for (j in 1:y){
      TEMP<-Subsets[i,PERM[j,]]
      for (k in 1:n){
        Paths[[i]][j,k]<-TEMP[k]      
      }
    }
  }
  return(Paths)
}

##################################################################################################################################################################
##################################################################################################################################################################
PathIDassigner<-function(N,n){
  x<-choose(N,n)
  y<-factorial(n)
  m<-(x*y)
  Paths<-numeric(m)
  
  Subsets<-t(combn(1:N,n))
  PERM<-permutations(n,n)
  
  count<-0
  for (i in 1:x){
    for (j in 1:y){
      count<-count+1
      TEMP<-Subsets[i,PERM[j,]]
      
      Paths[count]<-as.numeric(paste0(TEMP,collapse=""))
    }
  }
  return(Paths)
}



##################################################################################################################################################################
##################################################################################################################################################################
PathPROBassigner<-function(ProbMatrix,N,n){
  x<-choose(N,n)
  y<-factorial(n)
  m<-(x*y)
  PathProbs<-numeric(m)
  
  count<-0
  for (i in 1:x){
    for (j in 1:y){
      count<-count+1
      PathProbs[count]<-ProbMatrix[i,j]     
    }
  }
  return(PathProbs)
}


##################################################################################################################################################################
##################################################################################################################################################################
PathProber<-function(PathN,PathsX,PathProbsX){
  
  #PathN: The path of length N, whose probability is needed to be computed.
  #PathsX: All existing paths of length X (an m by X matrix)
  #PathProbsX: The corresponding probability of the existing paths of length X (a numeric vector of length m)
  
  N<-length(PathN)
  X<-(N-1)
  VEC<-1:N
  
  
  CIndx<-numeric(N)
  AIndx<-list()
  BIndx<-list()
  
  for (i in 1:N){## N different options
    
    NUM<-PathN[i]# The new number to be added
    
    ######## The first element of Eq. 10 (the numerator): (N-1) pathways of length N-1 ########
    WEC<-VEC[-i]
    AIndx[[i]]<-numeric((N-1))
    count<-0
    for (j in WEC){
      # The j-th desired pathway
      count<-count+1
      Apath<-PathN[-j]
      AIndx[[i]][count]<-as.numeric(paste0(Apath,collapse=""))
    }
    
    ######## The second element of Eq. 10 (the denominator): (N-1)*(N-1) pathways of length N-1 ########
    ## Checking the probability of each of the N-1 sub-pathways for each of the N (1 desired + (N-1) competing) pathways.
    count<-0
    BIndx[[i]]<-numeric((N*(N-1)))
    Tpath<-PathN[-i]
    for (p in 1:N){
      
      if (p==1){BpathN<-c(NUM,Tpath)}
      else if (p==N){BpathN<-c(Tpath,NUM)}
      else{BpathN<-c(Tpath[1:(p-1)],NUM,Tpath[p:(N-1)])}
      
      YEC<-VEC[-p]
      for (q in YEC){
        count<-count+1
        Bpath<-BpathN[-q] 
        BIndx[[i]][count]<-as.numeric(paste0(Bpath,collapse=""))
      }
    }
    
    ######## The third element of Eq. 10
    Cpath<-PathN[-i] 
    CIndx[i]<-as.numeric(paste0(Cpath,collapse=""))
    
  }
  
  ### Finding pathway indices ################################
  pCINDX <- match(CIndx, PathsX, nomatch = 0)
  
  pAINDXX<-c()
  pBINDXX<-c()
  for (i in 1:N){
    pAINDXX<-c(pAINDXX,AIndx[[i]])
    pBINDXX<-c(pBINDXX,BIndx[[i]])
  }
  pAINDX <- match(pAINDXX, PathsX, nomatch = 0)
  pBINDX <- match(pBINDXX, PathsX, nomatch = 0)
  
  ### Finding pathway probabilities ##########################
  pEstimate<-numeric(N)
  for (i in 1:N){
    Anum1<-(((N-1)*(i-1))+1)
    Anum2<-((N-1)*i)
    Bnum1<-((N*(N-1)*(i-1))+1)
    Bnum2<-(N*(N-1)*i)
    Cprob<-PathProbsX[pCINDX[i]]
    Aprob<-sum(PathProbsX[pAINDX[Anum1:Anum2]])  
    Bprob<-sum(PathProbsX[pBINDX[Bnum1:Bnum2]])
    ### The i-th probability estimate
    pEstimate[i]<-((Aprob/Bprob)*Cprob)
  }
  ### The final probability estimate
  Final<-mean(pEstimate)
  return(Final)
}


##################################################################################################################################################################
##################################################################################################################################################################
EnsembleRCBN<-function(PathProbs,N,DIR){
  #PathProbs is a matrix containing the probabilities of pathways of length 4
  #N is the total number of mutations considered
  #DIR is the directory where the pathway probability matrices are saved.
  N.Quartets<-choose(N,4)
  D1<-dim(PathProbs)[1] # must be equal to N.Quartets 
  D2<-dim(PathProbs)[2] # must be equal to 4!=24
  if ((D1!=N.Quartets)||(D2!=factorial(4))){print("the Initial matrix of (quartet) pathway probabilities is not of right dimension!");return(NULL)}
  
  n<-4
  while (n<N){
    n<-n+1
    Paths<-PathEnumerator(N,n)
    PathIndices<-PathIDassigner(N,(n-1))
    PathProbs2<-PathPROBassigner(PathProbs,N,(n-1))
    TEMP<-matrix(0,choose(N,n),factorial(n))
    for (i in 1:choose(N,n)){
      for (j in 1:factorial(n)){
        PATHx<-Paths[[i]][j,]
        TEMP[i,j]<-PathProber(PATHx,PathIndices,PathProbs2)
      }
    }
    PathProbs<-TEMP
    save(PathProbs,file=paste0(DIR,"/PathProbs",n,".RData"))
    print(paste0("quantifying pathways of length n=",n," is done."))
  }
}

  






