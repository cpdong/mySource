library("MCPcounter")
#
setwd("C:\\Users\\Chuanpeng\\Desktop\\TCGA\\TCGA_LIHC")
#
df<- read.table("TCGA_LIHC_salmon1.2.1_tximport_gene_tpm_matrix.txt", header=T,sep='\t', row.names=1)
rownames(df)<- substr(rownames(df), 0,15)
colnames(df)<- substr(colnames(df), 0,15)

resultS<- MCPcounter.estimate(df, featuresType=c("affy133P2_probesets","HUGO_symbols","ENTREZ_ID","ENSEMBL_ID")[4])
result<- t(resultS)
