########################################################################################################################################################################################################################################################################################
########################################################################################################################################################################################################################################################################################
########################################################################################################################################################################################################################################################################################
### Part 1: Required Functions

### DAGcomplete function:
DAGcomplete<-function(cDAG){
  x<-dim(cDAG)[1]
  if (x>1){
    FLAG<-0
    while (FLAG==0){
      x<-dim(cDAG)[1]
      d<-choose(x,2)
      Cmat<-combn(1:x,2,simplify = TRUE)
      count<-0
      for (i in 1:d){
        vec1<-cDAG[Cmat[1,i],]
        vec2<-cDAG[Cmat[2,i],]
        vec<-pairGenerator(vec1,vec2)
        if (length(vec)>0){
          if (length(intersect(which(cDAG[,1]==vec[1]),which(cDAG[,2]==vec[2])))==0){
            cDAG<-rbind(cDAG,vec)
            count<-count+1
          }
        }
      }
      cDAG<-unique(rbind(cDAG,c(0,0)))
      cDAG<-unique(cDAG)
      if (count==0){FLAG<-1}
    }
    ww<-which(apply(cDAG,1,sum)==0)
    cDAG[ww,]<-cDAG[dim(cDAG)[1],]
    cDAG[dim(cDAG)[1],]<-c(0,0)
    return(cDAG)
  }
  else{
    return(cDAG)
  }
}

#Mutally exclusive pairs
MutEx_enumerator<-function(DAG){
  #DAG: The complete DAG
  mat<-matrix(c(1,1,1,2,2,3,2,3,4,3,4,4),nrow=6,ncol=2)
  vec<-rep(1,dim(mat)[1])
  for (i in 1:dim(mat)[1]){
    if ((length(intersect(which(DAG[,1]==mat[i,1]),which(DAG[,2]==mat[i,2])))>0)||(length(intersect(which(DAG[,1]==mat[i,2]),which(DAG[,2]==mat[i,1])))>0)){
      vec[i]<-0
    }
  }
  final<-mat[which(vec==1),]
  if (length(which(vec==1))==1){final<-matrix(final,nrow=1,ncol=2)}
  #return(mat[which(vec==1),])
  return(final)
}


#Generating genotype set G
GENOTYPE_ALLOWED <- function(genotypes,DAG,NR,MuX){
  # This function determines the feasibility of a given set of genotypes according to a given DAG of restrictions.
  # genotypes: the set of genotypes to be analyzed.
  # DAG: matrix representing the DAG of restrictions.
  # NR: the number of genotypes considered.
  # MuX: whether to take mutual exclusivity into account or not
  vec<-matrix(1,nrow=NR,ncol=1)
  D<-dim(DAG)[1]
  if (D>1){
    for (i in 1:NR){
      for (j in 2:(D)){
        xx<-DAG[j,1]
        yy<-DAG[j,2]
        if (NR==1){if ((genotypes[yy]==1)&&(genotypes[xx]==0)){vec[i]<-0}}
        else {if ((genotypes[i,yy]==1)&&(genotypes[i,xx]==0)){vec[i]<-0}}## if the mutation ordering is not respected the genotype is labelled as infeasible.
      }
    }
  }
  
  if (MuX==1){
    matt<-MutEx_enumerator(DAGcomplete(DAG))
    if (dim(matt)[1]>0){
      i<-sample(1:dim(matt)[1],1)
      vec[intersect(which(genotypes[,matt[i,1]]==1),which(genotypes[,matt[i,2]]==1)),1]<-0
    }
    else {if (length(matt)==2){vec[intersect(which(genotypes[,matt[1]]==1),which(genotypes[,matt[2]]==1)),1]<-0}}
  }
  return(vec)
}


### Sampling Genotypes
Sampling_Genotypes<-function(mat,DAG,N,alpha,MuX){
  #mat: matrix of all genotypes
  #DAG: dag of restrictions
  #N: number of genotypes to be sampled (I used N=200)
  #alpha: I kept it as 0.8
  #MuX: whether to include mutual exclusivity (1) or not (0)
  
  matt<-mat[which(GENOTYPE_ALLOWED(mat,DAG,16,MuX)==1),]
  sm<-apply(matt,1,sum)
  nm<-0
  for (i in 0:4){
    if (length(which(sm==i))>0){nm<-nm+alpha^i}
  }
  subpop<-numeric(length(sm))
  for (i in 1:length(sm)){
    subpop[i]<-round((alpha^sm[i])*N/(nm*length(which(sm==sm[i]))))
  }
  subpop[1]<-subpop[1]+N-sum(subpop)
  
  Final<-matrix(0,nrow=N,ncol=4)
  count<-0
  for (i in 1:length(sm)){
    for (j in ((count+1):sum(count+subpop[i]))){
      for (k in 1:4){Final[j,k]<-matt[i,k]}
    }
    count<-count+subpop[i]
  }
  return(Final)
}




#############################################################################################################################################################################################################################################################################################################
#############################################################################################################################################################################################################################################################################################################
#############################################################################################################################################################################################################################################################################################################
### File Generation

ALL_Genotypes<-matrix(c(0,1,0,0,0,1,1,1,0,0,0,1,1,1,0,1,0,0,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,0,1,0,0,1,0,1,0,1,1,0,1,1,1,0,0,0,0,1,0,0,1,0,1,1,0,1,1,1,1),nrow=16,ncol=4)
Samples1<-list()### without Mutual Exclusivity
Samples2<-list()### with Mutual Exclusivity

for (i in 1:219){
  
  Posets<-read.table(file=paste("./Data/Posets4/poset",i,".dat",sep=""),sep=" ")
  
  Samples1[[i]]<-Sampling_Genotypes(ALL_Genotypes,Posets,200,0.8,0)#without mutual exclusivity
  write(t(Samples1[[i]]),file=paste("./Data/Synthetic_Data/Genotypes/Without_Mutual_Exclusivity/genotype",i,".dat",sep=""),ncolumns=4,append=TRUE,sep=" ")
  
  Samples2[[i]]<-Sampling_Genotypes(ALL_Genotypes,Posets,200,0.8,1)#with mutual exclusivity
  write(t(Samples2[[i]]),file=paste("./Data/Synthetic_Data/Genotypes/With_Mutual_Exclusivity/genotype",i,".dat",sep=""),ncolumns=4,append=TRUE,sep=" ")
}








