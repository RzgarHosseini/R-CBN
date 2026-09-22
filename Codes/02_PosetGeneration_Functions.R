######################################################################################################################################################################################################################################################################################################################################
################# The functions ######################################################################################################################################################################################################################################################################################################
### pairGenerator function:
pairGenerator<-function(vec1,vec2){
  if (vec1[2]==vec2[1]){vec<-c(vec1[1],vec2[2])}
  else if (vec1[1]==vec2[2]){vec<-c(vec2[1],vec1[2])}
  else {vec<-c()}
  return(vec)
}

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


### CycleDetector:
CycleDetector<-function(cDAG){
  cDAG<-DAGcomplete(cDAG)
  x<-dim(cDAG)[1]
  cycle<-0
  if (x>1){
    d<-choose(x,2)
    Cmat<-combn(1:x,2,simplify = TRUE) 
    for (i in 1:d){
      vec1<-cDAG[Cmat[1,i],]
      vec2<-cDAG[Cmat[2,i],]
      if ((vec1[1]==vec1[[2]])&&(vec2[2]==vec2[1])){cycle<-1;break;}
      if ((vec1[1]==vec2[[2]])&&(vec1[2]==vec2[1])){cycle<-1;break;}
    }
  }
  else {if (x==1){if (cDAG[,1]==cDAG[,2]){cycle<-1}}}
  return(cycle)
}


### Pathway_Enumerator:
Pathway_Enumerator<-function(Poset,x){
  d<-dim(Poset)[1]
  PERM<-permutations(x,x)
  FEASIBLE<-rep(1,factorial(x))
  if (d>1){
    for (i in 2:d){
      for (j in 1:factorial(x)){
        xx<-which(PERM[j,]==Poset[i,1])
        yy<-which(PERM[j,]==Poset[i,2])
        if (xx>yy){FEASIBLE[j]<-0}
      }
    }
  }
  return(FEASIBLE)
}

