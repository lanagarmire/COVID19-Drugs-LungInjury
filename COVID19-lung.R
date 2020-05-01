library(DESeq2)
countData <-as.matrix(read.table(file="GSE147507_RawReadCounts_Human.tsv/GSE147507_RawReadCounts_Human.tsv",header=T,row.names = 1,sep="\t"))
condition <- factor(gsub("_\\d","",colnames(countData)))
colData <- data.frame(row.names=colnames(countData), condition)
dds <- DESeqDataSetFromMatrix(countData, DataFrame(condition), design= ~ condition )
dds <- DESeq(dds)

res <- results(dds, contrast=c("condition","Series15_COVID19Lung","Series15_HealthyLungBiopsy"))
data_for_drug<-data.frame(geneSymbol=row.names(res),score=res$stat)
data_for_drug<-na.omit(data_for_drug)
row.names(data_for_drug)<-1:nrow(data_for_drug)
write.csv(data_for_drug,file="Series15_COVID19Lung_data_for_drug.csv",quote = F,row.names = F)

