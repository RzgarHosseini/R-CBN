################# The functions ######################################################################################################################################################################################################################################################################################################
### The Matrix_Mutator function:
Matrix_Mutator<-function(mat,FP,FN){
  #mat: matrix of genotype samples that needs to be muatated
  #FP: False positive rate
  #FN: False negative rate
  d<-dim(mat)[1]
  AllP<-which(mat==1)
  AllN<-which(mat==0)
  Sample_FP<-AllN[sample(1:length(AllN),round(FP*length(AllN)))]
  Sample_FN<-AllP[sample(1:length(AllP),round(FN*length(AllP)))]
  
  for (i in 1:length(Sample_FP)){
    x<-Sample_FP[i]%%d
    y<-ceiling(Sample_FP[i]/d)
    mat[x,y]<-1
  }
  
  for (i in 1:length(Sample_FN)){
    x<-Sample_FN[i]%%d
    y<-ceiling(Sample_FN[i]/d)
    mat[x,y]<-0
  }
  
  return(mat)
}
