###########################################################################################################################################################
### Functions required for calculating the pathway probabilities using the results of the B-CBN model
###########################################################################################################################################################

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


###########################################################################################################################################################
Mat2Dag<-function(Mat,x){
  D<-sum(Mat)
  if (D==0){Dag<-matrix(0,0,0)}
  else{
    Dag<-matrix(0,D,2)
    count<-0
    for (i in 1:x){
      for (j in 1:x){
        if (Mat[i,j]==1){
          count<-count+1
          Dag[count,1]<-i
          Dag[count,2]<-j
        }
      }
    }
    if (count!=D){print("Error!")}
  }
  return(Dag)
}


###########################################################################################################################################################
BCBNperPosetQuantification<-function(DIR,subDIR,InputFileName,num1,num2){
  
  load(paste0(DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Results",num2,".RData"))
  
  IndxS<-numeric(100000)
  for (i in 1:100000){IndxS[i]<-Binarizing(Results[[i]],num1)}
  
  U<-unique(IndxS)
  L<-length(U)
  
  for (i in 1:L){## iterating over L unique DAGs
    tempIndx<-which(IndxS==U[i])[1]
    tempMat<-Results[[tempIndx]]
    
    #### Creating and storing the given DAG
    DAG<-Mat2Dag(tempMat,num1)
    D<-dim(DAG)[1]   
    sink(file=paste0(DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Genotype",num2,".poset"))
    cat(paste0(num1))
    cat("\n")
    if (D>0){
      for (j in 1:D){
        cat(paste0(DAG[j,1]," ",DAG[j,2]))
        cat("\n")
      }      
    }
    cat(paste0(0))
    cat("\n")    
    sink(file = NULL)
    
    #### The CT-CBN model is trained per each DAG.
    system(paste0(DIR,"/ct-cbn-0.1.04b/ct-cbn -f ",DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Genotype",num2,"|tail -1>>",DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Results",num2,".dat")) 
    system(paste0("rm ",DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Genotype",num2,".poset"))
    
  }
}

###########################################################################################################################################################
BCBNposetEnumeration<-function(DIR,subDIR,InputFileName,num1,num2){
  
  load(paste0(DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Results",num2,".RData"))
  
  IndxS<-numeric(100000)
  for (i in 1:100000){IndxS[i]<-Binarizing(Results[[i]],num1)}
  
  U<-unique(IndxS)
  L<-length(U)
  DAGs<-list()
  
  for (i in 1:L){## iterating over L unique DAGs
    tempIndx<-which(IndxS==U[i])[1]
    tempMat<-Results[[tempIndx]]
    
    #### Creating and storing the given DAG
    DAGs[[i]]<-Mat2Dag(tempMat,num1)
  }
  
  return(DAGs)
}

###########################################################################################################################################################
BCBNposetWeighting<-function(DIR,subDIR,InputFileName,num1,num2){
  
  load(paste0(DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Results",num2,".RData"))
  
  IndxS<-numeric(100000)
  for (i in 1:100000){IndxS[i]<-Binarizing(Results[[i]],num1)}
  
  U<-unique(IndxS)
  L<-length(U)
  W<-numeric(L)
  
  for (i in 1:L){
    W[i]<-length(which(IndxS==U[i]))
  }
  
  Final<-(W/100000)
  
  return(Final)
}


###########################################################################################################################################################
PathProbQuantifyB4<-function(DIR,subDIR,InputFileName,num1,num2){
  x<-num1
  filename<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n4/R/Results",num2,".dat")
  mat<-read.table(filename)
  LogLik<-mat[,4]
  LAMBDA<-mat[,5:(5+x)]
  PathProb0<-matrix(0,219,factorial(x))
  
  IndxR<-numeric(219)
  for (i in 1:219){
    if (i==1){DAG<-matrix(0,0,0)} 
    else {DAG<-read.table(paste0(DIR,"/Data/Posets4/poset",i,".dat"))}
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
  
  load(paste0(DIR,"/",subDIR,"/",InputFileName,"_n4/B/Results",num2,".RData"))
  
  IndxS<-numeric(100000)
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


###########################################################################################################################################################
PathProbQuantifyB<-function(DIR,subDIR,InputFileName,num1,num2){
  
  BCBNperPosetQuantification(DIR,subDIR,InputFileName,num1,num2)
  W<-BCBNposetWeighting(DIR,subDIR,InputFileName,num1,num2)
  DAGs<-BCBNposetEnumeration(DIR,subDIR,InputFileName,num1,num2)
  L<-length(W)
  
  filename<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",num1,"/B/Results",num2,".dat")
  mat<-read.table(filename)
  LogLik<-mat[,4]
  LAMBDA<-mat[,5:(5+num1)]
  
  PathProb0<-matrix(0,L,factorial(num1))
  for (i in 1:L){
    PathProb0[i,]<-PathProb_CBN(DAGs[[i]],as.numeric(LAMBDA[i,]),num1)
  }
  
  PathProb<-apply((W*PathProb0),2,sum,na.rm=TRUE)/sum(W) 
  
  return(PathProb)
}


