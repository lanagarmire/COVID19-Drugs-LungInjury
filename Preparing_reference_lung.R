library(cmapR)
setwd("/home/hbing/data/Drug_reposition")
tissue<-"lung"
cell_data<-read.table(file="GSE70138_Broad_LINCS_cell_info_2017-04-28.txt",sep="\t",header = T,quote = "")
cell_ids<-which(cell_data$primary_site == tissue)
cell_names <- cell_data$cell_id[cell_ids]
ds_path <- "GSE70138_Broad_LINCS_Level5_COMPZ_n118050x12328.gctx"
col_meta_path <- "GSE70138_Broad_LINCS_sig_info_2017-03-06.txt"
col_meta <- read.delim(col_meta_path, sep="\t", stringsAsFactors=F)
idx <- which(col_meta$cell_id %in% cell_names & col_meta$pert_type == "trt_cp")
sig_ids <- col_meta$sig_id[idx]
my_ds <- parse.gctx(ds_path, cid=sig_ids)
myrank <- function(x){
  temp<-rank(-x,ties.method ="min")
  return(temp)
}
rank_matrix1<-apply(my_ds@mat,2,myrank)
rank_matrix1<-as.data.frame(rank_matrix1)

cell_data<-read.table(file="GSE92742_Broad_LINCS_cell_info.txt",sep="\t",header = T,quote = "")
cell_ids<-which(cell_data$primary_site == tissue)
cell_names <- cell_data$cell_id[cell_ids]
ds_path <- "GSE92742_Broad_LINCS_Level5_COMPZ.MODZ_n473647x12328.gctx"
col_meta_path <- "GSE92742_Broad_LINCS_sig_info.txt"
col_meta <- read.delim(col_meta_path, sep="\t", stringsAsFactors=F)
idx <- which(col_meta$cell_id %in% cell_names & col_meta$pert_type == "trt_cp")
sig_ids <- col_meta$sig_id[idx]
my_ds <- parse.gctx(ds_path, cid=sig_ids)
myrank <- function(x){
  temp<-rank(-x,ties.method ="min")
  return(temp)
}
rank_matrix2<-apply(my_ds@mat,2,myrank)
rank_matrix2<-as.data.frame(rank_matrix2)

rank_matrix<-cbind(rank_matrix1,rank_matrix2)
colnames(rank_matrix)<-gsub(":","_",colnames(rank_matrix))
cnames<-colnames(rank_matrix)
colnames(rank_matrix)<-1:length(cnames)
dcnames<-colnames(rank_matrix)
rank_matrix$probe_id<-row.names(rank_matrix)
rank_matrix <- rank_matrix[,c('probe_id', dcnames)]
filename<-paste("./",tissue,"_rankMatrix.txt",sep = "")
write.table(rank_matrix,file=filename,quote=FALSE,row.names = FALSE,sep = "\t")

gene_data<-read.table(file="GSE70138_Broad_LINCS_gene_info_2017-03-06.txt",sep="\t",header = T,quote = "")
my_gene_info<-gene_data[,1:2]
colnames(my_gene_info)<-c("ID","Gene.Symbol")
filename<-paste("./",tissue,"_gene_info.txt",sep = "")
write.table(my_gene_info,file=filename,quote=FALSE,row.names = FALSE,sep = "\t")

sig_data<-read.table(file="GSE70138_Broad_LINCS_sig_info_2017-03-06.txt",sep="\t",header = T,quote = "")
sig_data$sig_id<-gsub(":","_",sig_data$sig_id)
my_drug_info<-data.frame(instance_id=sig_data$sig_id,cmap_name=paste(sig_data$pert_iname,sig_data$pert_id,sep="_"),concentration..M=sig_data$pert_idose,duration..h=sig_data$pert_itime,cell2=sig_data$cell_id,catalog_name=sig_data$pert_id,treatment=paste(sig_data$pert_iname,"_",sig_data$sig_id,sep = ""))
my_drug_info1<-subset(my_drug_info,instance_id %in% cnames)

sig_data<-read.table(file="GSE92742_Broad_LINCS_sig_info.txt",sep="\t",header = T,quote = "")
sig_data$sig_id<-gsub(":","_",sig_data$sig_id)
my_drug_info<-data.frame(instance_id=sig_data$sig_id,cmap_name=paste(sig_data$pert_iname,sig_data$pert_id,sep="_"),concentration..M=sig_data$pert_idose,duration..h=sig_data$pert_itime,cell2=sig_data$cell_id,catalog_name=sig_data$pert_id,treatment=paste(sig_data$pert_iname,"_",sig_data$sig_id,sep = ""))
my_drug_info2<-subset(my_drug_info,instance_id %in% cnames)

my_drug_info<-rbind(my_drug_info1,my_drug_info2)
my_drug_info$instance_id<-1:length(my_drug_info$instance_id)
filename<-paste("./",tissue,"_drug_info.txt",sep = "")
write.table(my_drug_info,file=filename,quote=FALSE,row.names = FALSE,sep = "\t")


