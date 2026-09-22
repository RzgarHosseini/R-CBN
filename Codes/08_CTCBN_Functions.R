###########################################################################################################################################################
### Functions required for calculating the pathway probabilities using the results of the CT-CBN model
PathProbQuantifyC<-function(DIR,subDIR,InputFileName,num1,num2){
  x<-num1
  filename1<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",x,"/C/Results",num2,".dat")
  
  mat<-read.table(filename1)
  INDX<-which.max(mat[,4])#maximum likelihood DAG
  ZINDX<-mat[INDX,1]
  LAMBDA<-as.numeric(mat[INDX,5:(5+x)])
  
  strg<-paste0("00000",as.character(ZINDX))
  start_pos <- nchar(strg) - 4
  NumStr<-substr(strg, start_pos, nchar(strg))
 
  filename2<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",x,"/C/Genotype",num2,"/",NumStr)
  
  DAG<-readPoset(filename2)$sets
  if (is.na(DAG)[1]==TRUE){DAG<-matrix(0,0,0)}
  PathProb<-PathProb_CBN(DAG,LAMBDA,x)
  return(PathProb)
}
###########################################################################################################################################################

