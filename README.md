# R-CBN
---

## Authors:
Sayed-Rzgar Hosseini

---


## Abstract
Cancer is an evolutionary disorder driven by stepwise accumulation of selectively advantageous mutations forming mutational pathways, characterization of which is essential for diagnosis, prognosis and treatment of cancer. Conjunctive Bayesian networks (CBN) are probabilistic graphical models that have enabled the inference of these pathways of cancer progression from genomic data. Previously, we showed that the CBN model can estimate the predictability of cancer evolution by reflecting the underlying fitness landscapes. However, the reliability of the inferred pathway probability distributions has not yet been ascertained. Hence, here I introduce the robust-CBN framework (R-CBN) to ensure a reliable inference of cancer progression pathways from cross-sectional genomic data. Using synthetic, simulated and real data, I rigorously compared R-CBN with previous versions of the CBN model, including CT-CBN, H-CBN, and B-CBN. The results indicate a superior robustness of the R-CBN model in various settings, while it is still able to largely retain predictability. Hence, R-CBN is ready to be used as a reliable framework to distill mechanistic insights from genomic data, while it also has the potential to serve as a building block that inspires further methodological innovations in the field.

---
## CBN2Path R/Bioconductor Package
The analyses that are presented in the R-CBN paper [1], were performed using a sequential pipeline starting from the original C implementation of the CT-CBN model, followed by the R implementation of the R-CBN algorithm and the associated pathway analyses. 
However, in order to make the pipeline easier to follow and also to facilitate the furture applications of the R-CBN algorithm, we have recently integrated the R-CBN method along with the other CBN models, and all the necessary R functions facilitating quantification, analysis and visualization of cancer progression pathways, in a new R package named **CBN2Path** [2], which be available on Bioconductor:

•	Software will be available from:  https://bioconductor.org/packages/CBN2Path

•	Archived software available from: https://doi.org/10.5281/zenodo.16791480

•	Source code available from: https://github.com/rockwillck/CBN2Path

Please run the vignette of the CBN2Path R package, which provides detailed information on how to use different CBN models (including R-CBN) and their associated pathway analysis functions.

---
## Data Folders
The synthetic, simulated and real datasets used in the R-CBN paper [1] are available in this github repository as three separate folders as follows:

### Synethtic data
The synthetic data includes two subfolders: 

1. **Without_Mutual_Exclusivity**: the genotype data does not include patterns of mutual exclusivity.

2. **With_Mutual_Exclusivity**: the genotype data does includes patterns of mutual exclusivity.

Each subfolder includes 219 genotype data files, and file stores a binary matrix with 200 rows (samples) and 4 columns (mutations). Each genotype file represents one of the 219 unique (transitively-closed) DAGs of restrictions. The genotypes in these files strictly respect the restrictions imposed by their corresting DAG.


### Simulated data
The simulated data includes two subfolders:

1. **DAG_Representable**: The genotypes are generated from evolutionary processes operating on a DAG representable fitness landscape.

2. **DAG_NonRepresentable**: The genotypes are generated from evolutionary processes operating on a DAG non-representable fitness landscape.

Each of the above subfolders also includes two nested subfolders:

1. **High_Mutation_Rate**: The genotypes are generated from evolutionary processes with high mutation rate (10^-5).

2. **Low_Mutation_Rate**: The genotypes are generated from evolutionary processes with low mutation rate (10^-6).

There are 100 genotype files in the DAG representable subfolders, while there are 111 genotypes in the DAG non-representable subfolders. Each genotype file stores a binary matrix with 200 rows (samples) and 7 columns (mutations).

Furthermore, under the Simulated_Data directory, two .rds files are included:

1. **FitnessLandcape_Representable.rds**: This stores a matrix with 128 rows (each corresponding to one of the 2^7=128 potential binary genotypes), and 100 colmns (each corresponding to one of the 100 representable fitness landscapes).
   
2. **FitnessLandcape_NON_Representable.rds**: This stores a matrix with 128 rows (each corresponding to one of the 2^7=128 potential binary genotypes), and 111 colmns (each corresponding to one of the 111 non-representable fitness landscapes).





### Real Data

## References

[1] Hosseini, S.-R. Robust inference of cancer progression pathways using Conjunctive Bayesian Networks. BioRxiv (2025). [In Review]

[2] Choi-Kim, W. & Hosseini, S.-R. CBN2Path: An R/Bioconductor package for the analysis of cancer progression pathways using Conjunctive Bayesian Networks. F1000Research [to appear] (2025).












