# R-CBN
---

## Author:
Sayed-Rzgar Hosseini <br>
Department of Mathematical Sciences at the University of Texas at El Paso (UTEP) <br>
Email Addresses: razgar@gmail.com or shosseini3@utep.edu <br>

---

## Abstract
Cancer is an evolutionary disorder driven by stepwise accumulation of selectively advantageous mutations forming mutational pathways, characterization of which is essential for diagnosis, prognosis and treatment of cancer. Conjunctive Bayesian networks (CBN) are probabilistic graphical models that have enabled the inference of these pathways of cancer progression from genomic data. Previously, we showed that the CBN model can be used to estimate the predictability of cancer evolution as it is able to reflect the underlying cancer fitness landscapes directly from genotypic data. However, the reliability of the inferred pathway probability distributions has not yet been ascertained, which motivates the need for a robust inferential framework. Thus, in this study I have introduced the robust-CBN model (R-CBN) to fill this gap. By analyzing synthetic, simulated and real data, I have rigorously compared R-CBN with previous CBN models including CT-CBN, H-CBN, and B-CBN, and the results indicate a superior robustness of the R-CBN model in various settings. Furthermore, I have devised a dynamic programming approximation algorithm, which renders the model amenable to scalability. Thus, R-CBN has the potential to be broadly utilized as a reliable framework to infer cancer-driving evolutionary trajectories, and to distill mechanistic insights from cross-sectional cancer genomic data. <br>

<br>

---
## 1. Prerequisites and Installation:

R-CBN is not an R package, but rather it is presented here as an R workflow, which requires the CT-CBN software developed originally at Prof. Beerenwinkel's lab. <br>

#### 1.1. CT-CBN and H-CBN Softwares:
You can download the CT-CBN and H-CBN softwares and follow the installation instructions at: https://bsse.ethz.ch/cbg/software/ct-cbn.html <br>

$${\color{red}Note:}$$ The CT-CBN software must be installed at the same directory as the one where this repository is going to be located. I have already included the program folder (ct-cbn-0.1.04b) in this repository. You need to install the software according to the instructions provided in the README file that is located in the program folder. Thus, the full address to the CT-CBN software would be "Full_Path_to_the_R-CBN_Repository"/ct-cbn-0.1.04b/ct-cbn. <br>

The following programs directly use the CT-CBN softare. If you decide to change the location of the CT-CBN software in the above programs, you must edit the codes manually: <br> 
- Codes/17_QuartetRCBN_Execution.R <br>
- Codes/21_CTCBN_Execution.R <br>
- Codes/24_HCBN_Execution.R <br>
- Codes/28_BCBN_Quantification.R <br>
- Codes/Misc/QuintetRCBN_Execution.R <br>


#### 1.2. BCBN Software:
You can download the BCBN R codes at: https://bsse.ethz.ch/cbg/software/bcbn.html <br>
We have slightly debugged and updated the original BCBN code, and presented it as an R-package called "rBCBN" that is available at: https://github.com/rockwillck/rBCBN/tree/main <br>
The "rBCBN" is necessary for the BCBN based workflow. <br>

<br>
<br>

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

<br>
<br>

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

<br>
<br>

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

<br>
<br>

---

### 3.2. Quartet-RCBN Workflow:
The (Quartet) R-CBN workflow includes the following steps: <br>

#### Step 1: File Preparation:
In this step, all subsets of length 4 of a given genotype data are enumerated and stored in separate files, which are formatted such that they will be ready to be used in the next step (the execution step). <br>
This step is done using the $${\color{blue}Codes/16\\_QuartetRCBN\\_Preparation.R}$$ R script file, which requires specification of: <br>
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
The final output will be a 210 by 24 pathway probability matrix, each element of which corresponds to a given pathway (columns) for a given quartet (rows). <br>
This matrix will be stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\\_n4/R}$$ directory, in this example. <br>

<br>
<br>

---

