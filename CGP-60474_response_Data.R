library(cmapR)
ds_path <- "GSE70138_Broad_LINCS_Level5_COMPZ_n118050x12328.gctx"
col_meta_path <- "GSE70138_Broad_LINCS_sig_info_2017-03-06.txt"
col_meta <- read.delim(col_meta_path, sep="\t", stringsAsFactors=F)
gene_path <- "GSE70138_Broad_LINCS_gene_info_2017-03-06.txt"
gene_meta <- read.delim(gene_path, sep="\t", stringsAsFactors=F)
idx <- which(col_meta$cell_id == "HCC515" & col_meta$pert_itime == "24 h" & col_meta$pert_iname == "CGP-60474")
sig_ids <- col_meta$sig_id[idx]
my_ds <- parse.gctx(ds_path, cid=sig_ids)
sig_ids <- col_meta$sig_id[idx]
my_ds <- parse.gctx(ds_path, cid=sig_ids)
gene.data<-as.data.frame(my_ds@mat)
gene.data$geneid=row.names(gene.data)
treatments<-colnames(gene.data)
treatments<-setdiff(treatments,"geneid")
data<-merge(gene.data,gene_meta,by.x="geneid",by.y="pr_gene_id")
data<-data[,c("pr_gene_symbol",treatments)]
new.data<-data[,c("pr_gene_symbol","LJP006_HCC515_24H:G05")]
colnames(new.data)<-c("Gene","Drug.response");
file_name<-paste("CGP-60474","_single_treatment_response_data.csv",sep = "")
write.csv(new.data,file=file_name,quote = F,row.names = F)

