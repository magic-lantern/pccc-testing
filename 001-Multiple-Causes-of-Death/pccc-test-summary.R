# Packages
library(pccc)
library(readr)
library(dplyr)   
library(tictoc)  # timing tools
library(magrittr)
library(qwraps2)
library(survey)

load(file = "icd09_v_icd10.RData")

# Simple Summary Statistics
qwraps2::frmt(nrow(dat))

bind_rows(icd09_results %>% summarize_at(vars(-id), sum) %>% mutate(icdv = 9),
          icd10_results %>% summarize_at(vars(-id), sum) %>% mutate(icdv = 10)) %>%
print.data.frame

bind_rows(icd09_results %>% summarize_at(vars(-id), mean),
          icd10_results %>% summarize_at(vars(-id), mean)) %>%
print.data.frame


# Comparability Ratio
dsgn09 <- svydesign(ids = ~ 0, data = icd09_results)
dsgn10 <- svydesign(ids = ~ 0, data = icd10_results)
bigdsgn <- svydesign(ids = ~ 0, data = bind_rows(icd09_results, icd10_results, .id = "v"))

svymean( ~ Neuromuscular + CVD + Respiratory + Renal + GI + Hemato_immu + Metabolic + Congeni_genetric + Malignancy + Neonatal + Tech_dep + Transplant + ccc_flag, dsgn09)
svymean( ~ Neuromuscular + CVD + Respiratory + Renal + GI + Hemato_immu + Metabolic + Congeni_genetric + Malignancy + Neonatal + Tech_dep + Transplant + ccc_flag, dsgn10)
svyttest( Neuromuscular ~ v, bigdsgn)




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