### 3.3. Quintet-RCBN Workflow:
The codes for the Quintet-RCBN model is very similar to those of the Quartet-RCBN. The main differences are that here genotype subsets of size 5 are needed to be created and also 4231 posets of size 5 located at $${\color{blue}Data/Posets5}$$ must be considered. <br>
Note that the running time in the step 2 in the Quintet-RCBN is considerably higher (more than 30 times) than that of the Quartet-RCBN. <br>
Therefore, in my analyses, for quantifying pathways of length 5, I sticked to the approximation scheme in the Ensemble-RCBN method. <br>
I only used the Quintet-RCBN for checking the validity of the approximation used in the Ensemble-RCBN method (see table 1 in the manuscript) <br>

The three steps of the Quintet-RCBN workflow, for the previous example, can be summarized as follows: <br>

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ subfolder="Data/Real_Data/Genotypes"
$ filename="Glioblastoma_Multiforme"
$ Rscript --vanilla Codes/Misc/QuintetRCBN_Preparation.R $PWD $subfolder $filename
$ Rscript --vanilla Codes/Misc/QuintetRCBN_Execution.R $PWD $subfolder $filename
$ Rscript --vanilla Codes/Misc/QuintetRCBN_Quantification.R $PWD $subfolder $filename
```

The final output will be a 252 by 120 pathway probability matrix, each element of which corresponds to a given pathway (columns) for a given quartet (rows). <br>
This matrix will be stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\\_Quintet/R}$$ directory, in this example. <br>

<br>
<br>

---

### 3.4. Ensemble-RCBN Workflow:
The dynamic programming iterations in the Ensemble-RCBN algorithm can be executed for a given genotype matrix using the $${\color{blue}Codes/19\\_EnsembleRCBN\\_Quantification.R}$$ script file. <br>
This script file requires the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}Codes/07\\_EnsembleRCBN\\_Functions.R}$$. <br>
$${\color{red}Note:}$$ the algorithm is initiated using the outputs of the Quartet-RCBN workflow. Therefore, executing the Ensemble-RCBN codes must begin after all three steps of the Quartet-RCBN workflow are done for the given genotype data of interest. <br>

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ subfolder="Data/Real_Data/Genotypes"
$ filename="Glioblastoma_Multiforme"
$ Rscript --vanilla Codes/19_EnsembleRCBN_Quantification.R $PWD $subfolder $filename
```
The final outputs will be as follows: <br>
- For n=5 (first iteration): a $${10 \choose 5}=252$$ by $${5!=120}$$ pathway probability matrix stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_n5/R}$$ directory <br>
- For n=6 (first iteration): a $${10 \choose 6}=210$$ by $${6!=720}$$ pathway probability matrix stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_n6/R}$$ directory <br>
- For n=7 (first iteration): a $${10 \choose 7}=120$$ by $${7!=5040}$$ pathway probability matrix stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_n7/R}$$ directory <br>
- For n=8 (first iteration): a $${10 \choose 8}=45$$ by $${8!=40320}$$ pathway probability matrix stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_n8/R}$$ directory <br>
- For n=9 (first iteration): a $${10 \choose 9}=10$$ by $${9!=362880}$$ pathway probability matrix stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_n9/R}$$ directory <br>
- For n=10 (first iteration): a $${10 \choose 10}=1$$ by $${10!=3628800}$$ pathway probability matrix stored as $${\color{blue}PathProbR.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_n10/R}$$ directory <br>

$${\color{red}Note:}$$ Please see my comments on the running time of each of the above iterations of the algorithm at $${\color{blue}Codes/19\\_EnsembleRCBN\\_Quantification.R}$$. For the last two iterations (n=9 and n=10), parallelization on an HPC server will be necessary. 

<br>
<br>

---

