all: pccc-test.Rout

ICD9_ICD10_comparability_public_use_ASCII.dat:
	unzip ../cdc-mcd-data/ICD9_ICD10_comparability_public_use_ASCII.ZIP -d .

codes.dat: data-clean.awk ICD9_ICD10_comparability_public_use_ASCII.dat
	./data-clean.awk ICD9_ICD10_comparability_public_use_ASCII.dat > codes.dat

pccc-test.Rout: codes.dat pccc-test.R
	R CMD BATCH pccc-test.R

clean:
	@echo "Nothing to do yet"
