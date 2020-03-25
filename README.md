# A pipeline to repurpose drugs for treating lung injury in COVID19

### Step 1
#### Download L1000 Connectivity Map perturbational profiles GSE70138 and GSE92742 from GEO
[GSE70138_Broad_LINCS_cell_info_2017-04-28.txt](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE70nnn/GSE70138/suppl/GSE70138_Broad_LINCS_cell_info_2017-04-28.txt.gz)
[GSE70138_Broad_LINCS_Level5_COMPZ_n118050x12328_2017-03-06.gctx](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE70nnn/GSE70138/suppl/GSE70138_Broad_LINCS_Level5_COMPZ_n118050x12328_2017-03-06.gctx.gz)
[GSE70138_Broad_LINCS_sig_info_2017-03-06.txt](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE70nnn/GSE70138/suppl/GSE70138_Broad_LINCS_sig_info_2017-03-06.txt.gz)
[GSE70138_Broad_LINCS_gene_info_2017-03-06.txt](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE70nnn/GSE70138/suppl/GSE70138_Broad_LINCS_gene_info_2017-03-06.txt.gz)
[GSE92742_Broad_LINCS_cell_info.txt](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE92nnn/GSE92742/suppl/GSE92742_Broad_LINCS_cell_info.txt.gz)
[GSE92742_Broad_LINCS_Level5_COMPZ.MODZ_n473647x12328.gctx](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE92nnn/GSE92742/suppl/GSE92742_Broad_LINCS_Level5_COMPZ.MODZ_n473647x12328.gctx.gz)
[GSE92742_Broad_LINCS_sig_info.txt](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE92nnn/GSE92742/suppl/GSE92742_Broad_LINCS_sig_info.txt.gz)

### Step 2 
#### Generating drug reference panel for lung from GSE70138 and GSE92742
`Rscript Preparing_reference_lung.R`
##### Output files:
```
lung_gene_info.txt #Gene information
lung_drug_info.txt #Drug information
lung_rankMatrix.txt #Gene rank list in lung cells with drug treatment
```

### Step 3 
#### Extracting differential expression profiles of genes from lung cells with inhibition of ACE2
`Rscript ACE2_inhibition_Data.R`
##### Output files:
```
A549_6_data_for_drug.csv #Differential expression of genes in A549 cell at 6 h after transfection of ACE2 inhibitor
A549_24_data_for_drug.csv #Differential expression of genes in A549 cell at 24 h after transfection of ACE2 inhibitor 
HCC515_6_data_for_drug.csv #Differential expression of genes in HCC515 cell at 6 h after transfection of ACE2 inhibitor
HCC515_24_data_for_drug.csv #Differential expression of genes in HCC515 cell at 24 h after transfection of ACE2 inhibitor
```

### Step 4 
#### Drug reposition analysis
`Rscript Drug_reposition.R`
##### Output files:
```
A549_6_drug.csv #Drugs for A549 cell at 6 h after transfection of ACE2 inhibitor
A549_24_drug.csv #Drugs for A549 cell at 24 h after transfection of ACE2 inhibitor 
HCC515_6_drug.csv #Drugs for HCC515 cell at 6 h after transfection of ACE2 inhibitor
HCC515_24_drug.csv #Drugs for HCC515 cell at 24 h after transfection of ACE2 inhibitor
```
