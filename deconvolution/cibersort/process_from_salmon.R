setwd("C:\\Users\\Chuanpeng\\Desktop\\TCGA\\TCGA_PAAD\\GSVA")

ensg2symbol_matrix<- function (data) {
	d1<- data
	rownames(d1)<- substr(rownames(d1), 0,15)
	gene_info<- read.table("https://raw.githubusercontent.com/cpdong/mySource/master/gencode.v32.gene.info.txt", header=T, sep='\t', stringsAsFactors=FALSE)
	gene_info<- gene_info[which((gene_info$hgnc_symbol !='NA') & (gene_info$biotype =='protein_coding') ),]
	gene_info<- gene_info[,c(1,4)]
	d1<- d1[which(rownames(d1) %in% gene_info$id),]
	
	d1_new<- merge(gene_info, d1, by.x='id', by.y='row.names', all.y=T)
	d1_new<- d1_new[,-1];
	
	d1_new$hgnc_symbol<- factor(d1_new$hgnc_symbol)
	mydata<- aggregate(. ~ hgnc_symbol, data = d1_new, mean)
	mydata<- data.frame(mydata, row.names=1)
	return (mydata)
}

d1<- read.csv("TCGA_PAAD_salmon1.2.1_tximport_gene_tpm_matrix.txt", header=T, sep='\t', row.names=1, stringsAsFactors=FALSE)
exprs_file<- ensg2symbol_matrix(d1)
sampleID<- rownames(exprs_file)
data<- cbind(sampleID, exprs_file)
write.table(data, "TCGA_PAAD_cibersort_profile.txt", sep='\t', row.names=F)
#
