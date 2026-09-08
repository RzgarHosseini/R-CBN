#####################################################################################################################################################
#####################################################################################################################################################
### Functions ###

generateMatrixGenotypes <- function(g) {
  if (g > 20) {
    stop("This would generate more than one million genotypes")
  }
  f1 <- function(n) {
    lapply(seq.int(n), function(x) t(combn(n, x)))
  }
  genotNums <- f1(g)
  listOfVectors <- function(y) {
    lapply(unlist(lapply(y, function(x) {
      apply(x, 1, list)
    }), recursive = FALSE), function(m) m[[1]])
  }
  genotNums <- listOfVectors(genotNums)
  v <- rep(0, g)
  mat <- matrix(unlist(lapply(genotNums, function(x) {
    v[x] <- 1
    return(v)
  })), ncol = g, byrow = TRUE)
  mat <- rbind(rep(0, g), mat)
  colnames(mat) <- LETTERS[1:g]
  return(mat)
}


pathProbSSWM <- function(fitness, x) {
  genotypes <- generateMatrixGenotypes(x)
  indx <- matrix(0, nrow = 2^x, ncol = 1)
  for (k in 1:(2^x)) {
    for (j in 1:x) {
      indx[k, 1] <- indx[k, 1] + 2^(j - 1) * genotypes[k, j]
    }
  }
  perm <- permutations(x, x)
  prob <- numeric(dim(perm)[1])
  tot <- 0
  for (i in 1:dim(perm)[1]) {
    temp1 <- 1
    vec <- perm[i, ]
    geno <- matrix(0, nrow = (x + 1), ncol = x)
    for (j in 1:x) {
      for (k in (j + 1):(x + 1)) {
        geno[k, (vec[j])] <- 1
      }
    }
    genoIndx <- matrix(0, nrow = (x + 1), ncol = 1)
    for (j in 1:(x + 1)) {
      for (k in 1:x) {
        genoIndx[j, 1] <- genoIndx[j, 1] + 2^(k - 1) * geno[j, k]
      }
    }
    fitnessVec <- matrix(0, nrow = (x + 1), ncol = 1)
    for (j in 1:(x + 1)) {
      fitnessVec[j] <- fitness[which(indx == genoIndx[j])]
    }
    flag <- 0
    for (j in 2:(x + 1)) {
      if (fitnessVec[j] < fitnessVec[(j - 1)]) {
        flag <- 1
      }
    }
    if (flag == 0) {
      for (j in 1:x) {
        sn <- which(geno[j, ] == 0)
        n <- length(sn)
        s <- fitnessVec[(j + 1)] - fitnessVec[j]
        t <- 0
        for (k in 1:n) {
          ggeno <- geno[j, ]
          ggeno[(sn[k])] <- 1
          ggenoIndx <- 0
          for (l in 1:x) {
            ggenoIndx <- ggenoIndx + 2^(l - 1) * ggeno[l]
          }
          fitness2 <- fitness[which(indx == ggenoIndx)]
          s1 <- fitness2 - fitnessVec[j]
          if (s1 > 0) {
            t <- t + s1
          }
        }
        temp1 <- temp1 * (s / t)
      }
      prob[i] <- temp1
    }
  }
  gg <- sum(prob, na.rm = TRUE)
  prob <- prob / gg
  prob <- as.numeric(prob)
  prob[which(is.na(prob))] <- 0
  return(prob)
}


jensenShannonDivergence <- function(prob1, prob2) {
  d <- 0
  for (i in 1:length(prob1)) {
    if (prob1[i] > 0) {
      d <- d + prob1[i] * log2(prob1[i] / (0.5 * prob1[i] + 0.5 * prob2[i]))
    }
    if (prob2[i] > 0) {
      d <- d + prob2[i] * log2(prob2[i] / (0.5 * prob1[i] + 0.5 * prob2[i]))
    }
  }
  dv <- (d / 2)
  return(dv)
}


predictability <- function(prob, x) {
  tot <- 0
  for (i in 1:length(prob)) {
    if (sum(prob[i], na.rm = TRUE) > 0) {
      tot <- tot - prob[i] * log(prob[i])
    }
  }
  pred <- 1 - (tot / log(factorial(x)))
  return(pred)
}


#####################################################################################################################################################
#####################################################################################################################################################
Fitness<-as.matrix(readRDS("./Data/Simulated_Data/FitnessLandcapes.rds"))
## Fitness is matrix of dimension 128 by 100 encoding fitness of 2^7=128 binary genotypes on 100 representable fitness landscapes. 
## The set of 128 binary genotypes corresponding to the rows of the above matrix can be obtained by: AllGenotypes7<-generateMatrixGenotypes(7)
PathProbs7<-matrix(0,5040,100)
for (i in 1:100){
  PathProbs7[,i]<-pathProbSSWM(Fitness[,i],7)
}
## PathProbs7 is matrix of dimension 5040 by 100 encoding probability of all 7!=5040 mutational pathways of length n=7 on each of the 100 representable fitness landscapes.
## The set of 5040 pathways corresponding to the rows of the above matrix can be obtained by: AllPathways7 <- permutations(7, 7)

Predictability7<-numeric(100)
for (i in 1:100){
  Predictability7[i]<-predictability(PathProbs7[,i],7)
}
## Predictability7 encodes the SSWM-based predictability on each of the 100 fitness landscapes.


JSD7<-matrix(0,100,100)
for (i in 1:100){
  for (j in 1:100){
    JSD7[i,j]<-jensenShannonDivergence(PathProbs7[,i],PathProbs7[,j])
  }
}
## JSD7 encodes the pairwise Jensen-Shannon Divergence between the SSWM-based probability distributions on all pairs of the 100 representable fitness landscapes.

