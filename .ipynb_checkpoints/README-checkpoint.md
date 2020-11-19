# README

Thesis title: 
# "Comparative transcriptomics of floral development in barley and wheat"
***
Tasks
# 1. Text mining for flower development related genes
***
<img src="Workflow_Textmining_Geneseq.png"
     alt="Workflow of data retrieving for flower development related genes in barley and wheat."
     style="float: center;" />
Workflow
***
## 1.1 Create gen-set related to floral development in *Triticeae*:
#### 1.1.1 List and experiment methods to download and import pubmed abstract data in text-mining accessable format:
* EasyPubmed, RISmed, or direct download and parse xml into csv
* file **`Text_mining_methods`**: practice of batch-download of Pubmed article data with different R packages
    - packages: `RisMed`, `EasyPubmed`
#### 1.1.2 Use `EasyPubmed` to batch download all *Triticeae* article information
* file **`Triticeae_download`**: download of all *Triticeae* abstracts on 20.03.2020 and create a merged table of all the available articles with their PMIDs and abstracts
    - packages: `EasyPubmed`, `dplyr`
* file **`final_triticeae.tsv/.rds`**: final merged table of all the downloaded **45 618 Pubmed records** from 2020 until first publication ever
#### 1.1.3 Text mining
* format data into text-mineable format
* filter abstracts with keywords for flower development
* intersect the filtered list of PMIDs achieved with different keywords to reach final list of PMIDs
* file **`Triticeae_text_mining`**: actual text mining and filtering of corpus to create a joint list of PMIDs related to flower-development articles
    - packages: `tm, nlp, dplyr`
#### 1.1.4 Intersect the 3 dataset to gain final list of GeneIDs
* intersect Gene2Pubmed and TaxID+GeneID tables - to get a table with TaxIDs+GeneIDs+PMIDs
* intersect flower-PMIDs with TaxID+GeneID+PMIDs table - to reach final list of GeneIDs
* file **`Triticeae_gene_download`**: the intersection of the 3 above mentioned datasets to gain a single list of GeneIDs. This list will be used to batch download all the `fasta` files to map them 
    - packages: genbank-r, taxise, dplyr
## 1.2 Based on GeneIDs get gene sequences and other information from NCBI Genebank
#### 1.2.1 Batch download genbank information
#### 1.2.2 Map all sequences to reference genomes
* ?

# 2. Reanalyse example dataset using knowledge from RNA-seq practical

# 3. Reanalyse example dataset with different methods used by Daniel

# 4. Test selected flower-development related Gene-set on example datasets





