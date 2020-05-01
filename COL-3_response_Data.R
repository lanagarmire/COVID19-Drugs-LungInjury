library(cmapR)
ds_path <- "C:/Projects/Drug_reposition/GSE92742_Broad_LINCS_Level5_COMPZ.MODZ_n473647x12328.gctx"
col_meta_path <- "C:/Projects/Drug_reposition/GSE92742_Broad_LINCS_sig_info.txt"
col_meta <- read.delim(col_meta_path, sep="\t", stringsAsFactors=F)
gene_path <- "C:/Projects/Drug_reposition/GSE92742_Broad_LINCS_gene_info.txt"
gene_meta <- read.delim(gene_path, sep="\t", stringsAsFactors=F)
idx <- which(col_meta$cell_id == "HCC515" & col_meta$pert_time == "24" & col_meta$pert_iname == "COL-3")
sig_ids <- col_meta$sig_id[idx]
my_ds <- parse.gctx(ds_path, cid=sig_ids)
gene.data<-as.data.frame(my_ds@mat)
gene.data$geneid=row.names(gene.data)
treatments<-colnames(gene.data)
treatments<-setdiff(treatments,"geneid")
data<-merge(gene.data,gene_meta,by.x="geneid",by.y="pr_gene_id")
data<-data[,c("pr_gene_symbol",treatments)]
new.data<-data[,c("pr_gene_symbol","PCLB001_HCC515_24H:BRD-A59431241-001-02-9:2.5")]
colnames(new.data)<-c("Gene","Drug.response");
file_name<-paste("COL-3","_single_treatment_response_data.csv",sep = "")
write.csv(new.data,file=file_name,quote = F,row.names = F)


