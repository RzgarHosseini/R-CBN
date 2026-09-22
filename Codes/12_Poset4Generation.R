#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
DIR<-args[1]
source(paste0(DIR,"/Codes/01_Basic_Functions.R"))
source(paste0(DIR,"/Codes/02_PosetGeneration_Functions.R"))
######################################################################################################################################################################################################Associated_TNBC<-read.csv("/Users/rzgar/Desktop/Research/ENCORE_LIBRARY/OLD/Associated_TNBC.csv")
######################################################################################################################################################################################################Associated_TNBC<-read.csv("/Users/rzgar/Desktop/Research/ENCORE_LIBRARY/OLD/Associated_TNBC.csv")

## Step 1: Enumerating all potential graphs of length 4 and checking whether they are are acyclic or not.
allMats<-expand.grid(replicate(16, 0:1, simplify = FALSE))
allG<-numeric(2^16)

for (i in 1:(2^16)){
  vec<-which(allMats[i,]==1)
  matt<-matrix(0,nrow=length(vec),ncol=2)
  count<-0
  for (j in vec){
    n1<-ceiling(j/4)
    n2<-j%%4
    if (n2==0){n2<-4}
    count<-count+1
    matt[count,1]<-n1
    matt[count,2]<-n2
  }
  allG[i]<-CycleDetector(matt)
  print(i)
}

DAGs_Index<-which(allG==0) ## Obtain the index of all potential acyclic graphs (543 DAGs) 


## Step 2:  Enumerating all directed acyclic graphs (DAGs)
count<-0
DAGs<-list()
for (i in DAGs_Index){
  count<-count+1
  
  vec<-which(allMats[i,]==1)
  matt<-matrix(0,nrow=length(vec),ncol=2)
  countt<-0
  for (j in vec){
    n1<-ceiling(j/4)
    n2<-j%%4
    if (n2==0){n2<-4}
    countt<-countt+1
    matt[countt,1]<-n1
    matt[countt,2]<-n2
  }
  matt<-rbind(c(0,0),matt)
  DAGs[[count]]<-matt
  print(i)
}



### Step 3: Identify the set of feasible pathways for each DAG [This will help us to idetify the set of unique transitively closed DAGs]
pathways<-matrix(0,nrow=543,ncol=24)
for (i in 1:543){
  pathways[i,]<-Pathway_Enumerator(DAGs[[i]],4)
}
Upathways<-unique(pathways) ### 219 uniue pathway signatures ---> 219 unique transitively closed DAGs


### Step 4: Enumerating the set of the 219 unique transitively closed DAGs.
sumpath<-apply(pathways,1,sum)
tcDAGs<-list()
for (i in 1:219){
  mat<-c()
  for (j in 1:543){mat<-rbind(mat,Upathways[i,])}
  sel<-which(apply(abs(pathways-mat),1,sum)==0)
  tcDAGs[[i]]<-DAGs[[sel[which.min(sumpath[sel])]]]
}


### Step 5: Formatting and storing the 219 unique transitively closed DAGs as the 219 unique posets to be utilized in the R-CBN model.
Posets<-list()
Posets[[1]]<-matrix(0,0,0)
for (i in 2:219){
  d<-dim(tcDAGs[[i]])[1]
  Posets[[i]]<-matrix(tcDAGs[[i]][(2:d),],(d-1),2)
}

### Step 6: Generating the .dat and .poset files
dir.create(paste0(DIR,"/Data/Posets4"))

#Generating the .dat files 
for (i in 1:219){
  sink(file=paste0(DIR,"/Data/Posets4/poset",i,".dat"))
  D<-dim(Posets[[i]])[1]
  if (D>0){
    for (j in 1:D){
      cat(paste0(Posets[[i]][j,1]," ",Posets[[i]][j,2]))
      cat("\n")
    }
  }
  sink(file = NULL)
}

#Generating the .poset files [These files have two additional lines as compared to .dat files (the first line and the last line), which makes them compatible as input files for the cbn models]
for (i in 1:219){
  sink(file=paste0(DIR,"/Data/Posets4/poset",i,".poset"))
  cat("4")
  cat("\n")
  D<-dim(Posets[[i]])[1]
  if (D>0){
    for (j in 1:D){
      cat(paste0(Posets[[i]][j,1]," ",Posets[[i]][j,2]))
      cat("\n")
    }
  }
  cat("0")
  cat("\n")
  sink(file = NULL)
}

