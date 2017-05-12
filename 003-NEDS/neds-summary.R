# neds-summary.R

library(dplyr)

files <- lapply(list.files(pattern = "*.rds"), readRDS)

results <-
  dplyr::bind_rows(files)

colSums(results)

SUBJECTS <- sum(results$subjects)

results %>%
  summarise_all(sum) %>%
  summarise_all(funs(./SUBJECTS)) %>%
  print.data.frame

