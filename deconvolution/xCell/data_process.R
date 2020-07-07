dir="C:\\Users\\Chuanpeng\\Desktop\\ttt"
pre_file="95RNAseq_salmon1.2.1_tximport_gene_tpm_matrix.txt"
out_file="95RNAseq_tpm_xCell_input.txt"
#profile_id='geneid';# geneid=Ensembl ID,geneSymbol=geneSymbol, entrezid=entrezgene_id
#
setwd(dir)
data<- read.csv(pre_file, header=T, sep='\t', row.names=1, stringsAsFactors=FALSE)
rownames(data)<- substr(rownames(data),0,15)
id<- read.table("https://raw.githubusercontent.com/cpdong/mySource/master/deconvolution/xCell/xCell_used_genes.txt", header=T, sep='\t', stringsAsFactors=FALSE)
id<-id[which(id$geneid !='NA'),]
data1<- data[which(rownames(data) %in% id$geneid),]

data2<- merge(id, data1, by.x='geneid', by.y='row.names', all.y=T)
#colnames(data2)[1]<- "sample"
data2$geneid<- NULL
write.table(data2, paste(out_file), row.names=F, quote=F, sep='\t')
#
