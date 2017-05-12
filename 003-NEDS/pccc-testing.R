args  <- commandArgs(TRUE)
START <- as.integer(args[1])
END   <- as.integer(args[2])

library(readr, lib.loc = "C:/R-site-library/")
library(dplyr, lib.loc = "C:/R-site-library/")
library(tidyr, lib.loc = "C:/R-site-library/")
library(pccc,  lib.loc = "C:/R-site-library/")

# There are 28,584,301 lines in the file
ned <-
  read_csv(file = "C:/HCUPData/NED_unencrypted/NEDS_2010_Core.csv",
           col_names = FALSE,
           col_types = paste(rep("c", 92), collapse = ""),
           skip = START - 1,
           n_max = END - START + 1)

ned <-
  dplyr::rename(ned,
                subject_id = X82,
                year = X91)
  
# ICD Codes in X23 through X37, X53 through X57

ccc_classifications <-
  ccc(ned, 
      subject_id,
      dx_cols = dplyr::vars(dplyr::num_range("X", c(23:37, 53:57))),
      pc_cols = dplyr::vars(dplyr::num_range("X", c(23:37, 53:57))),
      icdv = 9)

# saveRDS(ccc_classifications, file = paste0("ned_", START, "_", END, ".rds"))

# Save summary stats to disk
ccc_classifications %>%
  dplyr::summarize_at(vars(-subject_id), sum) %>%
  dplyr::mutate(subjects = nrow(ccc_classifications)) %>%
saveRDS(., file = paste0("ned_summary_", START, "_", END, ".rds"))


#dplyr::summarize_at(ccc_classifications, vars(-subject_id), mean) %>% print.data.frame

    
