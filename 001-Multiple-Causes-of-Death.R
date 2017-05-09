# Needed Packages
library(dplyr)
library(magrittr)

###############################################################################
# Data Extract and Formating
#
# unzip the data set into a temp directory
temp_dir <- tempdir()
unzip("cdc-mcd-data/ICD9_ICD10_comparability_public_use_ASCII.ZIP",
      exdir = temp_dir)

# scan in the data
mcd_data_path <- paste0(temp_dir, "/ICD9_ICD10_comparability_public_use_ASCII.dat")
mcd_raw_data  <- scan(mcd_data_path, what = character(), sep = "\n")

# There is a flag, column 441, Comparability Analysis Flag with two options:
# Blank : Record may be used toward comparability analyses
# Y     : Record should be excluded from comparability analysis
comparability_flag <- sapply(mcd_raw_data, substring, first = 441, last = 441)
table(comparability_flag)
mcd_raw_data <- mcd_raw_data[which(comparability_flag == " ")]

# Build the data set
mcd_data <- vector("list")

icd09_codes7 <- sapply(mcd_raw_data, substring, first = 162, last = 301, USE.NAMES = FALSE)
icd09_codes5 <- sapply(mcd_raw_data, substring, first = 341, last = 440, USE.NAMES = FALSE)

icd10_codes7 <- sapply(mcd_raw_data, substring, first = 449, last = 588, USE.NAMES = FALSE)
icd10_codes5 <- sapply(mcd_raw_data, substring, first = 589, last = 688, USE.NAMES = FALSE)

split_codes <- function(codes, prefix = "icd") {
  out <-
    lapply(codes, strsplit, split = " ") %>%
    unlist(recursive = FALSE) %>%
    lapply(function(x) x[x != ""]) %>%
    lapply(matrix, nrow = 1) %>%
    lapply(as.data.frame) %>%
    bind_rows
  names(out) <- paste0(prefix, seq(1, length(out)))
}

mcd_data <-
  bind_cols(split_codes(icd09_codes7, icd09_entity),
            split_codes(icd09_codes5, icd09_record),
            split_codes(icd10_codes7, icd10_entity),
            split_codes(icd10_codes5, icd10_record)) 

###############################################################################

