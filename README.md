# R-CBN
---

## Authors:
Sayed-Rzgar Hosseini 

---

## Abstract
Cancer is an evolutionary disorder driven by stepwise accumulation of selectively advantageous mutations forming mutational pathways, characterization of which is essential for diagnosis, prognosis and treatment of cancer. Conjunctive Bayesian networks (CBN) are probabilistic graphical models that have enabled the inference of these pathways of cancer progression from genomic data. Previously, we showed that the CBN model can be used to estimate the predictability of cancer evolution as it is able to reflect the underlying cancer fitness landscapes directly from genotypic data. However, the reliability of the inferred pathway probability distributions has not yet been ascertained, which motivates the need for a robust inferential framework. Thus, in this study I have introduced the robust-CBN model (R-CBN) to fill this gap. By analyzing synthetic, simulated and real data, I have rigorously compared R-CBN with previous CBN models including CT-CBN, H-CBN, and B-CBN, and the results indicate a superior robustness of the R-CBN model in various settings. Furthermore, I have devised a dynamic programming approximation algorithm, which renders the model amenable to scalability. Thus, R-CBN has the potential to be broadly utilized as a reliable framework to infer cancer-driving evolutionary trajectories, and to distill mechanistic insights from cross-sectional cancer genomic data. <br>

---
## 1. Prerequisites and Installation:

R-CBN is not an R package, but rather it is presented here as an R workflow, which requires the CT-CBN software developed originally at Prof. Beerenwinkel's lab. <br>

#### 1.1. CT-CBN and H-CBN Softwares:
You can download the CT-CBN and H-CBN softwares and follow the installation instructions at: https://bsse.ethz.ch/cbg/software/ct-cbn.html <br>

$${\color{red}Note:}$$ The CT-CBN software must be installed at the same directory as the one where this repository is going to be located. <br>
Thus, the full address to the CT-CBN software should be "Full_Path_to_the_R-CBN_Repository"/ct-cbn-0.1.04b/ct-cbn. Otherwise, the address to the software in the following codes must be manually edited: <br>
- Codes/17_QuartetRCBN_Execution.R <br>
- Codes/21_CTCBN_Execution.R <br>
- Codes/24_HCBN_Execution.R <br>
- Codes/28_BCBN_Quantification.R <br>
- Codes/Misc/QuintetRCBN_Execution.R <br>

#### 1.2. BCBN Software:
You can download the BCBN R codes at: https://bsse.ethz.ch/cbg/software/bcbn.html <br>
We have slightly debugged and updated the original BCBN code, and presented it as an R-package called "rBCBN" that is available at: https://github.com/rockwillck/rBCBN/tree/main <br>
The "rBCBN" is necessary for the BCBN based workflow. <br>

---

## 2. Data:
Three types of binary genotypic data including the synthetic data, simulated data, and the real TCGA-derived data are provided in this repository. <br>
Furthermore, the collection of unique transitively closed posets of size 4 and 5 are included. <br>

#### 2.1. Synthetic Data
The following two separate synthetic datasets are included, which differ based on whether mutual exclusivity is considered or not: <br>
- $${\color{blue}Data/Synthetic\\_Data/Genotypes/With\\_Mutual\\_Exclusivity}$$ <br>
- $${\color{blue}Data/Synthetic\\_Data/Genotypes/Without\\_Mutual\\_Exclusivity}$$ <br>


Each dataset contains 219 binary genotype matrices each corresponding to one of the 219 unique transitively closed DAGs of size 4. <br>
Each matrix has 200 rows and 4 columns to represent 200 samples of binary genotypes of length 4. <br>
The codes generating these synthetic data are presented and discussed in section **"3.1. Data Generation"** below. <br>

#### 2.2. Simulated Data
The simulated data includes 100 representable fitness landscape each representing a given DAG of restrictions between 7 mutations. <br>
The fitness landscape information is included in the file below, which is summarized as a 128 by 100 matrix, each element of which represents the fitness of one of the 2^7=128 binary genotypes of length 7 on one of these 100 fitness landscapes.  <br>
- $${\color{blue}Data/Simulated\\_Data/FitnessLandcapes.rds}$$ <br>

