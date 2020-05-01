library(cmapR)
ds_path <- "GSE92742_Broad_LINCS_Level5_COMPZ.MODZ_n473647x12328.gctx"
col_meta_path <- "GSE92742_Broad_LINCS_sig_info.txt"
col_meta <- read.delim(col_meta_path, sep="\t", stringsAsFactors=F)
gene_path <- "Drug_reposition/GSE92742_Broad_LINCS_gene_info.txt"
gene_meta <- read.delim(gene_path, sep="\t", stringsAsFactors=F)
cells<-c("HCC515")
times<-c("6","24")
for(cell in cells){
  for(time in times){
      idx <- which(col_meta$cell_id == cell & col_meta$pert_time == time & col_meta$pert_iname =="moexipril")
      sig_ids <- col_meta$sig_id[idx]
      my_ds <- parse.gctx(ds_path, cid=sig_ids)
      sig_ids <- col_meta$sig_id[idx]
      my_ds <- parse.gctx(ds_path, cid=sig_ids)
      gene.data<-as.data.frame(my_ds@mat)
      colnames(gene.data)<-"score"
      gene.data$geneid=row.names(gene.data)
      data<-merge(gene.data,gene_meta,by.x="geneid",by.y="pr_gene_id")
      data_for_drug<-data.frame(geneSymbol=data$pr_gene_symbol,score=data$score)
      file_name<-paste(cell,"_",time,"_data_for_drug.csv",sep = "")
      write.csv(data_for_drug,file=file_name,quote = F,row.names = F)
  }
}
