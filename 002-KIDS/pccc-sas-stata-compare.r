# script to compare exact output between Stata, SAS, and the R version

# load dplyr as default base setdiff is very slow - must use dplyr!
library(dplyr,  lib.loc = "C:/R-site-library/")

## load/save data to environment as needed - make sure R dataframe looks like SAS and STATA dataframes
#save(kid_ccc, list = 'kid_ccc', file='kid_ccc.rdata')
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

###############################################################################
# general function to determine which columns don't match R (kid_ccc)
###############################################################################
check_r <- function(checkdf, csv_lbl) {
  identicalVars <-
    sapply(colnames(kid_ccc), function(x){
      identical(kid_ccc[[x]], checkdf[[x]])
    })
  
  mismatch_cols <- c(names(identicalVars[!identicalVars]))
  
  # too many columns to view easily, create instead a set of columnwise comparisons
  lapply(mismatch_cols, function(cn) {
    diffcols <- c('recnum', cn)
    checktmp <- checkdf[,diffcols]
    kidtmp <- kid_ccc[,diffcols]
    varname <- paste0(csv_lbl, '_mismatch_', cn)

    assign(varname, merge(setdiff(kidtmp, checktmp),
                          setdiff(checktmp, kidtmp),
                          by.x = "recnum", 
                          by.y = "recnum",
                          suffixes = c('_r', paste0('_', csv_lbl))),
           envir = .GlobalEnv)
    write.csv(eval(parse(text = varname)), file=paste0(varname, ".csv"))
    print(paste(varname, ': ', nrow(eval(parse(text = varname)))))
    eval(parse(text = varname))
  })
}

sas_check_result <- check_r(sas_data, 'sas')
stata_check_result <- check_r(stata_data, 'stata')


###############################################################################
# alternative method to find which columns don't match SAS
###############################################################################
identicalVars <-
  sapply(colnames(kid_ccc), function(x){
    identical(kid_ccc[[x]], sas_data[[x]])
  })

sas_mismatch_cols <- c('recnum', names(identicalVars[!identicalVars]))

sas_mismatch <- sas_data[,sas_mismatch_cols]
kid_ccc_sas_mismatch <- kid_ccc[,sas_mismatch_cols]

# run these two lines to see the differences - should combine into one data frame so you can view side by side
#setdiff(kid_ccc_sas_mismatch, sas_mismatch)
#setdiff(sas_mismatch, kid_ccc_sas_mismatch)

sas_merged <- merge(setdiff(kid_ccc_sas_mismatch, sas_mismatch),
                    setdiff(sas_mismatch, kid_ccc_sas_mismatch), by.x="recnum", by.y = "recnum", suffixes = c('_r', '_sas'))

# running setdiff over the entire data set is slower than running over specific columns
# also it is harder to see the differences (14 columns + 14 columns)
#t1 <- setdiff(kid_ccc, sas_data)
#t2 <- setdiff(sas_data, kid_ccc)
#sas_merged <- merge(t1, t2, by.x="recnum", by.y = "recnum", suffixes = c('_r', '_sas'))
