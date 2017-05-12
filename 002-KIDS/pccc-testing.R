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

# select id(recnum), dx(24-28), ecode(74-77) and proc(106-120) columns only
kid9core <- kid9core[,c(2,24:48,74:77,106:120)]

dim(kid9core)

system.time({
  kid_ccc <-
    ccc(kid9core,
        id      = recnum,
        dx_cols = vars(starts_with("dx"), starts_with("ecode")),
        pc_cols = vars(starts_with("pr")),
        icdv    = 09)
})

kid_ccc
dplyr::summarize_at(test_09, vars(-recnum), sum) %>% print.data.frame
dplyr::summarize_at(test_09, vars(-recnum), mean) %>% print.data.frame

print(sessionInfo(), locale = FALSE)
