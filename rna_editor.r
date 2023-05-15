library(rnaEditr)
rnaedit_df <- read.csv("/home/azureuser/RNA_editing/output.csv", header = T)
data(rnaedit_df)
rnaedit_df[1:3, 1:3]
pheno_df <- readRDS(
  system.file(
    "extdata",
    "pheno_df.RDS",
    package = 'rnaEditr',
    mustWork = TRUE
  )
)
pheno_df[1:3, 1:3]




