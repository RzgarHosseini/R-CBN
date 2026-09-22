#####################################################################################################################################################
#####################################################################################################################################################
### Functions ###
pathProbSSWM <- function(fitness, x) {
  genotypes <- generate_matrix_genotypes(x)
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

