# R-CBN
---

## Authors:
Sayed-Rzgar Hosseini 

---

## Abstract
Cancer is an evolutionary disorder driven by stepwise accumulation of selectively advantageous mutations forming mutational pathways, characterization of which is essential for diagnosis, prognosis and treatment of cancer. Conjunctive Bayesian networks (CBN) are probabilistic graphical models that have enabled the inference of these pathways of cancer progression from genomic data. Previously, we showed that the CBN model can be used to estimate the predictability of cancer evolution as it is able to reflect the underlying cancer fitness landscapes directly from genotypic data. However, the reliability of the inferred pathway probability distributions has not yet been ascertained, which motivates the need for a robust inferential framework. Thus, in this study I have introduced the robust-CBN model (R-CBN) to fill this gap. By analyzing synthetic, simulated and real data, I have rigorously compared R-CBN with previous CBN models including CT-CBN, H-CBN, and B-CBN, and the results indicate a superior robustness of the R-CBN model in various settings. Furthermore, I have devised a dynamic programming approximation algorithm, which renders the model amenable to scalability. Thus, R-CBN has the potential to be broadly utilized as a reliable framework to infer cancer-driving evolutionary trajectories, and to distill mechanistic insights from cross-sectional cancer genomic data. <br>

---
## Prerequisites and Installation:

R-CBN is not an R package, but rather it is presented here as an R workflow, which requires the CT-CBN software developed originally at Prof. Beerenwinkel's lab. <br>
Furthermore, in this repository, the R workflows for the alternative CBN models, including CT-CBN, H-CBN and B-CBN are provided, which require their original softwares to be installed in advance. <br>

#### CT-CBN and H-CBN Softwares:
You can download the CT-CBN and H-CBN softwares and follow the installation instructions at: https://bsse.ethz.ch/cbg/software/ct-cbn.html <br>

#### BCBN Software:
You can download the R codes for the BCBN R at: https://bsse.ethz.ch/cbg/software/bcbn.html <br>
We have slightly debugged and updated the original BCBN codes, and presented it as an R-package called "rBCBN" that is available at: https://github.com/rockwillck/rBCBN/tree/main <br>
The "rBCBN" is necessary for the BCBN based workflow. <br>

$${\color{purple}Note:}$$ The CT-CBN software must be installed at the directory as the one where this repository is going to be located. <br>
Thus, the full address to the CT-CBN software should be "Full_Path_to_the_R-CBN_Repository"/ct-cbn-0.1.04b/ct-cbn. Otherwise, the address to the software in the following codes must be manually edited: <br>
Codes/17_QuartetRCBN_Execution.R <br>
Codes/21_CTCBN_Execution.R <br>
Codes/24_HCBN_Execution.R <br>
Codes/28_BCBN_Quantification.R <br>
Codes/Misc/QuintetRCBN_Execution.R <br>

---

## Data:
Three types of binary genotypic data including the synthetic data, simulated data, and the real TCGA-derived data are provided in this repository. <br>
Furthermore, the collection of unique transitively closed posets of size 4 and 5 are included. <br>

#### Synthetic Data
Based on whether mutual exclusivity is considered or not, the following two separate synthetic datasets are included: <br>
$${\color{blue}Data/Synthetic_Data/Genotypes/With_Mutual_Exclusivity}$$ <br>
$${\color{blue}Data/Synthetic_Data/Genotypes/Without_Mutual_Exclusivity}$$ <br>
Each dataset contains 219 binary genotype matrices each corresponding to one of the 219 unique transitively closed DAGs of size 4. <br>
Each matrix has 200 rows and 4 columns to represent 200 samples of binary genotypes of length 4. <br>
Data/Synthetic_Data/Genotypes/With_Mutual_Exclusivity
Data/Synthetic_Data/Genotypes/Without_Mutual_Exclusivity


#### Simulated Data
Data/Simulated_Data/Genotypes/High_Mutation_Rate
Data/Simulated_Data/Genotypes/Low_Mutation_Rate
Data/Simulated_Data/FitnessLandcapes.rds

#### Real Data
Data/Real_Data/Genotypes
Data/Real_Data/GeneNames



---

## Codes:
X
<img width="1579" height="504" alt="Screenshot 2026-09-21 at 8 24 15 PM" src="https://github.com/user-attachments/assets/d235accc-8304-46c5-99ff-b4ff988d7ba8" />

---

### Data Generation:
X

---

### Quartet-RCBN Workflow:
X

---

### Quintet-RCBN Workflow:
X

---

### Ensemble-RCBN Workflow:
X

---

### CT-CBN Workflow:
X

---

### H-CBN Workflow:
X

---

### B-CBN Workflow:
X

---

### Pathway Compatibility Analysis:
X

---

### Fitness Landscape Analysis:
X

---

## Citation

Sayed-Rzgar Hosseini. Robust and scalable inference of cancer progression pathways using Conjunctive Bayesian Networks. bioRxiv 2025.07.15.663924; doi: https://doi.org/10.1101/2025.07.15.663924

---

## License

- **[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)**

