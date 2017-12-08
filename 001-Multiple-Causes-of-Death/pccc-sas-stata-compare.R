# script to compare exact output between Stata, SAS, and the R version

# load dplyr as default base setdiff is very slow - must use dplyr!
# also dplyr setdiff functions slightly different than base setdiff - so it works better for my use.
library(dplyr)

## load/save data to environment as needed - make sure R dataframe looks like SAS and STATA dataframes
load('../MCOD_Validation_Data/MCOD_Test/mcod_test_ccc_R.Rda')
head(ccc_result)
r_data <- ccc_result
remove(ccc_result)

# load and resave to compact file
load("../MCOD_Validation_Data/MCOD_Test/mcod_test_ccc_SAS.rdata")
# saveRDS(mcod_test_ccc, "../MCOD_Validation_Data/MCOD_Test/mcod_test_ccc_SAS.rds")
# sas_data <- mcod_test_ccc
# remove(mcod_test_ccc)
sas_data <- readRDS("../MCOD_Validation_Data/MCOD_Test/mcod_test_ccc_SAS.rds")
head(sas_data)

# load and resave to compact file
# load("../MCOD_Validation_Data/MCOD_Test/mcod_test_ccc_stata.rdata")
# saveRDS(mcod_test_ccc_stata, "../MCOD_Validation_Data/MCOD_Test/mcod_test_ccc_stata.rds")
# stata_data <- mcod_test_ccc_stata
# remove(mcod_test_ccc_stata)
stata_data <- readRDS("../MCOD_Validation_Data/MCOD_Test/mcod_test_ccc_stata.rds")
head(stata_data)
gc()

# check column names - and fix discrepencies
as.matrix(colnames(r_data))
as.matrix(colnames(sas_data))
as.matrix(colnames(stata_data))

sas_data <- subset( sas_data, select = -num_ccc)
sas_data <- subset( sas_data, select = -pr1)
stata_data <- subset( stata_data, select = -num_ccc)

colnames(r_data) <- colnames(sas_data)
as.matrix(colnames(r_data))
as.matrix(colnames(sas_data))

# if column type doesn't match
# r_data <- transform(r_data, id = as.integer(id))

###############################################################################
# general function to determine which columns don't match R (r_data)
###############################################################################
check_r <- function(checkdf, csv_lbl) {
  identicalVars <-
    sapply(colnames(r_data), function(x){
      identical(r_data[[x]], checkdf[[x]])
    })

  mismatch_cols <- c(names(identicalVars[!identicalVars]))

  # too many columns to view easily, create instead a set of columnwise comparisons
  lapply(mismatch_cols, function(cn) {
    diffcols <- c('id', cn)
    checktmp <- checkdf[,diffcols]
    kidtmp <- r_data[,diffcols]
    varname <- paste0(csv_lbl, '_mismatch_', cn)

    assign(varname, merge(setdiff(kidtmp, checktmp),
                          setdiff(checktmp, kidtmp),
                          by.x = "id",
                          by.y = "id",
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
  sapply(colnames(r_data), function(x){
    identical(r_data[[x]], stata_data[[x]])
  })

# if all you are left with only "id" after running this is id, then everything matches
stata_mismatch_cols <- c('id', names(identicalVars[!identicalVars]))

stata_mismatch <- sas_data[,stata_mismatch_cols]
r_data_stata_mismatch <- r_data[,stata_mismatch_cols]

# run these two lines to see the differences - should combine into one data frame so you can view side by side
#setdiff(r_data_sas_mismatch, sas_mismatch)
#setdiff(sas_mismatch, r_data_sas_mismatch)

sas_merged <- merge(setdiff(r_data_sas_mismatch, sas_mismatch),
                    setdiff(sas_mismatch, r_data_sas_mismatch), by.x="id", by.y = "id", suffixes = c('_r', '_sas'))

# running setdiff over the entire data set is slower than running over specific columns
# also it is harder to see the differences (14 columns + 14 columns)
#t1 <- setdiff(r_data, sas_data)
#t2 <- setdiff(sas_data, r_data)
#sas_merged <- merge(t1, t2, by.x="id", by.y = "id", suffixes = c('_r', '_sas'))