### 3.5. CT-CBN Workflow:
The workflow for the other CBN models also includes the three steps of i) data preparation, ii) model execution, and finally iii) pathway probability quantification. <br>
The details of the file preparation only slightly differs for different CBN models, but the details of the model execution and pathway probability quantifications substantially differ among them, so each of workflow requires separate set of functions and R script files. <br>
Note that in the remaining workflows, all subsets of size n from n=4 to n=10 are executed sequentially  within the same script file. However, for CT-CBN, H-CBN and B-CBN they could be executed in parallel as there is no dependency between consecutive subset sizes for these models. <br> 
Importantly, however, the final user interface for each of these frameworks is very similar to the R-CBN one presented above. <br>

Let's stick to the same example for all the other workflows: <br>
```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ subfolder="Data/Real_Data/Genotypes"
$ filename="Glioblastoma_Multiforme"
```

#### Step 1: File Preparation:
This step is done by the $${\color{blue}Codes/20\\_CTCBN\\_Preparation.R}$$ R script. <br>
```shell
$ Rscript --vanilla Codes/20_CTCBN_Preparation.R $PWD $subfolder $filename
```

#### Step 2: Model Execution:
This step is done by the $${\color{blue}Codes/21\\_CTCBN\\_Execution.R}$$ R script. <br>
```shell
$ Rscript --vanilla Codes/21_CTCBN_Execution.R $PWD $subfolder $filename
```

#### Step 3: Pathway Probability Quantification:
This step is done by the $${\color{blue}Codes/22\\_CTCBN\\_Quantification.R}$$ R script, which requires the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}Codes/08\\_CTCBN\\_Function.R}$$. <br>
```shell
$ Rscript --vanilla Codes/22_CTCBN_Quantification.R $PWD $subfolder $filename
```

The final outputs will be as follows: <br>
- For any given $$N$$ between 4 and 10: a pathway probability matrix of dimention $${10 \choose N}$$ and $$N!$$ will be stored as $${\color{blue}PathProbC.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_nN/C}$$ directory <br>


<br>
<br>

---

### 3.6. H-CBN Workflow:
Similarly, the workflow for the H-CBN model can be summarized as follows:<br>

$${\color{red}Note:}$$ The simulated annealing algorithm in H-CBN model is initiated by a maximum-likelihood poset inferred by the CT-CBN model. Therefore, the H-CBN workflow must begin after step 2 of the CT-CBN workflow is finished for the genotype data of interest. <br> 

#### Step 1: File Preparation:
This step is done by the $${\color{blue}Codes/23\\_HCBN\\_Preparation.R}$$ R script. <br>
```shell
$ Rscript --vanilla Codes/23_HCBN_Preparation.R $PWD $subfolder $filename
```

#### Step 2: Model Execution:
This step is done by the $${\color{blue}Codes/24\\_HCBN\\_Execution.R}$$ R script. <br>
```shell
$ Rscript --vanilla Codes/24_HCBN_Execution.R $PWD $subfolder $filename
```

#### Step 3: Pathway Probability Quantification:
This step is done by the $${\color{blue}Codes/25\\_HCBN\\_Quantification.R}$$ R script, which requires the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}Codes/09\\_HCBN\\_Function.R}$$. <br>
```shell
$ Rscript --vanilla Codes/25_HCBN_Quantification.R $PWD $subfolder $filename
```

The final outputs will be as follows: <br>
- For any given $$N$$ between 4 and 10: a pathway probability matrix of dimention $${10 \choose N}$$ and $$N!$$ will be stored as $${\color{blue}PathProbH.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_nN/H}$$ directory <br>

<br>
<br>

---

### 3.7. B-CBN Workflow:
Finally, the workflow for the B-CBN model can be summarized as follows:<br>

#### Step 1: File Preparation:
This step is done by $${\color{blue}Codes/26\\_BCBN\\_Preparation.R}$$ R script. <br>
```shell
$ Rscript --vanilla Codes/26_BCBN_Preparation.R $PWD $subfolder $filename
```

#### Step 2: Model Execution:
This step is done by $${\color{blue}Codes/27\\_BCBN\\_Execution.R}$$ R script. <br>
```shell
$ Rscript --vanilla Codes/27_BCBN_Execution.R $PWD $subfolder $filename
```

