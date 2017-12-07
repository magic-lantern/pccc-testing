date()

library(readr)
library(dplyr)
library(tidyr)
library(pccc)
library(tictoc)
library(feather)

tic("timing: total time")
tic("timing: read data")
# read in the KID09 Data
kid9core <- read_feather('../pccc-magiclantern/sample_icd9_data.feather')
kid9core <- dplyr::mutate(kid9core, recnum = seq_along(dx1))
kid9core <- kid9core[colnames(kid9core)[c(ncol(kid9core),1:ncol(kid9core) - 1)]]
toc()
tic("timing: run CCC function")

# for performance reasons only look at fist 100k rows
kid9core <- head(kid9core, 100000)

system.time({
  kid_ccc <-
    ccc(kid9core[, c(1, 2:45)],
        id      = id,
        dx_cols = dplyr::starts_with("dx"),
        pc_cols = dplyr::starts_with("pc"),
        icdv    = 09)
})

kid_ccc

sum_results <- dplyr::summarize_at(kid_ccc, vars(-recnum), sum) %>% print.data.frame
dplyr::summarize_at(kid_ccc, vars(-recnum), mean) %>% print.data.frame

toc()

###############################################################################

tic("timing: checking restults")

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
toc()
toc()
# run these lines to clear the environment - delete and garbage collect
# rm(list=ls())
# gc()


#library(microbenchmark)
#x = runif(100)
#mbm <- microbenchmark(
#  f(),
#  times = 10
#)

#mbm

#library(ggplot2)
#autoplot(mbm)

library(Rcpp)
source("src/ccc.cpp")
.Call('_pccc_test_ccc', PACKAGE = 'pccc')


library(stringr)

pr <- select(kid9core[, c(2, 24:48, 74:77, 106:120)], sapply("pr", starts_with))


require(dplyr)
require(stringi)

# faster version for my usecase than https://stackoverflow.com/questions/17288222/r-find-value-in-multiple-data-frame-columns
search_df = function(df, search_term){
  apply(df, 1, function(r){
    any(stri_detect_fixed(r, search_term))
  }) %>% subset(df, .)
}

search_df(pr, "336")

# https://stackoverflow.com/questions/17288222/r-find-value-in-multiple-data-frame-columns
# end




















library(pccc)
library(testthat)
for (icd_code in 9:10) {
  for (x in 1:1000) {
    row <- "neuromusc"
    dx <- get_codes(icd_code)[row,]$dx
    dx_sample <- sample(dx, 1)
    result <- ccc(dplyr::data_frame(id = 'a',
                                    dx1 = dx_sample),
                  id      = id,
                  dx_cols = dplyr::starts_with("dx"),
                  icdv    = icd_code)
    test_that(paste0("Checking that dx code drawn from '", row, "' sets only that one category to true."), {
      expect_true(result[row] == 1)
    })

    if (!(row %in% c('tech_dep', 'transplant'))) {
      # look at other columns - should all be 0 except these 4
      tmp <- result[,!names(result) %in% c(row, 'id', 'tech_dep', 'transplant', 'ccc_flag')]
      test_that(paste0("Checking that dx code drawn from '", row, "' has all other categories set to false."), {
        expect_true(all(tmp == 0))
      })
    }

    # not all categories have procedure codes
    pc <- get_codes(icd_code)[row,]$pc
    if(length(pc) > 0) {
      result <- ccc(dplyr::data_frame(id = 'a',
                                      pc1 = sample(pc, 1)),
                    id      = id,
                    pc_cols = dplyr::starts_with("pc"),
                    icdv    = icd_code)
      test_that(paste0("Checking that pc code drawn from '", row, "' sets only that one category to true."), {
        expect_true(result[row] == 1)
      })

      if (!(row %in% c('tech_dep', 'transplant'))) {
        # look at other columns - should all be 0 except these 4
        tmp <- result[,!names(result) %in% c(row, 'id', 'tech_dep', 'transplant', 'ccc_flag')]
        test_that(paste0("Checking that pc code drawn from '", row, "' has all other categories set to false."), {
          expect_true(all(tmp == 0))
        })
      }
    }
  }
}

ccc(dplyr::data_frame(id = 'a',
                      dx1 = 'E755'),
    id      = id,
    dx_cols = dplyr::starts_with("dx"),
    icdv    = 10)
