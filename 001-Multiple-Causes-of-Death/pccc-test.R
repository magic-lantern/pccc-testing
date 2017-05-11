# Packages
library(pccc)
library(readr)
library(dplyr)   
library(magrittr)
library(tictoc)  # timing tools
library(qwraps2)

# Data import
tic()
dat <-
  readr::read_csv("codes.dat", trim_ws = TRUE,
                  col_types = paste(rep("c", 83), collapse = "")) %>%
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

# Simple Summary Statistics
qwraps2::frmt(nrow(dat))

bind_rows(icd09_results %>% summarize_at(vars(-id), sum) %>% mutate(icdv = 9),
          icd10_results %>% summarize_at(vars(-id), sum) %>% mutate(icdv = 10)) %>%
print.data.frame

bind_rows(icd09_results %>% summarize_at(vars(-id), mean) %>% mutate(icdv = 9),
          icd10_results %>% summarize_at(vars(-id), mean) %>% mutate(icdv = 10)) %>%
print.data.frame

# Looking for the differences between the results of ICD 9 and ICD 10 runs
diffs <- Vectorize(function(x, y) {
  if(x == 0 & y == 0) {
    return("Both Negative")
  } else if (x == 0 & y == 1) {
    return("x negative, y positive")
  } else if (x == 1 & y == 0) {
    return("x positive, y negative")
  } else {
    return("Both positive")
  }
})

tic()
  diffs(as.matrix(icd09_results[, -1]), 
        as.matrix(icd10_results[, -1])) %>%
  table %>%
  print %>%
  prop.table
toc()


print(sessionInfo(), locale = FALSE)
