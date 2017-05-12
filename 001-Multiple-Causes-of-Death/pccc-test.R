# Packages
library(pccc)
library(readr)
library(dplyr)   
library(tictoc)  # timing tools
library(magrittr)
library(qwraps2)
library(survey)

# Data import
tic()
dat <-
  readr::read_csv("codes.dat", trim_ws = TRUE,
                  col_types = paste(rep("c", 84), collapse = "")) %>%
  dplyr::filter(is.na(Comp_flag)) %>%
  dplyr::mutate(id = seq_along(Comp_flag))
toc()

# Run ccc on the ICD-9 codes
tic()
icd09_results <-
  ccc(dat,
      id = id,
      dx_cols = dplyr::vars(dplyr::starts_with("ICD9")),
      pc_cols = dplyr::vars(dplyr::starts_with("ICD9")),
      icdv = 9)
toc()

# Run ccc on the ICD-10 codes
tic()
icd10_results <-
  ccc(dat,
      id = id,
      dx_cols = dplyr::vars(dplyr::starts_with("ICD10")),
      pc_cols = dplyr::vars(dplyr::starts_with("ICD10")),
      icdv = 10)
toc()

save(dat, icd09_results, icd10_results, file = "icd09_v_icd10.RData")

print(sessionInfo(), locale = FALSE)
