# Packages
library(pccc)
library(dplyr)   
library(tictoc)  # timing tools
library(qwraps2)

# Data import
# data in file:
#   cause (underlying cause of death, ICD-9)
#   recax1-recax20 (axis conditions, ICD-9)
#   uc10 (underlying cause of death, ICD-10)
#   rax10_1-rax10_20 (axis conditions, ICD-10)
tic()
dat <- readRDS("C:/HCUPData/MCOD/mcod_icd_9_10.rds") %>%
       dplyr::mutate(id = seq_along(cause))
dat <- dat[colnames(dat)[c(ncol(dat),1:ncol(dat) - 1)]]
toc()

# Run ccc on the ICD-9 codes
tic()
icd09_results <-
  ccc(dat,
      id = id,
      dx_cols = dplyr::vars(matches("recax|cause")),
      icdv = 9)
toc()

icd09_pct <- dplyr::summarize_at(icd09_results, vars(-recnum), sum) %>% print.data.frame
dplyr::summarize_at(icd09_results, vars(-id), mean) %>% print.data.frame

# Run ccc on the ICD-10 codes
tic()
icd10_results <-
  ccc(dat,
      id = id,
      dx_cols = dplyr::vars(matches('rax10|uc10')),
      icdv = 10)
toc()

icd10_pct <- dplyr::summarize_at(icd10_results, vars(-recnum), sum) %>% print.data.frame
dplyr::summarize_at(icd10_results, vars(-id), mean) %>% print.data.frame


saveRDS(icd09_results, file = "mcod_icd09_results.rds")
saveRDS(icd10_results, file = "mcod_icd10_results.rds")

print(sessionInfo(), locale = FALSE)


save(dat, icd09_results, icd10_results, file = "icd09_v_icd10.RData")