###########################################################################################################################################################
### Functions required for the Genotype-Pathway Compatibility Analysis

#######################################################################################################################################################################
base2<-function(vec){
  count<-1
  for (i in 1:length(vec)){if (vec[i]==1){count<-count+2^i}}
  return(count)
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

