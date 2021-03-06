library("DrInsight")

my_gene_info<-read.table(file="lung_gene_info.txt",sep="\t",header = T,quote = "")
my_drug_info<-read.table(file="lung_drug_info.txt",sep="\t",header = T,quote = "")
cmap.ref.profiles = get.cmap.ref(cmap.data.path = 'lung_rankMatrix.txt', 
                                 probe.to.genes = my_gene_info, drug.info = my_drug_info)
files<-list.files(path="./",pattern="[:alnum:]*data_for_drug.csv")
for(i in files){
data_for_drug=read.csv(file=i,header=T)
drug.ident.res = drug.ident(query.data = data_for_drug, cmap.ref.profiles = cmap.ref.profiles, repurposing.unit = "drug", connectivity = "negative")
res_file<-gsub("data_for_drug","drug",i)
write.csv(drug.ident.res$drug.pvals,file=res_file)
}
