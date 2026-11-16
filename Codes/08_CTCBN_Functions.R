###########################################################################################################################################################
### Functions required for calculating the pathway probabilities using the results of the CT-CBN model
readPoset<-function(filename){
  lines<-readLines(filename)
  l<-length(lines)
  if (l==2){output<-matrix(0,0,0)}
  else if (l>2){
    output<-matrix(0,(l-2),2)
    for (i in 1:(l-2)){
      output[i,1]<-as.numeric(strsplit(lines[(i+1)], " ")[[1]])[1]
      output[i,2]<-as.numeric(strsplit(lines[(i+1)], " ")[[1]])[2]
    }
  }
  else{print("Error: Poset file is not correctly formatted")}
  return(output)
}



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
 
  filename2<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",x,"/C/Genotype",num2,"/",NumStr,".poset")
  
  DAG<-readPoset(filename2)
  PathProb<-PathProb_CBN(DAG,LAMBDA,x)
  return(PathProb)
}
###########################################################################################################################################################

