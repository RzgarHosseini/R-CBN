# R-CBN
---

## Authors:
Sayed-Rzgar Hosseini

---


## Abstract
Cancer is an evolutionary disorder driven by stepwise accumulation of selectively advantageous mutations forming mutational pathways, characterization of which is essential for diagnosis, prognosis and treatment of cancer. Conjunctive Bayesian networks (CBN) are probabilistic graphical models that have enabled the inference of these pathways of cancer progression from genomic data. Previously, we showed that the CBN model can estimate the predictability of cancer evolution by reflecting the underlying fitness landscapes. However, the reliability of the inferred pathway probability distributions has not yet been ascertained. Hence, here I introduce the robust-CBN framework (R-CBN) to ensure a reliable inference of cancer progression pathways from cross-sectional genomic data. Using synthetic, simulated and real data, I rigorously compared R-CBN with previous versions of the CBN model, including CT-CBN, H-CBN, and B-CBN. The results indicate a superior robustness of the R-CBN model in various settings, while it is still able to largely retain predictability. Hence, R-CBN is ready to be used as a reliable framework to distill mechanistic insights from genomic data, while it also has the potential to serve as a building block that inspires further methodological innovations in the field.

---
The analyses in the R-CBN paper [1] were performed using a sequential pipeline starting from the original C implementation of the CT-CBN model, followed by the R implementation of the R-CBN algorithm and the associated pathway analyses. 
However, we have recently integrated the R-CBN method along with the other CBN models and all the functions necessary for quantification, analysis and visualization of cancer progression pathways in a new R package named **CBN2Path** [2], which be available on Bioconductor:

•	Source code available from: https://github.com/rockwillck/CBN2Path

•	Software will be available from:  https://bioconductor.org/packages/CBN2Path  

•	Archived software available from: https://doi.org/10.5281/zenodo.16791480 







