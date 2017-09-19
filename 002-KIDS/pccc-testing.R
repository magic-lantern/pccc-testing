# Preferable method for running this script
#
# 1. open cmd.exe
# 2. navigate to directory with this file
# 3. "C:\Programs Files\R\R-3.3.3\bin\R.exe" CMD BATCH --vanilla pccc-testing.R
# 4. Review the pccc-testing.Rout file.

# pccc test using the KID09 data

date()

library(readr, lib.loc = "C:/R-site-library/")
library(dplyr, lib.loc = "C:/R-site-library/")
library(tidyr, lib.loc = "C:/R-site-library/")
library(pccc,  lib.loc = "C:/R-site-library/")

# read in the KID09 Data
kid9cols <- read_csv("C:/HCUPData/KID/KID09_core_columns.csv")
# Load ASCII Core file
kid9core <- read_fwf("C:/HCUPData/KID/KID_2009_Core.ASC",
                     fwf_positions(
                       start = kid9cols$start,
                       end = kid9cols$end,
                       col_names = tolower(kid9cols$name)),
                     col_types = paste(rep("c", nrow(kid9cols)), collapse = ""))

table(kid9core$year)

# select id(recnum), dx(24-28), ecode(74-77) and proc(106-120) columns only
# kid9core <- kid9core[,c(2,24:48,74:77,106:120)]

dim(kid9core)
n_distinct(kid9core$recnum)

system.time({
  kid_ccc <-
    ccc(kid9core[, c(2, 24:48, 74:77, 106:120)],
        id      = recnum,
        dx_cols = vars(starts_with("dx"), starts_with("ecode")),
        pc_cols = vars(starts_with("pr")),
        icdv    = 09)
})

kid_ccc

sum_results <- dplyr::summarize_at(kid_ccc, vars(-recnum), sum) %>% print.data.frame
dplyr::summarize_at(kid_ccc, vars(-recnum), mean) %>% print.data.frame

# this is the results from the SAS run - output from this R script should match exactly
# will only match when run against the full dataset
sas_sums = tibble(
  Neuromuscular = 112619L,
  CVD = 116094L,
  Respiratory = 47942L,
  Renal = 60456L,
  GI = 99462L,
  Hemato_immu = 79081L,
  Metabolic = 55830L,
  Congeni_genetic = 81622L,
  Malignancy = 80360L,
  Neonatal = 58608L,
  Tech_dep = 129164L,
  Transplant = 18342L
)

# don't have validated number for ccc_flag column
sum_results2 <- subset( sum_results, select = -ccc_flag)

identicalVars <-
  sapply(colnames(sum_results2), function(x){
    identical(sum_results2[[x]], sas_sums[[x]])
  })

mismatch <- names(identicalVars[!identicalVars])
print("R version: ")
print(sum_results2[mismatch])
print("SAS version: ")
print(sas_sums[mismatch])

print(sessionInfo(), locale = FALSE)

# run this line to clear the environment - it's pretty large so might want to save
# rm(list=ls())