#### Step 3: Pathway Probability Quantification:
This step is done by $${\color{blue}Codes/28\\_BCBN\\_Quantification.R}$$ R script, which requires the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$ and $${\color{blue}Codes/10\\_BCBN\\_Function.R}$$. <br>

```shell
$ Rscript --vanilla Codes/28_BCBN_Quantification.R $PWD $subfolder $filename
```

The final outputs will be as follows: <br>
- For any given $$N$$ between 4 and 10: a pathway probability matrix of dimension $${10 \choose N}$$ and $$N!$$ will be stored as $${\color{blue}PathProbB.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_nN/B}$$ directory <br>

$${\color{red}Note:}$$ Because at larger n the space of potential posets are extremely large, sometimes more than 10,000 among the 100,000 posets sampled by the B-CBN model are unique, which requires more than 10,000 iterations of the CT-CBN model for BCBN-based pathway quantifications. Therefore, expect unusually long running time for n=9 and n=10, unless you parallelize the code on an HPC server. <br>

<br>
<br>

---

### 3.8. Pathway Compatibility Analysis:
After finishing the above workflows, the resulting probability matrices can be further analyzed to measure various metrics such as predictability or the Jensen-Shannon Divergence using the functions defined in $${\color{blue}Codes/01\\_Basic\\_Functions.R}$$. <br>
Another important metric is the pathway compatibility score, which is calculated by constructing a pathway-genotype compatibility matrix on a given genotype data of interest.<br>
This is achieved using the set of functions defined in $${\color{blue}Codes/05\\_PathwayCompatibility\\_Functions.R}$$, which are used in the $${\color{blue}Codes/29\\_PathwayCompatibility\\_Analysis.R}$$ R script.<br>

For our example, we can run the following code:<br>
```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ subfolder="Data/Real_Data/Genotypes"
$ filename="Glioblastoma_Multiforme"
$ Rscript --vanilla Codes/29_PathwayCompatibility_Analysis.R $PWD $subfolder $filename
``` 
The above code, for any given $$N$$ between 4 and 10, generates a pathway-genotype compatibility matrix of dimension $${10 \choose N}$$ and $$N!$$, which will be stored as $${\color{blue}Path2Geno.RData}$$ file located in the $${\color{blue}Data/Real\\_Data/Genotypes/Glioblastoma\\_Multiforme\color{red}\\_nN}$$ directory <br>

Finally, in the above script, the spearman's rank correlation between the pathway probabilities and their corresponding compatibility scores will be calculated and stored in their corresponding directories specified in lines 61 to 64 in the $${\color{blue}Codes/29\\_PathwayCompatibility\\_Analysis.R}$$ R script. <br> 

<br>
<br>

---

### 3.9. Fitness Landscape Analysis:
The function implementing the evolutionary SSWM-based approach for quantifying pathway probability distributions for a given fitness landscape is provided in $${\color{blue}Codes/11\\_FitnessLandscapeSSWM\\_Functions.R}$$, which is used by the $${\color{blue}Codes/30\\_FitnessLandscapeSSWM\\_Analysis.R}$$ R script: <br>

```shell
$ cd Full_Path_to_the_R-CBN_Repository
$ Rscript --vanilla Codes/30_FitnessLandscapeSSWM_Analysis.R $PWD
``` 
In the above code, the pathway probability distributions and their predictability for the 100 fitness landscapes in the simulated data are quantified. <br>
Furthermore, as an example, the Jensen-Shannon Divergence between the probability distributions of any pair of any pair of fitness landscapes is calculated. <br>

<br>
<br>
---

## Citation

Sayed-Rzgar Hosseini. Robust and scalable inference of cancer progression pathways using Conjunctive Bayesian Networks. bioRxiv 2025.07.15.663924; doi: https://doi.org/10.1101/2025.07.15.663924

---
