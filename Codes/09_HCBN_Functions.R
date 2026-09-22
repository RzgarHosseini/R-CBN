###########################################################################################################################################################
### Functions required for calculating the pathway probabilities using the results of the H-CBN model
PathProbQuantifyH<-function(DIR,subDIR,InputFileName,num1,num2){
  x<-num1
  filename1<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",x,"/H/Genotype",num2,".lambda")
  LAMBDA<-as.numeric(read.table(filename1)$V1)
  filename2<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",x,"/H/Genotype",num2,"/00000.poset")
  DAG<-read.table(filename2)
  if (is.na(DAG)[1]==TRUE){DAG<-matrix(0,0,0)}
  PathProb<-PathProb_CBN(DAG,LAMBDA,x)
  return(PathProb)
}
###########################################################################################################################################################