From each of these 100 fitness landscapes, 200 binary genotypes of length 7 has been generated through evolutionary simulations (discussed in ref #19 in the manuscript) under two different scenarios: <br>
i) high mutation rate (10^-5) and fast detection regime, which has resulted in the following 100 genotype files: <br> 
- $${\color{blue}Data/Simulated\\_Data/Genotypes/High\\_Mutation\\_Rate}$$ <br>

ii) low mutation rate (10^-6) and slow detection regime, which has resulted in the following 100 genotype files: <br>
- $${\color{blue}Data/Simulated\\_Data/Genotypes/Low\\_Mutation\\_Rate}$$ <br>

For the details of how these fitness landscapes are created and how the genotypes are simulated, please check the reference #19 in the manuscript. <br> 


#### 2.3. Real Data
The binary genotypes for 15 cancer types in TCGA data are provided in the following dataset: <br>
- $${\color{blue}Data/Real\\_Data/Genotypes}$$ <br>

The genotypes are binary vectors of length 10, which are defined based the presence or absence of at least one non-silent genetic alterations in 10 most frequently mutated driver genes, which are cancer-type specific and whose names are listed in the following files: <br>  
- $${\color{blue}Data/Real\\_Data/GeneNames}$$ <br>

For further details about these TCGA-derived dataset, please check the reference #10 in the manuscript. <br> 


#### 2.4. Posets
The 219 unique transitively-closed DAGs of size n=4 are provided in the following folder: <br> 
- $${\color{blue}Data/Posets4}$$ <br>

The 4231 unique transitively-closed DAGs of size n=5 are provided in the following folder: <br> 
- $${\color{blue}Data/Posets5}$$ <br>

The codes generating these poset files are presented and discussed in section **"3.1. Data Generation"** below. <br>


---

## 3. Codes:
The list of R codes required for running the R-CBN-based, CT-CBN-based, H-CBN-based and B-CBN-Based workflows for quantifying pathway probability distributions starting from a given binary genotype data is provided in the following excel sheet and its image below: <br>
- $${\color{blue}Codes/00\\_CodeList.xlsx}$$ <br>

The list of codes are color-coded and divided into 7 sections: <br>
- Part 1 (Yellow): Includes 11 .R files each containing a set of functions required for a specific step in one of the workflow. <br>
- Part 2 (Green): Includes 4 R scripts each containing a sequence of instructions resulting in generation of the data discussed above (creating poset files, generating synthetic data and mutating the original genotype data). <br>
- Part 3 (Red): Includes 4 R scripts each containing a sequence of instructions to implement the (Quartet) RCBN and the (Ensemble) RCBN algorithms. <br>
- Part 4 (black): Includes 3 R scripts each containing a sequence of instructions to implement the CT-CBN model. <br>
- Part 5 (gray): Includes 3 R scripts each containing a sequence of instructions to implement the H-CBN model. <br>
- Part 6 (blue): Includes 3 R scripts each containing a sequence of instructions to implement the B-CBN model. <br>
- Part 7 (purple): Includes 2 R scripts containing analyses of the inferred pathwaty probability distributions (pathway compatibility analysis and fitness-landscape-based analysis) <br>


<img width="1579" height="504" alt="Screenshot 2026-09-21 at 8 24 15 PM" src="https://github.com/user-attachments/assets/d235accc-8304-46c5-99ff-b4ff988d7ba8" />

---

### 3.1. Data Generation:
#### 3.1.1 Generating the poset files:
The set of poset files within the $${\color{blue}Data/Posets4}$$ and $${\color{blue}Data/Posets5}$$ directories have been obtained by running the $${\color{blue}Codes/12\\_Poset4Generation.R}$$ and $${\color{blue}Codes/13\\_Poset5Generation.R}$$ R scripts as follows: <br>
```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ Rscript --vanilla Codes/12_Poset4Generation.R $PWD
$ Rscript --vanilla Codes/13_Poset5Generation.R $PWD
```
Note that both of the above script files require the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}/Codes/02\\_PosetGeneration\\_Functions.R}$$. <br>

