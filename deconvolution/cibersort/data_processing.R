dir="C:\\Users\\Chuanpeng\\Downloads"
pre_file="TCGA_BRCA_salmon1.2.1_tximport_gene_tpm_matrix.txt"
out_file="TCGA_BRCA_tpm_547_LM22_gene.txt"
#profile_id='geneid';# geneid=Ensembl ID,geneSymbol=geneSymbol, entrezid=entrezgene_id
#
setwd(dir)
data<- read.csv(pre_file, header=T, sep='\t', row.names=1, stringsAsFactors=FALSE)
rownames(data)<- substr(rownames(data),0,15)
id<- read.table("https://raw.githubusercontent.com/cpdong/mySource/master/deconvolution/cibersort/LM22_ID_table.txt", header=T, sep='\t', stringsAsFactors=FALSE)
data1<- data[which(rownames(data) %in% id$geneid),]

data2<- merge(id, data1, by.x='geneid', by.y='row.names', all.y=T)
#colnames(data2)[1]<- "sample"
data2$geneid<- NULL
data2$entrezgene_id<- NULL
write.table(data2, paste(out_file), row.names=F, quote=F, sep='\t')
#
