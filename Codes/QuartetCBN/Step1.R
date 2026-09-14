#################################################################################################################
#################################################################################################################
Geno10<-read.table("./Data/Real_Data/Genotypes/Glioblastoma_Multiforme.dat")
Sample.Size<-dim(Geno10)[1]
Quartets<-combn(10,4)
N.Quartets<-choose(10,4)

for (i in 1:N.Quartets){
  Quartet<-Quartets[,i]
  Geno4<-Geno10[,Quartet]
  
  fileC<-paste0("./Data/Real_Data/Quartets/C/Genotype",i,".pat")
  fileH<-paste0("./Data/Real_Data/Quartets/H/Genotype",i,".pat")
  fileB<-paste0("./Data/Real_Data/Quartets/B/Genotype",i,".dat")
  fileR<-paste0("./Data/Real_Data/Quartets/R/Genotype",i,".pat")
  
  write.table(cbind(1,Geno4),file=fileC)
  write.table(cbind(1,Geno4),file=fileH)
  write.table(Geno4,file=fileB)
  write.table(cbind(1,Geno4),file=fileR)
  
}