#### 3.1.2 Generating the synthetic data:
The set of synthetic genotype files within the $${\color{blue}Data/Synthetic\\_Data}$$ directory have been obtained by running the $${\color{blue}Codes/14\\_SyntheticDataGeneration.R}$$ R script as follows: <br>

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ Rscript --vanilla Codes/14_SyntheticDataGeneration.R $PWD
```
Note that the above script file requires the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}Codes/03\\_SyntheticDataGeneration\\_Functions.R}$$. <br>

#### 3.1.3 Creating erroneous genotype data:
To evaluate the robustness of the CBN models, creating genotype files containing genotypic errors of a given rate is necessary. <br>
The $\color{blue}{Codes/15\\_MutantGeneration.R}$ R script creates the erroneous genotype files each representing false positive and false negative errors of a given rate (both for synthetic and simulated data). <br>

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ Rscript --vanilla Codes/15_MutantGeneration.R $PWD
```
Note that the above script file requires the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}Codes/04\\_MutantGeneration\\_Function.R}$$. <br>

---

### 3.2. Quartet-RCBN Workflow:
The (Quartet) R-CBN work flow includes the following steps: <br>

#### Step 1: File Preparation:
In this step, all subsets of length 4 of a given genotype data are enumerated and stored in separate files, which are formatted such that they will be ready to be used in the next step (the execution step). <br>
This step is done using the $${\color{blue}Codes/16\\_QuartetRCBN\\_Preparation.R}$$ script file, which requires specification of: <br>
i) the full path to the R-CBN repository <br>
ii) the pathway to the folder within the R-CBN repository, where the genotype data of interest is located <br>
iii) the name of the file which includes the genotype data of interest <br>

Here is an example: Let's consider the genotype data in the $${\color{blue}Glioblastoma\\_Multiforme.dat}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes}$$ subfolder in this repository as the genotype data of interest: <br> 

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ subfolder="Data/Real_Data/Genotypes"
$ filename="Glioblastoma_Multiforme"
$ Rscript --vanilla Codes/16_QuartetRCBN_Preparation.R $PWD $subfolder $filename
```

The above program creates 210 data files located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\\_n4/R}$$ directory. Each of these files include genotypes of length 4, which are subsets of the corresponding genotypes of length 10 in the original data. <br>

#### Step 2: CT-CBN Execution:
In this step, the CT-CBN method is executed 219 times on each of the 210 genotype files generated in step 1. 
At each of the 219 iterations, CT-CBN considers one of the 219 posets in $${\color{blue}Data/Posets4}$$, and quantifies the parameters and likelihood under the given poset. <br>
This step is done using the $${\color{blue}Codes/17\\_QuartetRCBN\\_Execution.R}$$ script file, which requires specification of the same three arguments as in the step 1.

Following the same example as in step 1, we can execute step 2 as follows:

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ subfolder="Data/Real_Data/Genotypes"
$ filename="Glioblastoma_Multiforme"
$ Rscript --vanilla Codes/17_QuartetRCBN_Execution.R $PWD $subfolder $filename
```

The above program creates 210 data results files, which will be located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\\_n4/R}$$ directory. <br>
Each of these 210 results files inlcudes 219 lines each of which includes the estimated parameters and the likelihood corresponding to one of the 219 posets. <br>

#### Step 3: Pathway Probability Quantification:
In this step, which is done using the $${\color{blue}Codes/18\\_QuartetRCBN\\_Quantification.R}$$ script file, the pathway probabilities are quantified for each of the 210 subsets.  <br>
This step, for our example, will be executed as follows:  <br>

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ subfolder="Data/Real_Data/Genotypes"
$ filename="Glioblastoma_Multiforme"
$ Rscript --vanilla Codes/18_QuartetRCBN_Quantification.R $PWD $subfolder $filename
```

Note that the above script file requires the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}Codes/06\\_QuartetRCBN\\_Functions.R}$$. <br>
The final output will be a 210 by 24 pathway probability matrix, each element of which corresponds to a given pathway (columns) for a given quartet (rows). 
This matrix will be stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\\_n4/R}$$ directory, in this example.

---

### 3.3. Quintet-RCBN Workflow:
X

---

### 3.4. Ensemble-RCBN Workflow:
X

---

### 3.5. CT-CBN Workflow:
X

---

### 3.6. H-CBN Workflow:
X

---

### 3.7. B-CBN Workflow:
X

---

### 3.8. Pathway Compatibility Analysis:
X

---

### 3.9. Fitness Landscape Analysis:
X

---

## Citation

Sayed-Rzgar Hosseini. Robust and scalable inference of cancer progression pathways using Conjunctive Bayesian Networks. bioRxiv 2025.07.15.663924; doi: https://doi.org/10.1101/2025.07.15.663924

---

## License

- **[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)**

