#################################################################################################################
#################################################################################################################
Geno10<-read.table("./Data/Real_Data/Genotypes/Glioblastoma_Multiforme.dat")
Sample.Size<-dim(Geno10)[1]
Quartets<-combn(10,4)
N.Quartets<-choose(10,4)
nGenes<-4


#################################################################################################################
### Linux Version ###
#################################################################################################################
sink(file="./Codes/QuartetCBN/Step2(Linux).sh")

for (i in 1:N.Quartets){

  paste0("./Data/Real_Data/Quartets/C/Genotype",i,".pat")
  
  cat(paste0("sed -i '1d' ./Data/Real_Data/Quartets/C/Genotype",i,".pat\n"))
  cat(paste0("sed -i 's/^[^ ]* //' ./Data/Real_Data/Quartets/C/Genotype",i,".pat\n"))
  
  cat(paste0("sed -i '1d' ./Data/Real_Data/Quartets/H/Genotype",i,".pat\n"))
  cat(paste0("sed -i 's/^[^ ]* //' ./Data/Real_Data/Quartets/H/Genotype",i,".pat\n"))
  
  cat(paste0("sed -i '1d' ./Data/Real_Data/Quartets/B/Genotype",i,".dat\n"))
  cat(paste0("sed -i 's/^[^ ]* //' ./Data/Real_Data/Quartets/B/Genotype",i,".dat\n"))
  
  cat(paste0("sed -i '1d' ./Data/Real_Data/Quartets/R/Genotype",i,".pat\n"))
  cat(paste0("sed -i 's/^[^ ]* //' ./Data/Real_Data/Quartets/R/Genotype",i,".pat\n"))
  
  cat(paste0("sed -i '1i ",Sample.Size," ",(nGenes+1),"' ./Data/Real_Data/Quartets/C/Genotype",i,".pat\n"))
  cat(paste0("sed -i '1i ",Sample.Size," ",(nGenes+1),"' ./Data/Real_Data/Quartets/H/Genotype",i,".pat\n"))
  cat(paste0("sed -i '1i ",Sample.Size," ",(nGenes+1),"' ./Data/Real_Data/Quartets/R/Genotype",i,".pat\n"))
  
}

sink(file = NULL)



#################################################################################################################
### Mac Version ###
#################################################################################################################
sink(file="./Codes/QuartetCBN/Step2(Mac).sh")

for (i in 1:N.Quartets){
  
  paste0("./Data/Real_Data/Quartets/C/Genotype",i,".pat")
  
  cat(paste0("sed -i '' '1d' ./Data/Real_Data/Quartets/C/Genotype",i,".pat\n"))
  cat(paste0("sed -i '' 's/^[^ ]* //' ./Data/Real_Data/Quartets/C/Genotype",i,".pat\n"))
  
  cat(paste0("sed -i '' '1d' ./Data/Real_Data/Quartets/H/Genotype",i,".pat\n"))
  cat(paste0("sed -i '' 's/^[^ ]* //' ./Data/Real_Data/Quartets/H/Genotype",i,".pat\n"))
  
  cat(paste0("sed -i '' '1d' ./Data/Real_Data/Quartets/B/Genotype",i,".dat\n"))
  cat(paste0("sed -i '' 's/^[^ ]* //' ./Data/Real_Data/Quartets/B/Genotype",i,".dat\n"))
  
  cat(paste0("sed -i '' '1d' ./Data/Real_Data/Quartets/R/Genotype",i,".pat\n"))
  cat(paste0("sed -i '' 's/^[^ ]* //' ./Data/Real_Data/Quartets/R/Genotype",i,".pat\n"))
  
  cat(paste0("sed -i '' '1i\\'$'\\n''",Sample.Size," ",(nGenes+1),"' ./Data/Real_Data/Quartets/C/Genotype",i,".pat\n"))
  cat(paste0("sed -i '' '1i\\'$'\\n''",Sample.Size," ",(nGenes+1),"' ./Data/Real_Data/Quartets/H/Genotype",i,".pat\n"))
  cat(paste0("sed -i '' '1i\\'$'\\n''",Sample.Size," ",(nGenes+1),"' ./Data/Real_Data/Quartets/R/Genotype",i,".pat\n"))
  
}

sink(file = NULL)





