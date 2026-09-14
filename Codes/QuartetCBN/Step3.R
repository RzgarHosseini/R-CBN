
#################################################################################################################
#################################################################################################################
Geno10<-read.table("./Data/Real_Data/Genotypes/Glioblastoma_Multiforme.dat")
Sample.Size<-dim(Geno10)[1]
Quartets<-combn(10,4)
N.Quartets<-choose(10,4)
nGenes<-4


sink(file="./Codes/QuartetCBN/Step3.sh")

for (i in 1:N.Quartets){

  cat(paste0("mkdir ./Data/Real_Data/Quartets/C/Genotype",i,"\n"))
  cat(paste0("echo '",nGenes,"'>>./Data/Real_Data/Quartets/C/Genotype",i,".poset\n"))
  cat(paste0("echo '0'>>./Data/Real_Data/Quartets/C/Genotype",i,".poset\n"))
      
  cat(paste0("mkdir ./Data/Real_Data/Quartets/H/Genotype",i,"\n"))
  cat(paste0("mkdir ./Data/Real_Data/Quartets/R/Genotype",i,"\n"))
}
sink(file = NULL)

