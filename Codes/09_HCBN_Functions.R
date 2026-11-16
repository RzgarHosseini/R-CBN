###########################################################################################################################################################
### Functions required for calculating the pathway probabilities using the results of the H-CBN model

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

PathProbQuantifyH<-function(DIR,subDIR,InputFileName,num1,num2){
  x<-num1
  filename1<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",x,"/H/Genotype",num2,".lambda")
  LAMBDA<-as.numeric(read.table(filename1)$V1)
  filename2<-paste0(DIR,"/",subDIR,"/",InputFileName,"_n",x,"/H/Genotype",num2,"/00000.poset")
  DAG<-readPoset(filename2)
  PathProb<-PathProb_CBN(DAG,LAMBDA,x)
  return(PathProb)
}
###########################################################################################################################################################

