
#################################################################################################################
#################################################################################################################
Geno10<-read.table("./Data/Real_Data/Genotypes/Glioblastoma_Multiforme.dat")
Sample.Size<-dim(Geno10)[1]
Quartets<-combn(10,4)
N.Quartets<-choose(10,4)
nGenes<-4


sink(file="./Codes/QuartetCBN/Step3H.sh")

for (i in 1:N.Quartets){
  
  filename<-paste0("./Data/Real_Data/Quartets/C/Results",i,".dat")
  mat<-read.table(filename)
  INDX<-which.max(mat[,4])#maximum likelihood DAG
  ZINDX<-mat[INDX,1]  
  
  strg<-paste0("00000",as.character(ZINDX))
  start_pos <- nchar(strg) - 4
  NumStr<-substr(strg, start_pos, nchar(strg))
  
  cat(paste0("cp ./Data/Real_Data/Quartets/C/Genotype",i,"/",NumStr,".poset ./Data/Real_Data/Quartets/H/Genotype",i,".poset\n"))
}
sink(file = NULL)


