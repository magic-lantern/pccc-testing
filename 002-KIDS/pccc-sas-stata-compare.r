# script to compare exact output between Stata, SAS, and the R version

## load/save data to environment as needed
save(kid_ccc, list = 'kid_ccc', file='kid_ccc.rdata')
load('kid_ccc.rdata')
head(kid_ccc)

load("kid_2009_core_ccc_sas.rdata")
sas_data <- kid_2009_core_ccc
remove(kid_2009_core_ccc)


load("kid_2009_core_ccc_stata.rdata")
stata_data <- kid_2009_core_ccc_stata
remove(kid_2009_core_ccc_stata)


as.matrix(colnames(kid_ccc))
as.matrix(colnames(sas_data))
as.matrix(colnames(stata_data))

sas_data <- subset( sas_data, select = -num_ccc)
stata_data <- subset( stata_data, select = -num_ccc)

colnames(kid_ccc) <- colnames(sas_data)
as.matrix(colnames(kid_ccc))
as.matrix(colnames(sas_data))

kid_ccc <- transform(kid_ccc, recnum = as.integer(recnum))

# find which columns don't match SAS
identicalVars <-
  sapply(colnames(kid_ccc), function(x){
    identical(kid_ccc[[x]], sas_data[[x]])
  })

sas_mismatch_cols <- c('recnum', names(identicalVars[!identicalVars]))

sas_mismatch <- sas_data[,sas_mismatch_cols]
kid_ccc_sas_mismatch <- kid_ccc[,sas_mismatch_cols]

# run these two lines to see the differences - should combine into one data frame so you can view side by side
setdiff(kid_ccc_sas_mismatch, sas_mismatch)
setdiff(sas_mismatch, kid_ccc_sas_mismatch)

# find which columns don't match STATA
identicalVars <-
  sapply(colnames(kid_ccc), function(x){
    identical(kid_ccc[[x]], stata_data[[x]])
  })

stata_mismatch_cols <- c('recnum', names(identicalVars[!identicalVars]))

stata_mismatch <- stata_data[,stata_mismatch_cols]
kid_ccc_stata_mismatch <- kid_ccc[,stata_mismatch_cols]
# run these two lines to see the differences - should combine into one data frame so you can view side by side
setdiff(kid_ccc_stata_mismatch, stata_mismatch)
setdiff(stata_mismatch, kid_ccc_stata_mismatch)

